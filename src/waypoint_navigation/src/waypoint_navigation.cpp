
#include <string>
#include <sstream>

#include "math.h"

#include <ros/ros.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>
#include "geometry_msgs/PoseStamped.h"
#include "nav_msgs/Odometry.h"
#include "std_msgs/Int16.h"
#include "std_msgs/String.h"

#include <actionlib/client/simple_action_client.h>
#include <waypoint_navigation/goToWaypointAction.h>


template<typename T>
T getParam(ros::NodeHandle& n, const std::string& name, const T& defaultValue)
{
    T v;
    if (n.getParam(name, v))
    {
        ROS_INFO_STREAM("Found parameter: " << name << ", value: " << v);
        return v;
    }
    else
    {
        ROS_WARN_STREAM("Cannot find value for parameter: " << name << ", assigning default: " << defaultValue);
    }
    return defaultValue;
}

//using namespace std;

typedef actionlib::SimpleActionClient<waypoint_navigation::goToWaypointAction> ActionClient;



class WaypointNavigation {

private:
    std::string map_frame;
    std::string odom_frame;
    std::string base_frame;
    std::string audio_trigger_topic;
    std::string audio_status_topic;

    ros::NodeHandle _nh;

    int _max_waypoints;
    int _number_of_waypoints;

    std::vector<float>_waypoints_x;             // Vector of floats to hold coordinates of waypoints
    std::vector<float>_waypoints_y;
    std::vector<std::string>_waypoint_names;    // Vector of strings to hold waypoint names

    geometry_msgs::PoseStamped _current_destination;        // PoseStamped message to hold the current destination

    float _inflation_radius;                    // Radius around the goal point to inflate the goal

    ros::Publisher goal_pub;
    ros::Publisher audio_trigger_pub;
    ros::Subscriber audio_status_sub;

    bool _finished_audio;

    ActionClient _move_base_client;

    void audioStatusCB(const std_msgs::String::ConstPtr& msg);      // Callback to get status of audio track

    //void goalStatusCB(const waypoint_navigation::goToWaypointFeedback& feedback);


public:

    WaypointNavigation(ros::NodeHandle &nh);

    void destinationUpdate();                   // Main function to run and update the target destinations for robot

};


