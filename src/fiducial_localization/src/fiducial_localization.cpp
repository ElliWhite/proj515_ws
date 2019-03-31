
#include <string>
#include <sstream>

#include "math.h"

#include <ros/ros.h>
#include <tf/transform_datatypes.h>
#include <tf2/LinearMath/Transform.h>
#include <tf2/LinearMath/Scalar.h>
#include <tf2/LinearMath/Vector3.h>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2_ros/buffer.h>
#include <tf2_ros/transform_broadcaster.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>

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
        std::string base_frame;
        std::string cam_frame;
    	std::string fiducial_transform_array_topic;
        std::string odom_topic;
        std::string fiducials_topic;
        
        ros::Publisher odom_pub;

        ros::Subscriber fiducial_transform_array_sub;
        ros::Subscriber fiducials_sub;

        ros::NodeHandle nh_;

        void fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray::ConstPtr& msg);

        //ros::Publisher test_viz_pub;

    public:

        FiducialLocalization(ros::NodeHandle &nh);

};


void FiducialLocalization::fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray::ConstPtr& fidTransArrMsg){

    const fiducial_msgs::FiducialTransform &ft = fidTransArrMsg->transforms[0];
    
    int numberOfIDs = fidTransArrMsg->transforms.size();

    // Initially no IDs are published until 1 marker as been seen
    if(numberOfIDs > 0){
        
        tf::TransformListener listener;
        tf::StampedTransform t_baseFid;

        std::stringstream sstm;
        sstm << "fid" << ft.fiducial_id;
        std::string fiducial_frame = sstm.str();

        bool foundTF = false;
        
        try{
            listener.waitForTransform(base_frame, fiducial_frame, ros::Time(0), ros::Duration(0.5));
            listener.lookupTransform(base_frame, fiducial_frame, ros::Time(0), t_baseFid);
            foundTF = true;
        }
        catch(tf::TransformException ex){
            ROS_ERROR("%s", ex.what());
        }
        
        if(foundTF){

            boost::shared_ptr<visualization_msgs::Marker const> sharedPtr;
            visualization_msgs::Marker markerMsg;
            
            ros::Time current_time = ros::Time::now();

            bool foundCorrectVisMsg = false;

            while(markerMsg.id != ft.fiducial_id){

                sharedPtr = ros::topic::waitForMessage<visualization_msgs::Marker>(fiducials_topic, ros::Duration(0.5));

                if(sharedPtr == NULL){
                    ROS_INFO_STREAM("No visualization_msg received while waiting for correct message");
                }else{
                    markerMsg = *sharedPtr;
                }

                if(markerMsg.id == ft.fiducial_id){
                    foundCorrectVisMsg = true;
                }

                if(ros::Time::now().toSec() >= (current_time.toSec() + 2)){
                    break;
                }
            }

            if(foundCorrectVisMsg){

                ROS_INFO_STREAM("Correct fiducial marker message received");
                ROS_INFO_STREAM("Observed Fiducial ID: " << ft.fiducial_id);
                ROS_INFO_STREAM("Marker Message: " << markerMsg.ns << markerMsg.id);   

                tf::Transform t_mapFid;                                         // Create a transform of the fiducial from map->fid
                
                tfScalar m_x = markerMsg.pose.position.x;   
                tfScalar m_y = markerMsg.pose.position.y;
                tfScalar m_z = markerMsg.pose.position.z;
                tf::Vector3 marker_origin(m_x,m_y,m_z);                         // Create a vector for the origin of the fiducial frame to be the
                                                                                // same as the location of the observed marker
            
                t_mapFid.setOrigin(marker_origin);                              // Set the origin of the fiducial frame to be location of the marker

                tfScalar r_x = markerMsg.pose.orientation.x;
                tfScalar r_y = markerMsg.pose.orientation.y;
                tfScalar r_z = markerMsg.pose.orientation.z;
                tfScalar r_w = markerMsg.pose.orientation.w;

                tf::Quaternion marker_rotation(r_x, r_y, r_z, r_w);             // Create a quaternion for the fiducial frame to be the same
                                                                                // as the quaternion of the observed marker

                t_mapFid.setRotation(marker_rotation);                          // Set the rotation of the fiducial frame to be the same as the observed
                                                                                // marker

                tf::Transform t_fidBase = t_baseFid.inverse();                  // Create a transform from fid->base_link (originally base_link->fid, hence inverse)

                tf::Transform t_mapBase;                                        // Create a transform of the robot from map->base_link
                t_mapBase.mult(t_mapFid, t_fidBase);                            // This transform is a result of map->fid and fid->base_link

                foundTF = false;

                tf::StampedTransform t_mapOdom;

                // Try and find transform from map->odom
                try{
                    listener.waitForTransform(map_frame, odom_frame, ros::Time(0), ros::Duration(0.5));
                    listener.lookupTransform(map_frame, odom_frame, ros::Time(0), t_mapOdom);
                    foundTF = true;
                }
                catch(tf::TransformException ex){
                    ROS_ERROR("%s", ex.what());
                }

                if(foundTF){

                    tf::Transform t_odomMap = t_mapOdom.inverse();

                    tf::Transform t_odomBase;
                    t_odomBase.mult(t_odomMap, t_mapBase);


                    tf::Vector3 t_odomBase_pose = t_odomBase.getOrigin();           // Get origin of base_link relative to map
                    double r, p, y;
                    t_odomBase.getBasis().getRPY(r, p, y);                          // Get orientation of base_link relative to map in RPY form
                    tf::Quaternion t_odomBase_rot = t_odomBase.getRotation();       // Get quaternion of base_link so can extract Omega

                    geometry_msgs::PoseStamped pose_Base;                           // Create PoseStamped message so can add Pose to RViz
                    pose_Base.header.frame_id = odom_frame;                         // Set frame base_link tf is associated with to map frame
                    pose_Base.pose.position.x = t_odomBase_pose.x();                // Set XYZ location of Pose to base_link pose
                    pose_Base.pose.position.y = t_odomBase_pose.y();
                    pose_Base.pose.position.z = t_odomBase_pose.z();
                    pose_Base.pose.orientation.x = r;                               // Set RPY of Pose message to that of the base_link
                    pose_Base.pose.orientation.y = p;
                    pose_Base.pose.orientation.z = y;
                    pose_Base.pose.orientation.w = t_odomBase_rot.getW()*2;         // Set Omega to that of base_link. Unsure why have to multiply by
                                                                                    // 2 to get it to reflect actual Omega
                    //test_viz_pub.publish(pose_Base);                                // Publish Pose 

                    nav_msgs::Odometry odom_Base;                                   // Create Odometry message for fiducial localization
                    odom_Base.header.frame_id = odom_frame;                         // Assign parent frame to odometry frame
                    odom_Base.header.stamp = ros::Time::now();                      // Assign timestamp to the current time
                    odom_Base.child_frame_id = base_frame;                          // Assign child frame to base_link
                    
                    odom_Base.pose.pose.position.x = t_odomBase_pose.x();           // Set XYZ location of base_link
                    odom_Base.pose.pose.position.y = t_odomBase_pose.y();
                    //odom_Base.pose.pose.position.z = t_odomBase_pose.pose.z();    // Don't need any Z estimation as on 2D plane only
                    //odom_Base.pose.pose.orientation.x = r;                        // Don't need RP
                    //odom_Base.pose.pose.orientation.y = p;
                    odom_Base.pose.pose.orientation.z = y;                          // Set rotation around Z to be yaw
                    odom_Base.pose.pose.orientation.w = t_odomBase_rot.getW()*2;    // Set Omega for base_link
                    //odom_Base.twist.twist;                                        // Don't need as not calculating any velocities

                    odom_pub.publish(odom_Base);
                }


            }

        }

    }

}




