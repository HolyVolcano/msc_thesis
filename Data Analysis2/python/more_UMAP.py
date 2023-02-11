# -*- coding: utf-8 -*-
"""
Created on Mon Feb  6 09:51:53 2023

@author: MJAR0016
"""


import umap

from umap import UMAP
import plotly.express as px
import pandas as pd
from sklearn.preprocessing import StandardScaler
import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

penguins = pd.read_csv(r"C:\Users\MJAR0016\Desktop\final_bun.csv")
penguins = penguins.drop(5)

penguins1 = penguins[['Openface_gaze_child' ,'Fer_emotions_child', 'hand_left_x_adult', 'hand_left_y_adult',
                    'hand_right_x_adult','hand_right_y_adult','head_x_adult','head_y_adult','hand_left_x_child',
                    'hand_left_y_child','hand_right_x_child','hand_right_y_child','head_x_child','head_y_child',
                    'Total_video_red_head', 'Total_video_red_body']]

features = penguins1

def draw_umap(n_neighbors=15, min_dist=0.1, n_components=2, metric='euclidean', title=''):
    fit = umap.UMAP(
        n_neighbors=n_neighbors,
        min_dist=min_dist,
        n_components=n_components,
        metric=metric
    )
    u = fit.fit_transform(features);
    fig = plt.figure()
    if n_components == 1:
        ax = fig.add_subplot(111)
        ax.scatter(u[:,0], range(len(u)), c=features)
    if n_components == 2:
        ax = fig.add_subplot(111)
        ax.scatter(u[:,0], u[:,1], c=features)
    if n_components == 3:
        ax = fig.add_subplot(111, projection='3d')
        ax.scatter(u[:,0], u[:,1], u[:,2], c=features, s=100)
    plt.title(title, fontsize=18)
    
    
for n in (2, 5, 7, 10, 15):
   draw_umap(n_neighbors=n, title='n_neighbors = {}'.format(n))   
    