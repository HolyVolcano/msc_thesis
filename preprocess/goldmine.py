# -*- coding: utf-8 -*-
"""
Created on Mon Jan 23 16:08:41 2023

@author: VRYA0001
"""

import os
import pandas as pd
import numpy as np

os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\adult_fix2")
csv_dir = r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\adult_fix"

csv_list = os.listdir(csv_dir)


for idx, csv in enumerate(csv_list):
    mat = pd.read_csv((os.path.join(csv_dir,csv)), delimiter='[;,]')
    print("old max mat \n", mat.max) 
    mat.mask((mat >= 1) & (mat <= 0), inplace=True)
    mat.interpolate(method='linear', axis=1)
    print("new max mat \n", mat.max)