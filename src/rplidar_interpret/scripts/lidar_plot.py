#!/usr/bin/env python

import rospy
import matplotlib.pyplot as plt
import numpy as np
from sensor_msgs.msg import LaserScan

global fig
global plotted

plotted = False


def callback(msg):

	global fig
	global plotted

	numberOfPoints = len(msg.ranges)


	plt.ion()
	

	if plotted == False:
		fig = plt.figure()
		axes = plt.gca()
		axes.set_xlim([-6,6])
		axes.set_ylim([6,-6])
		plotted = True


	# we have h
	# angle = 360/numberOfPoints * point number
	# can calculate x and y
	
	# cos(angle) = x/h
	# h * cos(angle) = x

	# sin(angle) = y/h
	# h * sin(angle) = y

	angle = 0

	for dataIdx in range(0,numberOfPoints):
		
		# dataIdx is equal to the angle of the point!
		# x and y swapped due to spec sheet of A1 Lidar
		
		if (dataIdx > 270):
			angle = dataIdx - 270
			angle = angle * (np.pi / 180)		# convert to rads but keep original variable name
			y = msg.ranges[dataIdx] * np.cos(angle)
			x = msg.ranges[dataIdx] * np.sin(angle)
			plt.scatter(-x, y, s=1)
		elif (dataIdx > 180):
			angle = dataIdx - 180
			angle = angle * (np.pi / 180)
			y = msg.ranges[dataIdx] * np.cos(angle)
			x = msg.ranges[dataIdx] * np.sin(angle)
			plt.scatter(-x, -y, s=1)
		elif (dataIdx > 90):
			angle = dataIdx - 90
			angle = angle * (np.pi / 180)
			y = msg.ranges[dataIdx] * np.cos(angle)
			x = msg.ranges[dataIdx] * np.sin(angle)
			plt.scatter(x, -y, s=1)
		else:
			angle = dataIdx * (np.pi / 180)
			y = msg.ranges[dataIdx] * np.cos(angle)
			x = msg.ranges[dataIdx] * np.sin(angle)
			plt.scatter(x, y, s=1)



	fig.canvas.draw()

	plt.clf()
	
	print("[INFO] Finished plotting")



if __name__ == '__main__':

	rospy.init_node('plot_lidar', anonymous=True)
	sub = rospy.Subscriber("scan", LaserScan, callback, queue_size=None)
	rospy.spin()
