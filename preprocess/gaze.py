# -*- coding: utf-8 -*-
"""
Created on Fri Jan 20 11:42:08 2023

@author: VRYA0001


"""

import os
import pandas as pd
import numpy as np


csv_dir = r"C:\Users\VRYA0001\Downloads\preprocess\gaze_out"

csv_list = os.listdir(csv_dir)

total_frames = 0
total_c_sum = 0

gaze_x_range = np.array([-0.368]) # each column is for a seperate video
gaze_x_range_1_np = gaze_x_range - 0.1
gaze_x_range_1 = gaze_x_range_1_np.tolist()
gaze_x_range_2_np = gaze_x_range + 0.1
gaze_x_range_2 = gaze_x_range_2_np.tolist()

gaze_y_range = np.array([0.190]) # each column is for a sepe rate video
gaze_y_range_1_np = gaze_y_range - 0.1
gaze_y_range_1 = gaze_y_range_1_np.tolist()
gaze_y_range_2_np = gaze_y_range + 0.1
gaze_y_range_2 = gaze_y_range_2_np.tolist()


for idx, csv in enumerate(csv_list):
    mat = pd.read_csv((os.path.join(csv_dir,csv)), delimiter='[;,]')
    
    g_x = mat[" gaze_angle_x"]
    g_x_between = g_x.between(gaze_x_range_1[idx], gaze_x_range_2[idx])


    
    g_y = mat[" gaze_angle_y"]
    g_y_between = g_y.between(gaze_y_range_1[idx], gaze_y_range_2[idx])


    
    g_between = pd.concat([g_x_between, g_y_between], axis = 1)
    c = (g_between[" gaze_angle_x"] & g_between[" gaze_angle_y"]) # only if both columns are true
    c_sum = c.sum()
    total_frames = total_frames + g_x_between.size
    total_c_sum = total_c_sum + c_sum
    print("current frames:", g_x_between.size)
    print("eye contact:", c_sum)

print("\n")    
print("current frames:", total_frames)    
print("total eye contact:", total_c_sum)
percentage = np.round(total_c_sum/total_frames, 3)
print("percentage:", percentage)