FiducialLocalization::FiducialLocalization(ros::NodeHandle &nh) : nh_(nh){
  
    map_frame = getParam<std::string>(nh_, "map_frame", "map"); 

    odom_frame = getParam<std::string>(nh_, "odom_frame", "odom");

    cam_frame = getParam<std::string>(nh_, "camera_frame", "usb_cam");

    base_frame = getParam<std::string>(nh_, "base_link_frame", "base_link");

    fiducial_transform_array_topic = getParam<std::string>(nh_, "fiducial_transform_array_topic", "/fiducial_transforms");

    odom_topic = getParam<std::string>(nh_, "odom_pub", "/fiducial_localization/fiducial_odom");

    fiducials_topic = getParam<std::string>(nh_, "fiducials_topic", "/fiducials");

    odom_pub = nh_.advertise<nav_msgs::Odometry>(odom_topic, 10);

    fiducial_transform_array_sub = nh_.subscribe(fiducial_transform_array_topic, 1, &FiducialLocalization::fiducialTransformArrayCb, this);

    //test_viz_pub = nh_.advertise<geometry_msgs::PoseStamped>("/fiducial_localization/test_pose", 5);
  
}




int main(int argc, char **argv){

    ros::init(argc, argv, "fiducial_localization");

    ros::NodeHandle nh("~");

    FiducialLocalization node(nh);

    ros::Rate r(10);

    while(ros::ok()){
        ros::spinOnce();
        r.sleep();
    }

    return 0;
}

