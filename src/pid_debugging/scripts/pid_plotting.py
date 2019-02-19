#!/usr/bin/env python

import rospy
import matplotlib.pyplot as plt
import numpy as np
from std_msgs.msg import Float64
from std_msgs.msg import Float32

global left_vel_list
global right_vel_list
global time_list
global total_time
global target_vel_list
global previous_left_vel

left_vel_list = []
right_vel_list = []
time_list = []
total_time = 0
target_vel_list = []
previous_left_vel = 0


def left_vel_cb(msg):
	global left_vel_list
	global previous_left_vel
	if(abs(msg.data-previous_left_vel)>1):
		left_vel_list.append(previous_left_vel)
	else:
		previous_left_vel = msg.data
	left_vel_list.append(msg.data)
		
	

def right_vel_cb(msg):
	global right_vel_list

	right_vel_list.append(msg.data)

def time_cb(msg):
	global time_list
	global total_time

	if(msg.data > 1):
		total_time = total_time + 0.015
	else:
		total_time = total_time + msg.data

	time_list.append(total_time)

def target_vel_cb(msg):
	global target_vel_list

	target_vel_list.append(msg.data)



if __name__ == '__main__':
	global left_vel_list
	global right_vel_list
	global time_list
	global target_vel_list

	list_length = 250

	rospy.init_node('pid_plot', anonymous=True)
	left_vel_sub = rospy.Subscriber("left_vel", Float64, left_vel_cb, queue_size=10)
	right_vel_sub = rospy.Subscriber("right_vel", Float64, right_vel_cb, queue_size=10)
	time_sub = rospy.Subscriber("motor_time", Float64, time_cb, queue_size=10)
	target_vel_sub = rospy.Subscriber("target_vel", Float64, target_vel_cb, queue_size=10)

	while(len(left_vel_list) < list_length):
		test = 1
	left_vel_sub.unregister()
	while(len(right_vel_list) < list_length):
		test = 1
	right_vel_sub.unregister()
	while(len(time_list) < list_length):
		test = 1
	time_sub.unregister()
	while(len(target_vel_list) < list_length):
		test = 1
	target_vel_sub.unregister()


	new_left_list = left_vel_list[:list_length]

	new_right_list = right_vel_list[:list_length]

	new_time_list = time_list[:list_length]

	new_target_vel_list = target_vel_list[:list_length]



	fig = plt.figure()


	axes = plt.gca()
	#axes.set_xlim([-6,6])
	axes.set_ylim([-0.2,2])

	fig.suptitle('Kp = 0.4, Ki = 9, Kd = 0.2', fontsize=16)
	#fig.suptitle('Kp = 2.5, Ki = 7, Kd = 0.15', fontsize=16)
	#fig.suptitle('LEFT: Kp = 5000, Ki = 7, Kd = 200\nRIGHT: Kp = 1500, Ki = 5.2, Kd = 200', fontsize=16)
	axes.set_xlabel('Time (s)')
	axes.set_ylabel('Velocity (m/s)')



	l_line, = plt.plot(new_time_list, new_left_list)
	l_line.set_label('Left Motor Velocity')
	#r_line, = plt.plot(new_time_list, new_right_list)
	#r_line.set_label('Right Motor Velocity')
	tar_line, = plt.plot(new_time_list, new_target_vel_list)
	tar_line.set_label('Target Velocity')
	plt.legend()
	plt.show()



