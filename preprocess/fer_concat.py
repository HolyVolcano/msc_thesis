# -*- coding: utf-8 -*-
"""
Created on Thu Jan 12 17:31:46 2023

@author: VRYA0001
"""

import os
import time
import pandas as pd

os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\fer_out")

fer_dir = r"C:\Users\VRYA0001\Downloads\preprocess\fer_out"
files = os.listdir(fer_dir)
frames = []

for file in files:
    frames.append(pd.read_csv(file, sep=',', header=None))

df = pd.concat(frames, axis=0)
df.to_csv(r"C:\Users\VRYA0001\Downloads\preprocess\fer_out\fer_out.txt", header=False, index=False)