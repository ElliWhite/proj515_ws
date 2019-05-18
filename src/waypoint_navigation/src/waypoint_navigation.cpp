#include <string>
#include <sstream>
#include <iostream>
#include <fstream>

#include "math.h"

#include <ros/ros.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <nav_msgs/Odometry.h>
#include <std_msgs/Int16.h>
#include <std_msgs/String.h>
#include <visualization_msgs/Marker.h>

#include <actionlib/client/simple_action_client.h>
#include <waypoint_navigation/goToWaypointAction.h>
#include <move_base_msgs/MoveBaseAction.h>

#include <boost/filesystem.hpp>
#include <stdio.h>


/* Function to get parameters from the launch file */
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


/* Function to create a quartennion from Euler angles */
static geometry_msgs::Quaternion createQuaternionFromRPY(double roll, double pitch, double yaw) {
    geometry_msgs::Quaternion q;
    double t0 = cos(yaw * 0.5);
    double t1 = sin(yaw * 0.5);
    double t2 = cos(roll * 0.5);
    double t3 = sin(roll * 0.5);
    double t4 = cos(pitch * 0.5);
    double t5 = sin(pitch * 0.5);
    q.w = t0 * t2 * t4 + t1 * t3 * t5;
    q.x = t0 * t3 * t4 - t1 * t2 * t5;
    q.y = t0 * t2 * t5 + t1 * t3 * t4;
    q.z = t1 * t2 * t4 - t0 * t3 * t5;
    return q;
}



typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> ActionClient;



class WaypointNavigation {

private:
    std::string _map_frame;
    std::string _odom_frame;
    std::string _base_frame;
    std::string _audio_trigger_topic;
    std::string _audio_status_topic;
    std::string _waypoint_file_folder;
    std::string _waypoint_filename;

    ros::NodeHandle _nh;

    int _max_waypoints;
    int _number_of_waypoints;

    std::vector<float>_waypoints_x;             // Vector of floats to hold coordinates of waypoints
    std::vector<float>_waypoints_y;
    std::vector<std::string>_waypoint_names;    // Vector of strings to hold waypoint names

    float _initial_pose_x;                      // Floats to hold the initial pose estimate
    float _initial_pose_y;
    float _initial_pose_heading;

    geometry_msgs::PoseStamped _current_destination;            // PoseStamped message to hold the current destination
    geometry_msgs::PoseWithCovarianceStamped _initial_pose_msg; // PoseWithCovarianceStamped message to hold the initial pose

    float _inflation_radius;                    // Radius around the goal point to inflate the goal

    ros::Publisher _initial_pose_pub;
    ros::Publisher _audio_trigger_pub;
    ros::Publisher _waypoint_viz_pub;
    ros::Subscriber _audio_status_sub;
    ros::Subscriber _navigation_enable_sub;
    ros::Subscriber _waypoint_file_select_sub;

    bool _finished_audio;
    bool _navigation_enable;
    bool _waypoint_file_selected;

    ActionClient _move_base_client;

    void audioStatusCB(const std_msgs::String::ConstPtr& msg);          // Callback to get status of audio track

    void navigationEnableCB(const std_msgs::Int16::ConstPtr& msg);      // Callback to get enable/disable waypoint navigation

    bool loadWaypoints(std::string filename);                           // Function to load the waypoints from a text file

    void waypointFileSelectionCB(const std_msgs::String::ConstPtr& msg);    // Callback to select the waypoint file to load


public:

    bool randomise;

    WaypointNavigation(ros::NodeHandle &nh);

    void destinationUpdate(bool randomise);                   // Main function to run and update the target destinations for robot

};

