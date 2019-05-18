
#include <string>
#include <sstream>

#include "math.h"

#include <ros/ros.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>

#include <visualization_msgs/Marker.h>
#include "fiducial_msgs/Fiducial.h"
#include "fiducial_msgs/FiducialArray.h"
#include "fiducial_msgs/FiducialTransform.h"
#include "fiducial_msgs/FiducialTransformArray.h"

#include "nav_msgs/Odometry.h"

#include "geometry_msgs/PoseArray.h"
#include "geometry_msgs/Transform.h"

#include <boost/filesystem.hpp>
#include <stdio.h>


/* Function to get a parameter from the launch file */
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


/* Function to create a quaternion from Euler angles */
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



class FiducialLocalization {

    private:
        std::string map_frame;
        std::string odom_frame;
        std::string base_frame;
        std::string cam_frame;
        std::string fiducial_transform_array_topic;
        std::string odom_topic;
        std::string fiducials_topic;
        std::string map_filename;

        geometry_msgs::PoseArray fiducial_poses;
        std::vector<int>fiducial_ids;

        ros::Publisher odom_pub;

        ros::Subscriber fiducial_transform_array_sub;
        ros::Subscriber fiducials_sub;

        ros::NodeHandle nh_;

        void fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray::ConstPtr& msg);

        bool loadMap(std::string filename);

        ros::Publisher test_viz_pub;

    public:

        FiducialLocalization(ros::NodeHandle &nh);

};


void FiducialLocalization::fiducialTransformArrayCb(const fiducial_msgs::FiducialTransformArray::ConstPtr& fidTransArrMsg) {

    const fiducial_msgs::FiducialTransform &ft = fidTransArrMsg->transforms[0];

    int numberOfIDs = fidTransArrMsg->transforms.size();

    // Initially no IDs are published until 1 marker as been seen
    if (numberOfIDs > 0) {

        tf::TransformListener listener;
        tf::StampedTransform t_baseFid;

        std::stringstream sstm;
        sstm << "fid" << ft.fiducial_id;
        std::string fiducial_frame = sstm.str();

        bool foundTF = false;

        // Listen for transform base_link -> fiducial
        try {
            listener.waitForTransform(base_frame, fiducial_frame, ros::Time(0), ros::Duration(1.0));
            listener.lookupTransform(base_frame, fiducial_frame, ros::Time(0), t_baseFid);
            foundTF = true;
        }
        catch (tf::TransformException ex) {
            ROS_ERROR("%s", ex.what());
        }

        if (foundTF) {

            // Find the detected fiducial ID in list of IDs
            std::vector<int>::iterator it = std::find(fiducial_ids.begin(), fiducial_ids.end(), ft.fiducial_id);

            if (it != fiducial_ids.end()) {

                // Found ID in list
                int index = std::distance(fiducial_ids.begin(), it);
                geometry_msgs::Pose fiducial_pose = fiducial_poses.poses[index];

                ROS_INFO_STREAM("Found observed fiducial ID in list of fiducials currently in the map");

                tf::Transform t_mapFid;                                         // Create a transform of the fiducial from map->fid

                tfScalar m_x = fiducial_pose.position.x;
                tfScalar m_y = fiducial_pose.position.y;
                tfScalar m_z = fiducial_pose.position.z;
                tf::Vector3 fiducial_origin(m_x, m_y, m_z);                       // Create a vector for the origin of the fiducial frame to be the
                // same as the location of the observed marker

                t_mapFid.setOrigin(fiducial_origin);                              // Set the origin of the fiducial frame to be location of the marker

                tfScalar r_x = fiducial_pose.orientation.x;
                tfScalar r_y = fiducial_pose.orientation.y;
                tfScalar r_z = fiducial_pose.orientation.z;
                tfScalar r_w = fiducial_pose.orientation.w;

                tf::Quaternion fiducial_rotation(r_x, r_y, r_z, r_w);             // Create a quaternion for the fiducial frame to be the same
                // as the quaternion of the observed marker

                t_mapFid.setRotation(fiducial_rotation);                          // Set the rotation of the fiducial frame to be the same as the observed
                // marker

                tf::Transform t_fidBase = t_baseFid.inverse();                  // Create a transform from fid->base_link (originally base_link->fid, hence inverse)

                ROS_INFO_STREAM(t_fidBase.getOrigin());

                tf::Transform t_mapBase;                                        // Create a transform of the robot from map->base_link
                t_mapBase.mult(t_mapFid, t_fidBase);                            // This transform is a result of map->fid and fid->base_link

                foundTF = false;

                tf::StampedTransform t_mapOdom;

                // Try and find transform from map->odom
                try {
                    listener.waitForTransform(map_frame, odom_frame, ros::Time(0), ros::Duration(0.5));
                    listener.lookupTransform(map_frame, odom_frame, ros::Time(0), t_mapOdom);
                    foundTF = true;
                }
                catch (tf::TransformException ex) {
                    ROS_ERROR("%s", ex.what());
                }

                if (foundTF) {

                    tf::Transform t_odomMap = t_mapOdom.inverse();

                    tf::Transform t_odomBase;                                       // Create transform odom -> base_link
                    t_odomBase.mult(t_odomMap, t_mapBase);


                    tf::Vector3 t_odomBase_pose = t_odomBase.getOrigin();           // Get origin of base_link relative to map
                    double r, p, y;
                    t_odomBase.getBasis().getRPY(r, p, y);                          // Get orientation of base_link relative to map in RPY form
                    tf::Quaternion t_odomBase_rot = t_odomBase.getRotation();       // Get quaternion of base_link so can extract Omega

                    t_odomBase_rot.normalize();

                    geometry_msgs::PoseStamped pose_Base;                           // Create PoseStamped message so can add Pose to RViz
                    pose_Base.header.frame_id = odom_frame;                         // Set frame base_link tf is associated with to map frame
                    pose_Base.pose.position.x = t_odomBase_pose.x();                // Set XYZ location of Pose to base_link pose
                    pose_Base.pose.position.y = t_odomBase_pose.y();
                    pose_Base.pose.position.z = t_odomBase_pose.z();
                    pose_Base.pose.orientation.x = r;                               // Set RPY of Pose message to that of the base_link
                    pose_Base.pose.orientation.y = p;
                    pose_Base.pose.orientation.z = t_odomBase_rot.z();
                    pose_Base.pose.orientation.w = t_odomBase_rot.getW();           // Set Omega to that of base_link
                    test_viz_pub.publish(pose_Base);                                // Publish Pose

                    nav_msgs::Odometry odom_Base;                                   // Create Odometry message for fiducial localization
                    odom_Base.header.frame_id = odom_frame;                         // Assign parent frame to odometry frame
                    odom_Base.header.stamp = ros::Time::now();                      // Assign timestamp to the current time
                    odom_Base.child_frame_id = base_frame;                          // Assign child frame to base_link

                    odom_Base.pose.pose.position.x = t_odomBase_pose.x();           // Set XYZ location of base_link
                    odom_Base.pose.pose.position.y = t_odomBase_pose.y();
                    //odom_Base.pose.pose.position.z = t_odomBase_pose.pose.z();    // Don't need any Z estimation as on 2D plane only
                    //odom_Base.pose.pose.orientation.x = r;                        // Don't need RP
                    //odom_Base.pose.pose.orientation.y = p;
                    odom_Base.pose.pose.orientation.z = t_odomBase_rot.z();         // Set rotation around Z to be yaw
                    odom_Base.pose.pose.orientation.w = t_odomBase_rot.getW();      // Set Omega for base_link
                    //odom_Base.twist.twist;                                        // Don't need as not calculating any velocities

                    odom_pub.publish(odom_Base);                                    // Publish odometry message
                }

            } else {
                ROS_ERROR("Could not find Fiducial ID %d in list of fiducials currently in the map\n", ft.fiducial_id);
            }

        }

    }

}