void WaypointNavigation::destinationUpdate() {

    bool stop_all_movement = false;

    // Loop over all waypoints
    for (int waypoint_number = 0; waypoint_number < _number_of_waypoints; waypoint_number++) {
        ROS_INFO_STREAM("Attempting Waypoint " << waypoint_number << "  X: " << _waypoints_x[waypoint_number] << "  Y: " << _waypoints_y[waypoint_number]);

        char attempt_number = 0;
        char abort_number = 0;
        bool stop_all_movement = false;

        // Fill PoseStamped message with required information
        _current_destination.header.stamp = ros::Time::now();
        _current_destination.header.frame_id = map_frame;
        _current_destination.pose.position.x = _waypoints_x[waypoint_number];
        _current_destination.pose.position.y = _waypoints_y[waypoint_number];
        _current_destination.pose.orientation.x = 0;
        _current_destination.pose.orientation.y = 0;
        _current_destination.pose.orientation.z = 0;
        _current_destination.pose.orientation.w = 1;
        //goal_pub.publish(_current_destination);

        // Create new goal for move_base (custom ActionClient message, see actionlib on ROS wiki [http://wiki.ros.org/actionlib])
        waypoint_navigation::goToWaypointGoal goal;

        goal.move_base_goal.header.stamp = ros::Time::now();
        goal.move_base_goal.header.frame_id = map_frame;
        goal.move_base_goal.goal_id.stamp = ros::Time::now();
        goal.move_base_goal.goal_id.id = waypoint_number;
        goal.move_base_goal.goal.target_pose = _current_destination;    // Assign target pose (PoseStamped msg) as current destination

        // Send goal to move_base
        _move_base_client.sendGoal(goal);/*
                                    ActionClient::SimpleDoneCallback(),
                                    ActionClient::SimpleActiveCallback(),
                                    boost::bind(&WaypointNavigation::goalStatusCB, this, _1, _2)
                                    );*/

        attempt_number += 1;

        ros::Time send_goal_time = ros::Time::now();
        ros::Time first_send_goal_time = send_goal_time;

        // Check if goal has been accepted by move_base
        // Resend goal if 5 seconds have passed, or abort movement if 20 seconds have passed
        while(_move_base_client.getState() == actionlib::SimpleClientGoalState::PENDING){
            ROS_INFO_STREAM("GOAL HAS YET TO BE PROCESSED BY move_base");
            ros::Duration(1).sleep();
            if(ros::Time::now().toSec() > (first_send_goal_time.toSec() + 20)){
                ROS_ERROR("20 SECONDS PASSED SINCE SENDING GOAL. ABORTING ALL MOVEMENT");
                stop_all_movement = true;
                break;
            }
            if(ros::Time::now().toSec() > (send_goal_time.toSec() + 5)){
                ROS_INFO_STREAM("5 SECONDS PASSED SINCE SENDING GOAL. RE-SENDING GOAL");
                _move_base_client.sendGoal(goal);
                send_goal_time = ros::Time::now();
            }

        }

        if(stop_all_movement == true){
            break;
        }

        // Check if goal was rejected. Attempt goal 3 times total. Break from all movement if rejected 3 times for current goal.
        while (_move_base_client.getState() == actionlib::SimpleClientGoalState::REJECTED) {
            if (attempt_number == 3) {
                ROS_ERROR("DESTINATION REJECTED. MAX NUMBER OF ATTEMPTS. ABORTING ALL MOVEMENT");
                stop_all_movement = true;
                break;
            }
            ROS_ERROR("DESTINATION WAS REJECTED, ATTEMPTING GOAL %d MORE TIMES", (3 - attempt_number));
            attempt_number += 1;
            _move_base_client.sendGoal(goal);
            ros::Duration(1).sleep();
        }

        ros::Duration(0.5).sleep();

        // If goal has been accepted by move_base then wait until goal is reached or aborted
        if(_move_base_client.getState() == actionlib::SimpleClientGoalState::ACTIVE){

            tf::TransformListener listener;         // Create a listener to get the transform from map->base_link
            tf::StampedTransform t_mapBase;

            tf::Vector3 t_mapBase_pose;             // Set inititial pose to (0,0)
            t_mapBase_pose.setX(0.0);
            t_mapBase_pose.setY(0.0);

            //ROS_INFO_STREAM("pose x: " << t_mapBase_pose.x() << " pose y: " << t_mapBase_pose.y());

            ROS_INFO_STREAM("waypoint min x: " << (_waypoints_x[waypoint_number] - _inflation_radius));
            ROS_INFO_STREAM("waypoint max x: " << (_waypoints_x[waypoint_number] + _inflation_radius));
            ROS_INFO_STREAM("waypoint min y: " << (_waypoints_y[waypoint_number] - _inflation_radius));
            ROS_INFO_STREAM("waypoint max y: " << (_waypoints_y[waypoint_number] + _inflation_radius));

            // If any of these are true then we haven't reached waypoint. Stay in loop until reached waypoint.
            while ( (t_mapBase_pose.x() < (_waypoints_x[waypoint_number] - _inflation_radius)) ||
                    (t_mapBase_pose.x() > (_waypoints_x[waypoint_number] + _inflation_radius)) ||
                    (t_mapBase_pose.y() < (_waypoints_y[waypoint_number] - _inflation_radius)) ||
                    (t_mapBase_pose.y() > (_waypoints_y[waypoint_number] + _inflation_radius))
                  ) {

                // Get transform from map->base_link
                try {
                    listener.waitForTransform(map_frame, base_frame, ros::Time(0), ros::Duration(0.5));
                    listener.lookupTransform(map_frame, base_frame, ros::Time(0), t_mapBase);
                }
                catch (tf::TransformException ex) {
                    ROS_ERROR("%s", ex.what());
                }

                t_mapBase_pose = t_mapBase.getOrigin();


                // Get status of move_base
                ROS_INFO_STREAM(_move_base_client.getState().toString().c_str());

                // Check if goal has been aborted. Attempt goal 3 times total. Break from all movement if aborted 3 times for current goal.
                if (_move_base_client.getState() == actionlib::SimpleClientGoalState::ABORTED) {
                    abort_number += 1;
                    if (abort_number == 3) {
                        ROS_ERROR("DESTINATION ABORTED. MAX NUMBER OF ABORTED GOALS REACHED. ABORTING ALL MOVEMENT");
                        stop_all_movement = true;
                        break;
                    }
                    ROS_ERROR("DESTINATION WAS ABORTED, ATTEMPTING GOAL %d MORE TIMES", (3 - abort_number));
                    _move_base_client.sendGoal(goal);
                }

                ros::Duration(1).sleep();

            }

            // Break from waypoint navigation if goal was rejected 3 times
            if (stop_all_movement == true) {
                break;
            }

            // Need to cancel goal so robot stops moving
            _move_base_client.cancelGoal();
            ROS_INFO_STREAM("CANCELLING GOAL AS GOAL REACHED");
            

            if(_move_base_client.getState() == actionlib::SimpleClientGoalState::PREEMPTED){
                ROS_INFO_STREAM("CURRENT GOAL CANCELLED CORRECTLY");
            }else if(_move_base_client.getState() != actionlib::SimpleClientGoalState::PREEMPTED){
                ROS_INFO_STREAM("CURRENT move_base STATE " << _move_base_client.getState().toString().c_str());
                ros::Time cancelled_time = ros::Time::now();

                // Wait until pre-empted/cancelled goal
                while(_move_base_client.getState() != actionlib::SimpleClientGoalState::PREEMPTED){
                    // Send another cancel request if 5 seconds have passed
                    if(ros::Time::now().toSec() > (cancelled_time.toSec() + 5)){
                        ROS_INFO_STREAM("SENDING ANOTHER CANCEL REQUEST");
                        _move_base_client.cancelGoal();
                        cancelled_time = ros::Time::now();
                    }
                }
                ROS_INFO_STREAM("CURRENT GOAL CANCELLED CORRECTLY");

            }

            ROS_INFO_STREAM("GOAL REACHED, PLAYING AUDIO FILE " << _waypoint_names[waypoint_number]);


            _finished_audio = false;

            // Play associated sound file for the waypoint
            std_msgs::String audio_trigger_msg;
            audio_trigger_msg.data = _waypoint_names[waypoint_number];
            audio_trigger_pub.publish(audio_trigger_msg);


            // Wait for sound file to finish before moving onto next waypoint
            while (_finished_audio == false) {
                // Wait
                ros::spinOnce();
            }

        }


    }


}


