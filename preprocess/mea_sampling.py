# -*- coding: utf-8 -*-
"""
Created on Wed Jan 11 16:47:56 2023

@author: VRYA0001
"""

# For Python 2 compatibility.
from __future__ import division, print_function
import pandas as pd
import numpy as np
import os
import time

os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\mea")

def add_empty_rows(df, n_empty, period):
    """ adds 'n_empty' empty rows every 'period' rows  to 'df'. 
        Returns a new DataFrame. """
    
    # to make sure that the DataFrame index is a RangeIndex(start=0, stop=len(df)) 
    # and that the original df object is not mutated. 
    df = df.reset_index(drop=True)
    
    # length of the new DataFrame containing the NaN rows
    len_new_index = len(df) + n_empty*(len(df) // period)
    # index of the new DataFrame
    new_index = pd.RangeIndex(len_new_index)
    
    # add an offset (= number of NaN rows up to that row) 
    # to the current df.index to align with new_index. 
    df.index += n_empty * (df.index
                             .to_series()
                             .groupby(df.index // period)
                             .ngroup())
    
    # reindex by aligning df.index with new_index. 
    # Values of new_index not present in df.index are filled with NaN.
    new_df = df.reindex(new_index)
    
    return new_df



abc = pd.read_csv(r"C:\Users\VRYA0001\Downloads\preprocess\mea\mea.txt", sep=" ", header=None)




abc = add_empty_rows(abc, 1, 2120) # last number is the frequency of interpolation, bigger is better
abc = abc.interpolate(method ='linear', limit_direction ='forward')


np.savetxt("mea_df.txt", abc.values, fmt='%d')

with open(r"C:\Users\VRYA0001\Downloads\preprocess\mea\mea_df.txt") as f:
    lines = f.readlines()
desired_lines = lines[0: :10]


with open(r"C:\Users\VRYA0001\Downloads\preprocess\mea\mea_sampled.txt", 'w+') as f:
    for item in desired_lines:
        f.write("%s" % item)