/* Function to load aruco map file */
bool FiducialLocalization::loadMap(std::string filename) {

    // Load Aruco marker map
    ROS_INFO_STREAM("Load map " << filename);

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

        int id;
        double tx, ty, tz, rx, ry, rz, var;
        int numObs = 0;
        linkbuf[0] = '\0';

        // Read line
        int nElems = sscanf(linebuf, "%d %lf %lf %lf %lf %lf %lf %lf %d%[^\t\n]*s",
                            &id, &tx, &ty, &tz, &rx, &ry, &rz, &var, &numObs, linkbuf);
        if (nElems == 9 || nElems == 10) {

            // Push back ID
            fiducial_ids.push_back(id);

            // Create a pose to hold fiducial pose
            geometry_msgs::Pose fiducial_pose;

            // Set pose information
            fiducial_pose.position.x = tx;
            fiducial_pose.position.y = ty;
            fiducial_pose.position.z = tz;

            // Create a quaternion as transforms take orientation in quaternion form
            geometry_msgs::Quaternion q;
            q = createQuaternionFromRPY((rx * M_PI / 180), (ry * M_PI / 180), (rz * M_PI / 180));

            // Set orientation information
            fiducial_pose.orientation.x = q.x;
            fiducial_pose.orientation.y = q.y;
            fiducial_pose.orientation.z = q.z;
            fiducial_pose.orientation.w = q.w;

            // Add fiducial pose to list of poses
            fiducial_poses.poses.push_back(fiducial_pose);

            numRead++;
        }
        else {
            ROS_WARN("Invalid line: %s", linebuf);
        }
    }

    // Close file
    fclose(fp);
    ROS_INFO("Load map %s read %d entries", filename.c_str(), numRead);
    return true;

}



FiducialLocalization::FiducialLocalization(ros::NodeHandle &nh) : nh_(nh) {

    map_frame = getParam<std::string>(nh_, "map_frame", "map");

    odom_frame = getParam<std::string>(nh_, "odom_frame", "odom");

    cam_frame = getParam<std::string>(nh_, "camera_frame", "usb_cam");

    base_frame = getParam<std::string>(nh_, "base_link_frame", "base_link");

    fiducial_transform_array_topic = getParam<std::string>(nh_, "fiducial_transform_array_topic", "/fiducial_transforms");

    odom_topic = getParam<std::string>(nh_, "odom_pub", "/fiducial_localization/fiducial_odom");

    fiducials_topic = getParam<std::string>(nh_, "fiducials_topic", "/fiducials");

    map_filename = getParam<std::string>(nh_, "map_file", std::string(getenv("HOME")) + "/.ros/slam/map.txt");

    odom_pub = nh_.advertise<nav_msgs::Odometry>(odom_topic, 10);

    fiducial_transform_array_sub = nh_.subscribe(fiducial_transform_array_topic, 1, &FiducialLocalization::fiducialTransformArrayCb, this);

    test_viz_pub = nh_.advertise<geometry_msgs::PoseStamped>("/fiducial_localization/test_pose", 5);

    boost::filesystem::path mapPath(map_filename);
    boost::filesystem::path dir = mapPath.parent_path();
    boost::filesystem::create_directories(dir);

    if (!loadMap(map_filename)) {
        ROS_ERROR("Could not open %s for read", map_filename.c_str());
    }

}




int main(int argc, char **argv) {

    ros::init(argc, argv, "fiducial_localization");

    ros::NodeHandle nh("~");

    FiducialLocalization node(nh);

    ros::Rate r(10);

    while (ros::ok()) {
        ros::spinOnce();
        r.sleep();
    }

    return 0;
}

