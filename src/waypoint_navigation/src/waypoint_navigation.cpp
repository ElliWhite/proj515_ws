
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

using namespace std;


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

    std::vector<float>_waypoints_x;
    std::vector<float>_waypoints_y;
    std::vector<string>_waypoint_names;

    geometry_msgs::PoseStamped _current_destination;

    float _inflation_radius;

    ros::Publisher goal_pub;
    ros::Publisher audio_trigger_pub;
    ros::Subscriber audio_status_sub;

    bool _finished_audio;

    void audioStatusCB(const std_msgs::String::ConstPtr& msg);


public:

    WaypointNavigation(ros::NodeHandle &nh);

    void destinationUpdate();

};


void WaypointNavigation::destinationUpdate() {

    for (int waypoint_number = 0; waypoint_number < _number_of_waypoints; waypoint_number++) {
        ROS_INFO_STREAM("Attempting Waypoint " << waypoint_number << "  X: " << _waypoints_x[waypoint_number] << "  Y: " << _waypoints_y[waypoint_number]);
        _current_destination.header.stamp = ros::Time::now();
        _current_destination.header.frame_id = map_frame;
        _current_destination.pose.position.x = _waypoints_x[waypoint_number];
        _current_destination.pose.position.y = _waypoints_y[waypoint_number];
        _current_destination.pose.orientation.x = 0;
        _current_destination.pose.orientation.y = 0;
        _current_destination.pose.orientation.z = 0;
        _current_destination.pose.orientation.w = 1;
        goal_pub.publish(_current_destination);
        ros::Duration(0.5).sleep();

        tf::TransformListener listener;
        tf::StampedTransform t_mapBase;



        tf::Vector3 t_mapBase_pose;
        t_mapBase_pose.setX(0.0);
        t_mapBase_pose.setY(0.0);

        ROS_INFO_STREAM("pose x: " << t_mapBase_pose.x() << " pose y: " << t_mapBase_pose.y());

        ROS_INFO_STREAM("waypoint min x: " << (_waypoints_x[waypoint_number] - _inflation_radius));
        ROS_INFO_STREAM("waypoint max x: " << (_waypoints_x[waypoint_number] + _inflation_radius));
        ROS_INFO_STREAM("waypoint min y: " << (_waypoints_y[waypoint_number] - _inflation_radius));
        ROS_INFO_STREAM("waypoint max y: " << (_waypoints_y[waypoint_number] + _inflation_radius));

        // If any of these are true then we haven't reached waypoint
        while ( (t_mapBase_pose.x() < (_waypoints_x[waypoint_number] - _inflation_radius)) ||
                (t_mapBase_pose.x() > (_waypoints_x[waypoint_number] + _inflation_radius)) ||
                (t_mapBase_pose.y() < (_waypoints_y[waypoint_number] - _inflation_radius)) ||
                (t_mapBase_pose.y() > (_waypoints_y[waypoint_number] + _inflation_radius))
              ) {

            try {
                listener.waitForTransform(map_frame, base_frame, ros::Time(0), ros::Duration(0.5));
                listener.lookupTransform(map_frame, base_frame, ros::Time(0), t_mapBase);
            }
            catch (tf::TransformException ex) {
                ROS_ERROR("%s", ex.what());
            }

            t_mapBase_pose = t_mapBase.getOrigin();

        }

        _finished_audio = false;

        // Play associated sound file for the waypoint
        std_msgs::String audio_trigger_msg;
        audio_trigger_msg.data = _waypoint_names[waypoint_number];
        audio_trigger_pub.publish(audio_trigger_msg);

        // Wait for sound file to finish before moving onto next waypoint
        while(_finished_audio == false){
            // Wait
            ros::spinOnce();
        }







    }




}

void WaypointNavigation::audioStatusCB(const std_msgs::String::ConstPtr& audio_status_msg) {

    ROS_INFO_STREAM(audio_status_msg->data);
    if (audio_status_msg->data == "Playing") {
        _finished_audio = false;
    } else if (audio_status_msg->data == "Ended") {
        _finished_audio = true;
    }

}



WaypointNavigation::WaypointNavigation(ros::NodeHandle &nh) : _nh(nh) {

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
        _waypoint_names.push_back(getParam<string>(_nh, waypoint_name, ""));

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

