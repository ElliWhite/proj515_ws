#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from std_msgs.msg import Float32
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Point, Pose, Quaternion, Twist, Vector3
from sensor_msgs.msg import NavSatFix

from tf.transformations import quaternion_from_euler
from tf.transformations import euler_from_quaternion

import tf
from tf.transformations import quaternion_from_euler
from tf.transformations import euler_from_quaternion

odom_broadcaster = tf.TransformBroadcaster()

print "sensor fusion"
print "fusing fiducial, gps, and odometry data"


# global for condition
foo = 0

# globals
x_pos_out = 0
y_pos_out = 0
z_ori_out = 0
w_ori_out = 0

gps_pos_x = 0
gps_pos_y = 0

fid_pos_x = 0
fid_pos_y = 0
fid_ori_z = 0
fid_ori_w = 0

odom_pos_x = 0
odom_pos_y = 0
odom_ori_z = 0
odom_ori_w = 0

# error for fid_callback
err_x = 0
err_y = 0
err_z = 0
err_w = 0

fid_euler = ()
odom_out_quat = ()
odom_euler_z = 0

def gps_callback(gps_data):
	#print "gps_callback"

	global gps_pos_x
	global gps_pos_y

	gps_pos_x = gps_data.latitude
	gps_pos_y = gps_data.longitude
    
	'''
	remaping gps to world 

	gps_range_x = (gps_max - gps_min)  
	map_range_x = (map_max - map_min)

	gps_pos_x = (((data.latitude - gps_min) * map_range_x) / gps_range_x) + map_min

	'''


	#print gps_pos_x
	#print gps_pos_y

	global foo
	foo = 2

def fid_callback(fid_data):
	#print "fiducial callback"

	global fid_pos_x
	global fid_pos_y
	global fid_ori_z
	global fid_ori_w

	global x_pos_out
	global y_pos_out
	global z_ori_out
	global w_ori_out

	fid_pos_x = fid_data.pose.pose.position.x
	fid_pos_y = fid_data.pose.pose.position.y
	fid_ori_z = fid_data.pose.pose.orientation.z
	fid_ori_w = fid_data.pose.pose.orientation.w
	
	#output the fid pose
	x_pos_out = fid_pos_x
	y_pos_out = fid_pos_y
	z_ori_out = fid_ori_z
	w_ori_out = fid_ori_w
	

	fid_quat = (
			fid_data.pose.pose.orientation.x,
			fid_data.pose.pose.orientation.y,
			fid_ori_z,
			fid_ori_w
			)


	global fid_euler
	fid_euler = tf.transformations.euler_from_quaternion(fid_quat)


	# fiducial filter

	global odom_pos_x
	global odom_pos_y
	global odom_ori_z

	global foo 

	x_tolerance_max = odom_pos_x + 1.0
	x_tolerance_min = odom_pos_x - 1.0
	y_tolerance_max = odom_pos_y + 1.0
	y_tolerance_min = odom_pos_y - 1.0


	if (fid_pos_x > x_tolerance_max) or (fid_pos_x < x_tolerance_min) or (fid_pos_y > y_tolerance_max) or (fid_pos_y < y_tolerance_min):
		foo = 0
	else:
		foo = 1


