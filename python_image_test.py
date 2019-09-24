import time
import picamera
import serial
import os
import numpy as np
import cv2
import shutil
import random

ser = serial.Serial('/dev/ttyACM0', 9600)

i = 0
face_found = False

with picamera.PiCamera() as camera:
	
	camera.resolution = (480, 320)
	camera.hflip = True
	camera.vflip = True 
	camera.start_preview()

	time.sleep(2)

	while True:

		idd = 0
		if int(ser.read()):
			idd = int(ser.read())
			print(idd)

		if idd == 1: #takes images

			camera.capture('images/' + str(i) + '.jpg')
			i +=1

		elif idd == 2: #checks to see if there is a face
			face_cascade = cv2.CascadeClassifier('face.xml')

			int face_image_count = 0;
			for k in range(11):
				img = cv2.imread('images/' + str(k) + '.jpg')
				gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

				faces = face_cascade.detectMultiScale(gray, 1.3, 5)
				
				for (x,y,w,h) in faces:
				    cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
				    cv2.imwrite('images/' + str(k) + 'face.jpg',img)

				    cv2.imwrite('faceimages/' + str(face_image_count) + '.jpg',img)
				    face_image_count++

				    ser.write(str(k).encode())
				    print("found face")
				    face_found = True
				    break
			if face_found == False:
				ser.write(str(random.randint(1,13)).encode())

		elif idd == 4: #restarts the program and deletes old images
			shutil.rmtree('../final_project/images')
			os.makedirs('../final_project/images')
			shutil.rmtree('../final_project/faceimages')
			os.makedirs('../final_project/faceimages')
			i =0