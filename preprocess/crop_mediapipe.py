# -*- coding: utf-8 -*-
"""
Created on Tue Jan 10 17:41:41 2023

@author: VRYA0001
"""

import cv2
import time
import os


os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\crop_mediapipe\child")

video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\fps"

video_list = os.listdir(video_dir)

for idx, video in enumerate(video_list):
    
    name_out = video

    cap = cv2.VideoCapture(os.path.join(video_dir,video))
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    
    width  = cap.get(3)   # float `width`
    height = cap.get(4)  # float `height`
    
    
    out = cv2.VideoWriter(name_out, fourcc, 29.97, (int(width), int(height)))
    writerInit = False
    while True:
        ret, image_np = cap.read()
        if not ret:
            break;
    
            
        
        roi = image_np[0:int(height), 160:320] # Crop the pixels here!!!! for child
        if(not writerInit):
            h,w,_ = roi.shape
            out = cv2.VideoWriter(name_out, fourcc, 2.997, (w, h))
            writerInit = True
    
        out.write(roi)
    
    cap.release()
    out.release()
    
    
os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\crop_mediapipe\adult")

video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\fps"

video_list = os.listdir(video_dir)

for idx, video in enumerate(video_list):
    
    name_out = video

    cap = cv2.VideoCapture(os.path.join(video_dir,video))
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    
    width  = cap.get(3)   # float `width`
    height = cap.get(4)  # float `height`
    
    
    out1 = cv2.VideoWriter(name_out, fourcc, 29.97, (int(width), int(height)))
    writerInit = False
    while True:
        ret, image_np = cap.read()
        if not ret:
            break;
    
            
        
        roi = image_np[0:int(height), 0:160] # Crop the pixels here!!!! for adult
        if(not writerInit):
            h,w,_ = roi.shape
            out1 = cv2.VideoWriter(name_out, fourcc, 2.997, (w, h))
            writerInit = True
    
        out1.write(roi)
    
    cap.release()
    out.release()