# -*- coding: utf-8 -*-
"""
Created on Wed Jan 11 09:51:15 2023

@author: VRYA0001
"""

import os
import cv2
import time
#%% read, resize and save videos

os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\fps")

video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\raw"

video_list = os.listdir(video_dir)

# change directory to save resized videos
#os.chdir("L:/LovbeskyttetMapper/TECTO trial - Video/_Nicklas/Tangram_videos/Patients_processed")

# for subsampled frames 
#os.chdir("L:/LovbeskyttetMapper/TECTO trial - Video/_Nicklas/Tangram_videos/Patients_processed_subsamples")

# Load person detector - if neccessary at some point
#hog = cv2.HOGDescriptor()
#hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())
#%%

sampling_rate = 10 # must be same for all videos. 

for idx, video in enumerate(video_list):
    
    start_time = time.time()
    
    cap = cv2.VideoCapture(os.path.join(video_dir,video))
     
    name_out = video 
    
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    
    #scale shortest side (height) to be 256
    
    width  = cap.get(3)   # float `width`
    height = cap.get(4)  # float `height`
    new_height = 256 # short sized scale
    new_width = round(new_height/(height/width))
    fps = cap.get(5)/sampling_rate
    frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    duration = frame_count/fps
 
    out = cv2.VideoWriter(name_out, fourcc, fps, (int(width), int(height))) # framesize = (width, height)
    frame_idx = 0
    total_samples = 0
    cond = True
    
    while cond:
        
        ret, frame = cap.read()
        # modify frame in here
        # top-left corner (y,x) = 0,0
        
        # pass frame to person-detector and get boxes
        
        #boxes, weights = hog.detectMultiScale(frame, winStride=(8,8) )
        
        #get output bounding box and crop frame to persons only
        
        # get full video, all frames
        if ret:
            
            frame_idx += 1 
            
            if frame_idx % sampling_rate == 0:
                b = cv2.resize(frame, (int(width), int(height)), fx=0,fy=0, interpolation = cv2.INTER_AREA)
                total_samples += 1
                out.write(b)
        
        else: 
            cond = False
        
    print("Done with " + name_out +  " in", round(time.time() - start_time) , "seconds")
    print("Number of frames total: ", frame_idx+1)    
    print("Number of frames sampled: ", total_samples+1)
    
    cap.release()
    out.release()
    cv2.destroyAllWindows()
        
print("Done with all...")