/*
void WaypointNavigation::goalStatusCB(const waypoint_navigation::goToWaypointFeedback& feedback){


}
*/



void WaypointNavigation::audioStatusCB(const std_msgs::String::ConstPtr& audio_status_msg) {

    ROS_INFO_STREAM(audio_status_msg->data);
    if (audio_status_msg->data == "Playing") {
        _finished_audio = false;
    } else if (audio_status_msg->data == "Ended") {
        _finished_audio = true;
    }

}



WaypointNavigation::WaypointNavigation(ros::NodeHandle &nh) : _nh(nh), _move_base_client("move_base", true) {

    _max_waypoints = 5;

    _inflation_radius = 1.0;

    map_frame = getParam<std::string>(_nh, "map_frame", "map");
    odom_frame = getParam<std::string>(_nh, "odom_frame", "odom");
    base_frame = getParam<std::string>(_nh, "base_link_frame", "base_link");
    audio_trigger_topic = getParam<std::string>(_nh, "audio_trigger_topic", "/audio_trigger");
    audio_status_topic = getParam<std::string>(_nh, "audio_status_topic", "/audio_status");


    _number_of_waypoints = getParam<int>(_nh, "number_of_waypoints", 0);

    if (_number_of_waypoints > _max_waypoints) {
        ROS_WARN_STREAM("Too many waypoints selected. Reverting to " << _max_waypoints << " waypoints.");
        _number_of_waypoints = _max_waypoints;
    }

    for (int i = 0; i < _number_of_waypoints; i++) {

        std::stringstream sstm_name;
        sstm_name << "waypoint_" << i << "_name";
        std::string waypoint_name = sstm_name.str();
        _waypoint_names.push_back(getParam<std::string>(_nh, waypoint_name, ""));

        std::stringstream sstm_x;
        sstm_x << "waypoint_" << i << "_x";
        std::string waypoint_x = sstm_x.str();
        _waypoints_x.push_back(getParam<float>(_nh, waypoint_x, 0));

        std::stringstream sstm_y;
        sstm_y << "waypoint_" << i << "_y";
        std::string waypoint_y = sstm_y.str();
        _waypoints_y.push_back(getParam<float>(_nh, waypoint_y, 0));
    }

    goal_pub = _nh.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 10);

    audio_trigger_pub = _nh.advertise<std_msgs::String>(audio_trigger_topic, 1);

    audio_status_sub = _nh.subscribe(audio_status_topic, 1, &WaypointNavigation::audioStatusCB, this);

    ROS_INFO_STREAM("Waiting for move_base action server to start");

    _move_base_client.waitForServer();       // Wait for move_base server to start. Will wait for infinite time.

    ros::Duration(0.5).sleep();     // Allow publisher to initialise before sending a goal

}




int main(int argc, char **argv) {

    ros::init(argc, argv, "waypoint_navigation");

    ros::NodeHandle nh("~");

    WaypointNavigation node(nh);

    //ros::Rate r(1);
    ros::spinOnce();

    node.destinationUpdate();
    /*
        while(ros::ok()){
            ros::spinOnce();
            r.sleep();
            node.destinationUpdate();
        }
    */
    return 0;
}

