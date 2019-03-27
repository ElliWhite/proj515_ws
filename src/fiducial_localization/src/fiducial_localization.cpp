
#include <string>
#include <sstream>

#include "math.h"

//#include "fiducial_localization/map.h"

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

        geometry_msgs::Transform transform_fid_cam;
        geometry_msgs::PoseStamped pose_map_cam;

        int observedFidID;

        void fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray::ConstPtr& msg);
        void fiducialsCb(const visualization_msgs::Marker &fid_msg);



        ros::Publisher test_viz_pub;

        
    public:

        FiducialLocalization(ros::NodeHandle &nh);


};


void FiducialLocalization::fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray::ConstPtr& fidTransArrMsg){

    //ROS_INFO_STREAM("FiducialTransformArray received");

    const fiducial_msgs::FiducialTransform &ft = fidTransArrMsg->transforms[0];

    
    int numberOfIDs = fidTransArrMsg->transforms.size();
    
    if(numberOfIDs > 0){
        
        this->observedFidID = ft.fiducial_id;

        //ROS_INFO_STREAM("observedFidID " << this->observedFidID);

        this->transform_fid_cam = ft.transform;
        
        tf2_ros::Buffer tfBuffer;
        tf2_ros::TransformListener listener(tfBuffer);
        geometry_msgs::TransformStamped geom_tfFid;
        
        tf::TransformListener listener2;
        tf::StampedTransform transform_msg;


        std::stringstream sstm;
        sstm << "fid" << this->observedFidID;
        std::string fiducial_frame = sstm.str();

        bool foundTF = false;


        
        try{
            listener2.waitForTransform(base_frame, fiducial_frame, ros::Time(0), ros::Duration(0.5));
            listener2.lookupTransform(base_frame, fiducial_frame, ros::Time(0), transform_msg);
            foundTF = true;

        }
        catch(tf::TransformException ex){
            ROS_ERROR("%s", ex.what());
        }
        
        
        
        try{
            geom_tfFid = tfBuffer.lookupTransform(base_frame, fiducial_frame, ros::Time(0), ros::Duration(0.5));
            foundTF = true;
        }
        catch(tf2::TransformException ex){
            ROS_ERROR("%s", ex.what());
        }
        

        if(foundTF){

            //ROS_INFO_STREAM(tfFid);
            //ROS_INFO_STREAM(this->transform_fid_cam);

            boost::shared_ptr<visualization_msgs::Marker const> sharedPtr;
            visualization_msgs::Marker markerMsg;

            sharedPtr = ros::topic::waitForMessage<visualization_msgs::Marker>(fiducials_topic, ros::Duration(2));

            if(sharedPtr == NULL){
                ROS_INFO_STREAM("No visualization_msg received");
            }else{
                markerMsg = *sharedPtr;
            }
            
            ros::Time current_time = ros::Time::now();

            while( markerMsg.id != this->observedFidID){
                sharedPtr = ros::topic::waitForMessage<visualization_msgs::Marker>(fiducials_topic, ros::Duration(2));

                if(sharedPtr == NULL){
                    ROS_INFO_STREAM("No visualization_msg received while waiting for correct message");
                }else{
                    markerMsg = *sharedPtr;
                    ROS_INFO_STREAM("Latest Marker Message: " << markerMsg.ns << markerMsg.id);
                }

                if(ros::Time::now().toSec() >= (current_time.toSec() + 2)){
                    break;
                }
            }

            ROS_INFO_STREAM("Correct fiducial marker message received");
            ROS_INFO_STREAM("Observed Fiducial ID: " << this->observedFidID);
            ROS_INFO_STREAM("Marker Message: " << markerMsg.ns << markerMsg.id);   

            // Now have transform from base_link to the detected fiducial
            // and also the location of said fiducial relative to the map
            geometry_msgs::PoseStamped tfRobot;
            //markerMsg = location of marker relative to map
            //tfFid = location of base_link relative to marker
            /*
            tfRobot.pose.position.x = markerMsg.pose.position.x * geom_tfFid.transform.x;
            tfRobot.pose.position.y = markerMsg.pose.position.y * geom_tfFid.transform.translation.z;
            tfRobot.pose.position.z = markerMsg.pose.position.z * geom_tfFid.transform.translation.z;
            tfRobot.pose.orientation.x = markerMsg.pose.orientation.x * geom_tfFid.transform.rotation.x;
            tfRobot.pose.orientation.y = markerMsg.pose.orientation.y * geom_tfFid.transform.rotation.y;
            tfRobot.pose.orientation.z = markerMsg.pose.orientation.z * geom_tfFid.transform.rotation.z;
            tfRobot.pose.orientation.w = markerMsg.pose.orientation.w * geom_tfFid.transform.rotation.w;
            */
            tfRobot.header.frame_id = map_frame;
            /*
            geometry_msgs::PoseStamped markerPose;
            markerPose.pose.position.x = markerMsg.pose.position.x;
            markerPose.pose.position.y = markerMsg.pose.position.y;
            markerPose.pose.position.z = markerMsg.pose.position.z;
            markerPose.pose.orientation.x = markerMsg.pose.orientation.x;
            markerPose.pose.orientation.y = markerMsg.pose.orientation.y;
            markerPose.pose.orientation.z = markerMsg.pose.orientation.z;
            markerPose.pose.orientation.w = markerMsg.pose.orientation.w;
            //2::doTransform(markerPose, tfRobot, geom_tfFid);
            
            //ROS_INFO_STREAM(geom_tfFid);
            //ROS_INFO_STREAM(tfRobot);
            
            /*
            tf::Vector3 t = transform_msg.getOrigin();
            double r, p, y;
            transform_msg.getBasis().getRPY(r, p, y);
            */
            tf::Transform invs_transform_msg = transform_msg.inverse();
            tf::Vector3 t = invs_transform_msg.getOrigin();
            double r, p, y;
            invs_transform_msg.getBasis().getRPY(r, p, y);
            /*
            geometry_msgs::TransformStamped t_marker;
            geometry_msgs::Vector3 marker_origin;
            marker_origin.x = markerMsg.pose.position.x;
            marker_origin.y = markerMsg.pose.position.y;
            marker_origin.z = markerMsg.pose.position.z;

            geometry_msgs::Quaternion marker_rotation;
            marker_rotation.x =  markerMsg.pose.orientation.x;
            marker_rotation.y =  markerMsg.pose.orientation.y;
            marker_rotation.z =  markerMsg.pose.orientation.z;
            marker_rotation.w =  markerMsg.pose.orientation.w;

            t_marker.transform.translation = marker_origin;
            t_marker.transform.rotation = marker_rotation;
            t_marker.header.frame_id = map_frame;
            t_marker.child_frame_id = "fid1";


            geometry_msgs::TransformStamped t_Robot;
            t_Robot.transform = t_marker.transform * geom_tfFid.transform;
       
            */ 
            tf::Transform t_marker;
            
            tfScalar m_x = markerMsg.pose.position.x;
            tfScalar m_y = markerMsg.pose.position.y;
            tfScalar m_z = markerMsg.pose.position.z;
            tf::Vector3 marker_origin(m_x,m_y,m_z);

        
            t_marker.setOrigin(marker_origin);


            tfScalar r_x = markerMsg.pose.orientation.x;
            tfScalar r_y = markerMsg.pose.orientation.y;
            tfScalar r_z = markerMsg.pose.orientation.z;
            tfScalar r_w = markerMsg.pose.orientation.w;

            tf::Quaternion marker_rotation(r_x, r_y, r_z, r_w);

            t_marker.setRotation(marker_rotation);

            tf::Transform t_Robot;
            t_Robot.mult(t_marker, invs_transform_msg);



            tf::Vector3 t_Robot_pose = t_Robot.getOrigin();
            t_Robot.getBasis().getRPY(r, p, y);
            tf::Quaternion t_Robot_rot = t_Robot.getRotation();
            
            tfRobot.pose.position.x = t_Robot_pose.x();
            tfRobot.pose.position.y = t_Robot_pose.y();
            tfRobot.pose.position.z = t_Robot_pose.z();
            tfRobot.pose.orientation.x = r;
            tfRobot.pose.orientation.y = p;
            tfRobot.pose.orientation.z = y;
            tfRobot.pose.orientation.w = t_Robot_rot.getW()*2;
            ROS_INFO_STREAM(t.x() << " " << t.y() << " " << t.z() << " " << r << " " << p << " " << y);


            /*

            tf::Vector3 t = transform_msg.getOrigin();
            double r, p, y;
            transform_msg.getBasis().getRPY(r, p, y);

            // this returns the same as the geom_tfFid message but is just a different way of extracting the info
            ROS_INFO("Pose MUL %lf %lf %lf %lf %lf %lf",
              t.x(), t.y(), t.z(), r, p, y);


            
            /*
            tf2Scalar t_x = ft.transform.translation.x;
            tf2Scalar t_y = ft.transform.translation.y;
            tf2Scalar t_z = ft.transform.translation.z;
            tf2::Vector3 v_trans{t_x, t_y, t_z};
            tf2::Transform T_fidCam;
            T_fidCam.setOrigin(ft.transform.translation);
            T_fidCam.setRotation(ft.transform.rotation);
            */

            

            // this returns the same as the geom_tfFid message but is just a different way of extracting the info
            ROS_INFO("Pose MUL %lf %lf %lf %lf %lf %lf",
              t.x(), t.y(), t.z(), r, p, y);

            //tf::StampedTransform trans = markerMsg.pose * transform_msg;
           
            /*
            double variance = ft.object_error * 1e9;


            Observation obs;
            obs = Observation(ft.fiducial_id, tf2::Stamped<TransformWithVariance>(TransformWithVariance(ft.transform,variance),fidTransArrMsg->header.stamp, fidTransArrMsg->header.frame_id));
            T_fid0Cam = obs.T_fidCam;
            */

            




            test_viz_pub.publish(tfRobot);




        }

    }







}

