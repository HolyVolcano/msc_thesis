# -*- coding: utf-8 -*-
"""
Created on Wed Nov 16 17:30:03 2022

@author: MJA
"""

import cv2
import numpy as np
import os
from skimage.io import imshow, imread
from skimage.color import rgb2yuv, rgb2hsv, rgb2gray, yuv2rgb, hsv2rgb
from scipy.signal import convolve2d
import matplotlib.pyplot as plt
import cv2


os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\frames\child_sharp")

video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\crop\child"

video_list = os.listdir(video_dir)



# Sharpen
sharpen = np.array([[0, -1, 0],
                    [-1, 5, -1],
                    [0, -1, 0]])

def multi_convolver(image, kernel, iterations):
    for i in range(iterations):
        image = convolve2d(image, kernel, 'same', boundary = 'fill',
                           fillvalue = 0)
    return image

def convolver_rgb(image, kernel, iterations):
    img_yuv = rgb2yuv(image)   
    img_yuv[:,:,0] = multi_convolver(img_yuv[:,:,0], kernel, 
                                     iterations)
    final_image = yuv2rgb(img_yuv)
    return final_image


for idx, video in enumerate(video_list):

    # Playing video from file:
    cap = cv2.VideoCapture(os.path.join(video_dir,video))
    

    
    currentFrame = 0
    while(True):
        # Capture frame-by-frame
        ret, frame = cap.read()
    
        # Saves image of the current frame in jpg file
        name = 'frame_' + str(currentFrame) + '.jpg'
        print ('Creating...' + name)
        
        # final_frame = convolver_rgb(frame, sharpen, iterations = 1)
        image_sharp = cv2.filter2D(src=frame, ddepth=-1, kernel=sharpen)
        cv2.imwrite(name, image_sharp)
    
        # To stop duplicate images
        currentFrame += 1
    
    # When everything done, release the capture
    cap.release()
    cv2.destroyAllWindows()

