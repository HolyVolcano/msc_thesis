# -*- coding: utf-8 -*-
"""
Created on Mon Jan 23 14:19:55 2023

@author: VRYA0001
"""

import os
import pandas as pd
import numpy as np

os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\adult_fix")
csv_dir = r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\adult"

csv_list = os.listdir(csv_dir)

child = pd.read_csv(r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\child\hand_left_x.txt", delimiter='[;,]')
print(child.size)

for idx, csv in enumerate(csv_list):
    mat = pd.read_csv((os.path.join(csv_dir,csv)), delimiter='[;,]')
    mat1 = mat[child.size:]
    print(mat1.size)
    mat1.to_csv(csv, header=None, index=None)