void FiducialLocalization::fiducialsCb(const visualization_msgs::Marker &fid_msg){

    if(fid_msg.ns == "fiducial"){
        //ROS_INFO_STREAM("Marker received. ID = " << fid_msg.id);
        //ROS_INFO_STREAM("Fiducial Pose " << fid_msg.pose);

        tf2_ros::Buffer tfBuffer;
        tf2_ros::TransformListener listener(tfBuffer);
        geometry_msgs::TransformStamped transform_map_odom;

        /*
        try{
            transform_map_odom = tfBuffer.lookupTransform(map_frame, odom_frame, ros::Time(0.5));
        }
        catch(tf2::TransformException ex){
            ROS_ERROR("%s", ex.what());
        }

        if(transform_map_odom.child_frame_id != ""){
            ROS_INFO_STREAM("Transform received");
        }
        */
        /*

        if(fid_msg.id == this->observedFidID){
            ROS_INFO_STREAM("Transform: fid->cam" << this->transform_fid_cam);
            //pose_map_cam.pose.position.x = fid_msg.pose.position.x + this->transform_fid_cam.translation.x;
            //pose_map_cam.pose.position.y = fid_msg.pose.position.y + this->transform_fid_cam.translation.y;
            //ROS_INFO_STREAM("Cam Pose: " <<pose_map_cam);
            

            float angle = this->transform_fid_cam.rotation.z;   //rotations are relative to world. Z = up
            float hyp = this->transform_fid_cam.translation.z;  //translations are relative to camera. Z = away from cam
            float new_x = hyp * sin(angle);
            float new_y = hyp * cos(angle);

            if(this->transform_fid_cam.translation.x != 0){
                float xoffset = this->transform_fid_cam.translation.x;
                new_x = xoffset * cos(angle);
                new_y = xoffset * sin(angle);
            }

            //now new x and y represent the camera relative to fiducial location

            pose_map_cam.pose.position.x = fid_msg.pose.position.x - new_x;
            pose_map_cam.pose.position.y = fid_msg.pose.position.y - new_y;


            pose_map_cam.header.frame_id = map_frame;

            test_viz_pub.publish(pose_map_cam);
        }

        */



    }

}



