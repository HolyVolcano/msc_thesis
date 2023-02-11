# -*- coding: utf-8 -*-
"""
Created on Mon Jan 23 12:24:58 2023

@author: MJAR0016
"""

import numpy as np
import pandas as pd

# Create NumPy array
#arr = np.array([5,6,4])

df = pd.read_excel(r"C:\Users\MJAR0016\Desktop\data\OCD\1128_MLL\mediapipe.xlsx")

# Get the Standard Deviation of 1-dimensional array

################################ CHILD ########################################################

std_df1_a = np.std(df["hand_left_x_adult"])
std_df2_a = np.std(df["hand_left_y_adult"])
std_df3_a = np.std(df["hand_right_x_adult"])
std_df4_a = np.std(df["hand_right_y_adult"])                 
std_df5_a = np.std(df["head_x_adult"])
std_df6_a = np.std(df["head_y_adult"]) 


############################## ADULT ############################################################

std_df1_c = np.std(df["hand_left_x_child"])
std_df2_c = np.std(df["hand_left_y_child"])
std_df3_c = np.std(df["hand_right_x_child"])
std_df4_c = np.std(df["hand_right_y_child"])   
std_df5_c = np.std(df["head_x_child"])
std_df6_c = np.std(df["head_y_child"]) 


print(std_df1_a,std_df2_a,std_df3_a,std_df4_a,std_df5_a,std_df6_a)
print(std_df1_c,std_df2_c,std_df3_c,std_df4_c,std_df5_c,std_df6_c)

with open(r"C:\Users\MJAR0016\Desktop\output.txt", "a") as f:
  print("1128_MLL:",std_df1_a,std_df2_a,std_df3_a,std_df4_a,std_df5_a,std_df6_a, std_df1_c,std_df2_c,std_df3_c,std_df4_c,std_df5_c,std_df6_c, file=f)
f.close()