import cv2
import time

map = cv2.imread('/home/elliottwhite/proj515_ws/map/303.pgm')



while(1):
	cv2.imshow('map', map)
	k = cv2.waitKey(5)
	if k==27:
		break

cv2.destroyAllWindows()