/* Function to send the goals to move_base */
void WaypointNavigation::destinationUpdate(bool randomise) {

    bool stop_all_movement = false;

    ROS_INFO_STREAM("Waiting for navigation to be enabled.");

    // Wait for message enabling navigation before continuing
    while (!_navigation_enable) {
        ros::spinOnce();
    }

    bool visited_waypoint[4] = {false, false, false, false};

    // Loop over all waypoints
    for (int waypoint_number = 0; waypoint_number < _number_of_waypoints; waypoint_number++) {
        int current_waypoint_number;
        // If doing the short tour, randonise the order of waypoints
        if (randomise) {
            srand(time(NULL));
            current_waypoint_number = rand() % _number_of_waypoints;
            while(visited_waypoint[current_waypoint_number] == true){
                current_waypoint_number = rand() % _number_of_waypoints;
                
            }
            visited_waypoint[current_waypoint_number] = true;
        } else {
            current_waypoint_number = waypoint_number;
        }
        ROS_INFO_STREAM("Attempting Waypoint " << current_waypoint_number + 1 << "  X: " << _waypoints_x[current_waypoint_number] << "  Y: " << _waypoints_y[current_waypoint_number]);

        char attempt_number = 0;
        char abort_number = 0;
        bool stop_all_movement = false;

        ros::Duration(5).sleep();

        // Fill PoseStamped message with required information
        _current_destination.header.stamp = ros::Time::now();
        _current_destination.header.frame_id = _map_frame;
        _current_destination.pose.position.x = _waypoints_x[current_waypoint_number];
        _current_destination.pose.position.y = _waypoints_y[current_waypoint_number];
        _current_destination.pose.orientation.x = 0;
        _current_destination.pose.orientation.y = 0;
        _current_destination.pose.orientation.z = 0;
        _current_destination.pose.orientation.w = 1;

        // Create new goal for move_base
        move_base_msgs::MoveBaseGoal goal;

        goal.target_pose.header.stamp = ros::Time::now();
        goal.target_pose.header.frame_id = _map_frame;
        goal.target_pose = _current_destination;    // Assign target pose (PoseStamped msg) as current destination

        // Send goal to move_base
        _move_base_client.sendGoal(goal);

        attempt_number += 1;

        ros::Time send_goal_time = ros::Time::now();
        ros::Time first_send_goal_time = send_goal_time;

        // Check if goal has been accepted by move_base
        // Resend goal if 5 seconds have passed, or abort movement if 20 seconds have passed
        while (_move_base_client.getState() == actionlib::SimpleClientGoalState::PENDING) {
            ROS_INFO_STREAM(_move_base_client.getState().toString().c_str());
            ROS_INFO_STREAM("GOAL HAS YET TO BE PROCESSED BY move_base");
            ros::Duration(1).sleep();
            if (ros::Time::now().toSec() > (first_send_goal_time.toSec() + 20)) {
                ROS_ERROR("20 SECONDS PASSED SINCE SENDING GOAL. ABORTING ALL MOVEMENT");
                stop_all_movement = true;
                break;
            }
            if (ros::Time::now().toSec() > (send_goal_time.toSec() + 5)) {
                ROS_INFO_STREAM("5 SECONDS PASSED SINCE SENDING GOAL. RE-SENDING GOAL");
                _move_base_client.sendGoal(goal);
                send_goal_time = ros::Time::now();
            }

        }

        if (stop_all_movement == true) {
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
        if (_move_base_client.getState() == actionlib::SimpleClientGoalState::ACTIVE) {

            tf::TransformListener listener;         // Create a listener to get the transform from map->base_link
            tf::StampedTransform t_mapBase;

            tf::Vector3 t_mapBase_pose;             // Set initial pose to (0,0)
            t_mapBase_pose.setX(0.0);
            t_mapBase_pose.setY(0.0);


            ROS_INFO_STREAM("waypoint min x: " << (_waypoints_x[current_waypoint_number] - _inflation_radius));
            ROS_INFO_STREAM("waypoint max x: " << (_waypoints_x[current_waypoint_number] + _inflation_radius));
            ROS_INFO_STREAM("waypoint min y: " << (_waypoints_y[current_waypoint_number] - _inflation_radius));
            ROS_INFO_STREAM("waypoint max y: " << (_waypoints_y[current_waypoint_number] + _inflation_radius));

            // If any of these are true then we haven't reached waypoint. Stay in loop until reached waypoint.
            while ( (t_mapBase_pose.x() < (_waypoints_x[current_waypoint_number] - _inflation_radius)) ||
                    (t_mapBase_pose.x() > (_waypoints_x[current_waypoint_number] + _inflation_radius)) ||
                    (t_mapBase_pose.y() < (_waypoints_y[current_waypoint_number] - _inflation_radius)) ||
                    (t_mapBase_pose.y() > (_waypoints_y[current_waypoint_number] + _inflation_radius))
                  ) {

                // Get transform from map->base_link
                try {
                    listener.waitForTransform(_map_frame, _base_frame, ros::Time(0), ros::Duration(0.5));
                    listener.lookupTransform(_map_frame, _base_frame, ros::Time(0), t_mapBase);
                }
                catch (tf::TransformException ex) {
                    ROS_ERROR("%s", ex.what());
                }

                // Get pose of base relative to map
                t_mapBase_pose = t_mapBase.getOrigin();

                // Get status of move_base
                ROS_INFO_STREAM("Waypoint " << current_waypoint_number + 1 << " " << _move_base_client.getState().toString().c_str());

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

            // Check to see if cancel request was processed
            if (_move_base_client.getState() == actionlib::SimpleClientGoalState::PREEMPTED) {
                ROS_INFO_STREAM("CURRENT GOAL CANCELLED CORRECTLY");
            } else if (_move_base_client.getState() != actionlib::SimpleClientGoalState::PREEMPTED) {
                ROS_INFO_STREAM("CURRENT move_base STATE " << _move_base_client.getState().toString().c_str());
                ros::Time cancelled_time = ros::Time::now();

                // Wait until pre-empted/cancelled goal
                while (_move_base_client.getState() != actionlib::SimpleClientGoalState::PREEMPTED) {
                    // Send another cancel request if 5 seconds have passed
                    if (ros::Time::now().toSec() > (cancelled_time.toSec() + 5)) {
                        ROS_INFO_STREAM("SENDING ANOTHER CANCEL REQUEST");
                        _move_base_client.cancelGoal();
                        cancelled_time = ros::Time::now();
                    }
                }
                ROS_INFO_STREAM("CURRENT GOAL CANCELLED CORRECTLY");

            }

            // If the waypoint name isn't null, then play the associated sound file
            if (_waypoint_names[current_waypoint_number] != "NULL") {

                std::string random_file_name = "";

                // Play associated sound file for the waypoint
                std_msgs::String audio_trigger_msg;

                // If doing short tour then send the random_quip file name
                if (randomise) {
                    srand(time(NULL));
                    random_file_name = "random_quip_" + current_waypoint_number;
                    audio_trigger_msg.data = random_file_name;
                     ROS_INFO_STREAM("GOAL REACHED, PLAYING AUDIO FILE " << random_file_name);

                } else {
                    // Send the waypoint name to /audio_trigger to play sound file
                    audio_trigger_msg.data = _waypoint_names[current_waypoint_number];
                    ROS_INFO_STREAM("GOAL REACHED, PLAYING AUDIO FILE " << _waypoint_names[current_waypoint_number]);

                }

                _finished_audio = false;
                _audio_trigger_pub.publish(audio_trigger_msg);      // Publish message/sound file name

                // Wait for sound file to finish before moving onto next waypoint
                while (_finished_audio == false) {
                    // Wait
                    ros::spinOnce();
                }

            }

        }

    }

}


/* Callback to select which waypoint file to load */
void WaypointNavigation::waypointFileSelectionCB(const std_msgs::String::ConstPtr& waypoint_file_msg) {

    _waypoint_filename = waypoint_file_msg->data;
    _waypoint_file_selected = true;

}


/* Function to load waypoints from a file */
bool WaypointNavigation::loadWaypoints(std::string filename) {


    // Load waypoints
    ROS_INFO_STREAM("Load waypoints " << filename);

    FILE *fp = fopen(filename.c_str(), "r");

    if (fp == NULL) {
        return false;
    }

    int numRead = 0;

    const int BUFSIZE = 2048;
    char linebuf[BUFSIZE];
    char linkbuf[BUFSIZE];

    while (!feof(fp)) {
        // Break if can't read line
        if (fgets(linebuf, BUFSIZE - 1, fp) == NULL) {
            break;
        }

        char waypoint_name[20];
        double x, y;
        linkbuf[0] = '\0';

        // Read line
        int nElems = sscanf(linebuf, "%s %lf %lf%[^\t\n]*s", waypoint_name, &x, &y, linkbuf);

        if (nElems == 3 || nElems == 4) {

            std::stringstream sstm_name;
            sstm_name << waypoint_name;
            std::string waypoint_name = sstm_name.str();

            _waypoint_names.push_back(waypoint_name);
            _waypoints_x.push_back(x);
            _waypoints_y.push_back(y);

            numRead++;

        } else {
            ROS_WARN("Invalid line: %s", linebuf);
        }

    }

    // Close file
    fclose(fp);
    ROS_INFO("Load map %s read %d entries", filename.c_str(), numRead);
    _number_of_waypoints = numRead;


    // Publish visualisation messages for waypoints
    for (int i = 0; i < _number_of_waypoints; i++) {

        // Circle (Flatterned Cyclinder)
        visualization_msgs::Marker marker;
        marker.type = visualization_msgs::Marker::CYLINDER;
        marker.action = visualization_msgs::Marker::ADD;
        marker.pose.position.x = _waypoints_x[i];
        marker.pose.position.y = _waypoints_y[i];
        marker.pose.position.z = 0.02;
        marker.scale.x = _inflation_radius;
        marker.scale.y = _inflation_radius;
        marker.scale.z = 0.01;
        marker.color.r = 1.0f;
        marker.color.g = 1.0f;
        marker.color.b = 0.0f;
        marker.color.a = 1.0f;

        marker.id = i;
        marker.ns = "waypoint";
        marker.header.frame_id = "/map";

        _waypoint_viz_pub.publish(marker);      // Publish circle

        // Text
        visualization_msgs::Marker text;
        text.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
        text.action = visualization_msgs::Marker::ADD;
        text.header.frame_id = "/map";
        text.color.r = 1.0f;
        text.color.g = 0.0f;
        text.color.b = 1.0f;
        text.color.a = 1.0f;
        text.id = i;
        text.scale.x = text.scale.y = text.scale.z = 0.66;
        text.pose.position.x = _waypoints_x[i];
        text.pose.position.y = _waypoints_y[i];
        text.pose.position.z = 0.5;
        text.ns = "text";
        text.text = "Waypoint " + boost::to_string(i + 1);

        _waypoint_viz_pub.publish(text);        // Publish text

    }

    return true;

}


/* Callback to get the status of the playback of the audio file */
void WaypointNavigation::audioStatusCB(const std_msgs::String::ConstPtr& audio_status_msg) {

    ROS_INFO_STREAM(audio_status_msg->data);
    if (audio_status_msg->data == "Playing") {
        _finished_audio = false;
    } else if (audio_status_msg->data == "Ended") {
        _finished_audio = true;
    }

}


/* Callback to enable the navigation. Used to control whether to start the tour */
void WaypointNavigation::navigationEnableCB(const std_msgs::Int16::ConstPtr& navigation_enable_msg) {

    if (navigation_enable_msg->data == 1) {
        _navigation_enable = 1;
    }
    if (navigation_enable_msg->data == 0) {
        _navigation_enable = 0;
    }

}



WaypointNavigation::WaypointNavigation(ros::NodeHandle &nh) : _nh(nh), _move_base_client("move_base", true) {

    _max_waypoints = 5;

    _inflation_radius = 0.5;

    _map_frame = getParam<std::string>(_nh, "map_frame", "map");
    _odom_frame = getParam<std::string>(_nh, "odom_frame", "odom");
    _base_frame = getParam<std::string>(_nh, "base_link_frame", "base_link");
    _audio_trigger_topic = getParam<std::string>(_nh, "audio_trigger_topic", "/audio_trigger");
    _audio_status_topic = getParam<std::string>(_nh, "audio_status_topic", "/audio_status");
    _waypoint_file_folder = getParam<std::string>(_nh, "waypoints_file_folder", std::string(getenv("HOME")) + "/.ros/waypoints");

    _initial_pose_x = getParam<float>(_nh, "initial_pose_x", 0);
    _initial_pose_y = getParam<float>(_nh, "initial_pose_y", 0);
    _initial_pose_heading = getParam<float>(_nh, "initial_pose_heading", 0);

    // Set up initial pose message with parsed parameters
    _initial_pose_msg.header.stamp = ros::Time::now();
    _initial_pose_msg.header.frame_id = _map_frame;
    _initial_pose_msg.pose.pose.position.x = _initial_pose_x;
    _initial_pose_msg.pose.pose.position.y = _initial_pose_y;

    geometry_msgs::Quaternion q;
    q = createQuaternionFromRPY( 0, 0, (_initial_pose_heading * M_PI / 180));

    _initial_pose_msg.pose.pose.orientation = q;

    _initial_pose_pub = _nh.advertise<geometry_msgs::PoseWithCovarianceStamped>("/initialpose", 1);

    _audio_trigger_pub = _nh.advertise<std_msgs::String>(_audio_trigger_topic, 1);

    _waypoint_viz_pub = _nh.advertise<visualization_msgs::Marker>("/waypoint_locations", 100);

    _audio_status_sub = _nh.subscribe(_audio_status_topic, 1, &WaypointNavigation::audioStatusCB, this);

    _navigation_enable_sub = _nh.subscribe("/navigation_enable", 1, &WaypointNavigation::navigationEnableCB, this);

    _waypoint_file_select_sub = _nh.subscribe("/waypoint_file", 1, &WaypointNavigation::waypointFileSelectionCB, this);

    _navigation_enable = false;

    _waypoint_file_selected = false;

    randomise = false;

    ros::Duration(2).sleep();         // Allow publishers to initialise and for RViz to boot and show everything

    ROS_INFO_STREAM("Waiting on waypoint file to be selected.");

    // Wait for a waypoint file to be selected
    while (_waypoint_file_selected == false) {
        ros::spinOnce();
    }

    // If doing the short tour then randomise the order of waypoints
    if (_waypoint_filename.find("short") != std::string::npos) {
        randomise = true;
    }

    _waypoint_filename = _waypoint_file_folder + "/" + _waypoint_filename + ".txt";

    ROS_INFO_STREAM("Waypoint file selected: " << _waypoint_filename);

    // Load and publish waypoints
    boost::filesystem::path filePath(_waypoint_filename);
    boost::filesystem::path dir = filePath.parent_path();
    boost::filesystem::create_directories(dir);

    if (!loadWaypoints(_waypoint_filename)) {
        ROS_ERROR("Could not open %s for read", _waypoint_filename.c_str());
    }

    ROS_INFO_STREAM("Waiting for move_base action server to start");

    _move_base_client.waitForServer();                  // Wait for move_base server to start. Will wait for infinite time.

    _initial_pose_pub.publish(_initial_pose_msg);        // Publish the initial pose


}



int main(int argc, char **argv) {

    ros::init(argc, argv, "waypoint_navigation");

    ros::NodeHandle nh("~");

    WaypointNavigation node(nh);

    ros::spinOnce();

    node.destinationUpdate(node.randomise);

    return 0;
}
