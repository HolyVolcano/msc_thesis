# -*- coding: utf-8 -*-
"""
Created on Fri Jan 20 15:58:27 2023

@author: VRYA0001
"""

import os
import pandas as pd
import numpy as np


csv_dir = r"C:\Users\VRYA0001\Downloads\preprocess\gaze_out"

csv_list = os.listdir(csv_dir)

total_frames = 0
total_intensity = 0

for idx, csv in enumerate(csv_list):
    df = pd.read_csv(os.path.join(csv_dir,csv), header = None)
    total_frames = total_frames + df.size
    df_sum = df.sum()
    total_intensity = total_intensity + df_sum

print("\n")    
print("current frames: ", total_frames, "\n")    
print("df_sum: ", df_sum, "\n")
mean = np.round(df_sum/total_frames, 7)
print("percentage: ", mean)