def odom_callback(odom_data):
	#print "odometry callback"

	global x_pos_out
	global y_pos_out
	global z_ori_out
	global w_ori_out

	global gps_pos_x
	global gps_pos_y

	global fid_pos_x
	global fid_pos_y
	global fid_ori_z
	global fid_ori_w

	global odom_pos_x
	global odom_pos_y
	global odom_ori_z
	global odom_ori_w

	global err_x
	global err_y
	global err_z
	global err_w

	global odom_out_quat
	global odom_euler_z

	odom_pos_x = odom_data.pose.pose.position.x
	odom_pos_y = odom_data.pose.pose.position.y
	odom_ori_z = odom_data.pose.pose.orientation.z
	odom_ori_w = odom_data.pose.pose.orientation.w
	
	odom_quat = (
			odom_data.pose.pose.orientation.x,
			odom_data.pose.pose.orientation.y,
			odom_ori_z,
			odom_ori_w
			)


	odom_euler = tf.transformations.euler_from_quaternion(odom_quat)

	#print "odom_euler[2]"
	#print odom_euler[2]
	


	#x_acc = data.linear_acceleration.x
	#print x_acc

	global foo
	#print foo
	if foo == 1:


		#Do error calculation

		global fid_euler
		odom_euler_z = odom_euler[2]
		fid_euler_z = fid_euler[2]

		err_z = fid_euler_z - odom_euler_z

		z_ori_out = odom_euler_z + err_z

		odom_out_quat = tf.transformations.quaternion_from_euler(0,0,z_ori_out)	

		err_x = fid_pos_x - odom_pos_x
		err_y = fid_pos_y - odom_pos_y
		#err_z = fid_ori_z - odom_ori_z
		#err_w = fid_ori_w - odom_ori_w

		#print odom_euler_z
		#print fid_euler_z
		#print err_z
		#print z_ori_out

		x_pos_out = odom_pos_x + err_x
		y_pos_out = odom_pos_y + err_y
		#z_ori_out = odom_ori_z + err_z
		#w_ori_out = odom_ori_w + err_w


		foo = 0
	elif foo == 2:



		#gains must be less zan 1. eg 0.5 = 50% confidence
		g1 = 1
		g2 = 1


		x_pos_out = (odom_pos_x*g1 + gps_pos_x*g2) / 2

		'''
		print odom_pos_x
		print gps_pos_x
		print x_pos_out
		'''

		foo = 0
	else:
		#print "\nodom"
		#print odom_euler_z
		#print odom_euler[2]
		x_pos_out = odom_pos_x + err_x
		y_pos_out = odom_pos_y + err_y
		z_ori_out = odom_euler[2] + err_z
		#w_ori_out = odom_ori_w + err_w

		odom_out_quat = tf.transformations.quaternion_from_euler(0,0,z_ori_out)

		
		foo = 0
	
	'''
	print x_pos_out
	print y_pos_out
	print z_pos_out
	'''



	# Publisher
	odom_out = Odometry()
	odom_out.header.stamp = rospy.Time.now()
	odom_out.header.frame_id = "odom"
	odom_out.child_frame_id = "base_link"

	
	odom_out.pose.pose.position.x = x_pos_out
	odom_out.pose.pose.position.y = y_pos_out

	#odom_out.pose.pose.orientation.z = z_ori_out
	#odom_out.pose.pose.orientation.w = w_ori_out

	odom_out.pose.pose.orientation.x = odom_out_quat[0]
	odom_out.pose.pose.orientation.y = odom_out_quat[1]
	odom_out.pose.pose.orientation.z = odom_out_quat[2]
	odom_out.pose.pose.orientation.w = odom_out_quat[3]

	

	'''
	odom_quat = tf.transformations.quaternion_from_euler(0, 0, z_pos_out)

	odom_pub.pose.pose = Pose(Point(x_pos_out, y_pos_out, 0.), Quaternion(*odom_quat))
	'''

	#read in the vx vy vth of the wheel odom

	#odom_pub.twist.twist = Twist(Vector3(vx, vy, 0), Vector3(0, 0, vth))

	# publish the message
	odom_pub.publish(odom_out)

	# broadcast tf
	tf_broadcast()

#print foo



def tf_broadcast():
	

	# http://wiki.ros.org/navigation/Tutorials/RobotSetup/Odom#Using_tf_to_Publish_an_Odometry_transform
	# https://answers.ros.org/question/69754/quaternion-transformations-in-python/
	# http://wiki.ros.org/tf/Tutorials/Writing%20a%20tf%20broadcaster%20%28Python%29

	global x_pos_out
	global y_pos_out
	global z_ori_out
	global w_ori_out


	odom_broadcaster.sendTransform ((x_pos_out, y_pos_out, 0),
                         tf.transformations.quaternion_from_euler(0, 0, z_ori_out),
                         rospy.Time.now(),
                         "base_link",
                         "odom")

	


def listener():

	# In ROS, nodes are uniquely named. If two nodes with the same
	# name are launched, the previous one is kicked off. The
	# anonymous=True flag means that rospy will choose a unique
	# name for our 'listener' node so that multiple listeners can
	# run simultaneously.


	

	rospy.Subscriber("fiducial_localization/fiducial_odom", Odometry, fid_callback)
	rospy.Subscriber("wheel_odom/exact_odom", Odometry, odom_callback)
	rospy.Subscriber("gps_odom", NavSatFix, gps_callback)

	# spin() simply keeps python from exiting until this node is stopped
	rospy.spin()




if __name__ == '__main__':

	rospy.init_node('sensor_fusion', anonymous=True)
	# Output odom publisher "fused_odom"

	current_time = rospy.Time.now()
	odom_pub = rospy.Publisher('fused_odom', Odometry, queue_size=10)
	rate = rospy.Rate(10)
	listener()
	













