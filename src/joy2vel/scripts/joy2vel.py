#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Joy

global vel_mag
global turn_mag


vel_mag = 0.5
turn_mag = 0.5

def remap(val, min_old, max_old, min_new, max_new):
	return (val - min_old) / (max_old - min_old) * (max_new - min_new) + min_new

def callback(data):
	twist = Twist()
	turn_deadzone = 0.1

	if ((data.buttons[0] == 1) and (data.buttons[1] != 1)):
		twist.linear.x  = vel_mag * (1 - remap(data.axes[4], -1, 1, 0, 1))
	elif ((data.buttons[1] == 1) and (data.buttons[0] != 1)):
		twist.linear.x  = vel_mag * (remap(data.axes[5], -1, 1, -1, 0))
	if (data.axes[0] > turn_deadzone) or (data.axes[0] < -turn_deadzone):
		twist.angular.z = turn_mag * data.axes[0]
	else:
		twist.angular.z = 0;
	pub.publish(twist)


def start():
	global pub
	pub = rospy.Publisher('mtr_ctrl/cmd_vel', Twist, queue_size=10)
	rospy.Subscriber ("joy", Joy, callback)
	rospy.init_node('Joy2Vel')
	rospy.spin()

if __name__ == '__main__':
	start()


#float Remap(float value, float from1, float to1, float from2, float to2) {
#    return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
#}