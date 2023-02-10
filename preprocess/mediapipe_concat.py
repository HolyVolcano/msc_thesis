# -*- coding: utf-8 -*-
"""
Created on Thu Jan 12 17:31:46 2023

@author: VRYA0001
"""

import os
import time
import pandas as pd

os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe")
csv_dir = r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\adult"
csv_list = os.listdir(csv_dir)

frames = pd.DataFrame()

for idx, csv in enumerate(csv_list):
    mat = pd.read_csv((os.path.join(csv_dir,csv)), delimiter='[;,]')
    
    frames[idx] = mat


# df = pd.concat(frames, axis=0)
# df.to_csv(r"C:\Users\VRYA0001\Downloads\preprocess\fer_out\fer_out.txt", header=False, index=False) 