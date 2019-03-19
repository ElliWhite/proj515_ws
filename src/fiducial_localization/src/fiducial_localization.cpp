
#include <string>


#include <ros/ros.h>
#include <tf/transform_datatypes.h>
#include <tf2/LinearMath/Transform.h>
#include <tf2_ros/buffer.h>
#include <tf2_ros/transform_broadcaster.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <visualization_msgs/Marker.h>
#include "fiducial_msgs/Fiducial.h"
#include "fiducial_msgs/FiducialArray.h"
#include "fiducial_msgs/FiducialTransform.h"
#include "fiducial_msgs/FiducialTransformArray.h"
#include "nav_msgs/Odometry.h"

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

class FiducialLocalization {
    
  
    
    private:
    	std::string map_frame;
    	std::string odom_frame;
    	std::string fiducial_transform_array_topic;
        std::string odom_topic;

        ros::Publisher odom_pub;
        ros::Subscriber fiducial_transform_array_sub;

        ros::NodeHandle nh_;

        void fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray &msg);

        
    public:

        FiducialLocalization(ros::NodeHandle &nh);


};


void FiducialLocalization::fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray &msg){
    ROS_INFO_STREAM("TEST");
}



FiducialLocalization::FiducialLocalization(ros::NodeHandle &nh) : nh_(nh){
  
    map_frame = getParam<std::string>(nh_, "map_frame", "map"); 

    odom_frame = getParam<std::string>(nh_, "odom_frame", "odom");

    fiducial_transform_array_topic = getParam<std::string>(nh_, "fiducial_transform_array_topic", "/fiducial_transforms");

    odom_topic = getParam<std::string>(nh_, "odom_pub", "/fiducial_odom");

    odom_pub = nh_.advertise<nav_msgs::Odometry>(odom_topic, 10);

    fiducial_transform_array_sub = nh_.subscribe(fiducial_transform_array_topic, 1, &FiducialLocalization::fiducialTransformArrayCb, this);

    
}






 
    





int main(int argc, char **argv){
    ros::init(argc, argv, "fiducial_localization");

    ros::NodeHandle nh("~");

    FiducialLocalization node(nh);



    ros::spin();

    return 0;
}

