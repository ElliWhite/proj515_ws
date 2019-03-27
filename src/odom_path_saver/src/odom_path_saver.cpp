#include <ros/ros.h>
#include <tf/transform_listener.h>
#include <nav_msgs/Path.h>
#include <geometry_msgs/PoseStamped.h>


int main(int argc, char** argv){

  ros::init(argc, argv, "odom_to_path_saver");    // Initialise ROS Node

  ros::NodeHandle nh;                       // Create node-handler

  ros::Publisher odom_path_pub = nh.advertise<nav_msgs::Path>("odom_path/path", 10);  // Create publisher and start advertising a path message

  tf::TransformListener listener;           // Create transform listener that will listen to transforms

  nav_msgs::Path path_msg;                  // Create path message to hold the path robot has taken

  tf::StampedTransform transform_msg;       // Create transform message that holds transform between two frames

  geometry_msgs::PoseStamped pose_msg;      // Create pose stamped message to hold the current x,y location of the robot at a given time

  ros::Rate rate(10.0);

  // Main loop to execute while the node is connected
  while (nh.ok()){

    // Wait for transform between odom->base_link to occur
    try{
      listener.waitForTransform("odom", "base_link", ros::Time(0), ros::Duration(1.0) );
      listener.lookupTransform("odom", "base_link", ros::Time(0), transform_msg);        // Save the transform into transform_msg
    }
    catch (tf::TransformException ex){
      ROS_ERROR("%s",ex.what());
      ros::Duration(1.0).sleep();
    }

    // Debugging info
    ROS_INFO("Fixed Frame ID: %s", transform_msg.frame_id_.c_str());
    ROS_INFO("Child Frame ID: %s", transform_msg.child_frame_id_.c_str());
    ROS_INFO("Current Location X: %f\tY: %f", transform_msg.getOrigin().x(), transform_msg.getOrigin().y());

   
    pose_msg.header.stamp = ros::Time::now();
    pose_msg.header.frame_id = "base_link";
    pose_msg.pose.position.x = transform_msg.getOrigin().x();
    pose_msg.pose.position.y = transform_msg.getOrigin().y();

    path_msg.header.stamp = pose_msg.header.stamp;
    path_msg.header.frame_id = "odom";
    path_msg.poses.push_back(pose_msg);
    
    odom_path_pub.publish(path_msg);

    ros::Duration(0.1).sleep();

  }

  return 0;
};