FiducialLocalization::FiducialLocalization(ros::NodeHandle &nh) : nh_(nh){
  
    map_frame = getParam<std::string>(nh_, "map_frame", "map"); 

    odom_frame = getParam<std::string>(nh_, "odom_frame", "odom");

    cam_frame = getParam<std::string>(nh_, "camera_frame", "usb_cam");

    base_frame = getParam<std::string>(nh_, "base_link_frame", "base_link");

    fiducial_transform_array_topic = getParam<std::string>(nh_, "fiducial_transform_array_topic", "/fiducial_transforms");

    odom_topic = getParam<std::string>(nh_, "odom_pub", "/fiducial_odom");

    fiducials_topic = getParam<std::string>(nh_, "fiducials_topic", "/fiducials");

    odom_pub = nh_.advertise<nav_msgs::Odometry>(odom_topic, 10);

    fiducial_transform_array_sub = nh_.subscribe(fiducial_transform_array_topic, 1, &FiducialLocalization::fiducialTransformArrayCb, this);

    //fiducials_sub = nh_.subscribe(fiducials_topic, 16, &FiducialLocalization::fiducialsCb, this);

    this->observedFidID = 0;



    test_viz_pub = nh_.advertise<geometry_msgs::PoseStamped>("/fiducial_localization/test_pose", 5);

    
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

