# -*- coding: utf-8 -*-
"""
Created on Sun Feb  5 18:15:58 2023

@author: MJAR0016
"""

import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd


sns.set(style='white', context='notebook', rc={'figure.figsize':(14,10)})


penguins = pd.read_csv(r"C:\Users\MJAR0016\Desktop\final_bun.csv")
penguins.head()



penguins = penguins.drop(5)
#penguins.head()

penguins.Type.value_counts()

penguins1 = penguins[['Openface_gaze_child' ,'Fer_emotions_child', 'hand_left_x_adult', 'hand_left_y_adult',
                    'hand_right_x_adult','hand_right_y_adult','head_x_adult','head_y_adult','hand_left_x_child',
                    'hand_left_y_child','hand_right_x_child','hand_right_y_child','head_x_child','head_y_child',
                    'Total_video_red_head', 'Total_video_red_body']]

penguins1 = penguins1.dropna()



import umap
reducer = umap.UMAP()

scaled_penguin_data = StandardScaler().fit_transform(penguins1)


embedding = reducer.fit_transform(scaled_penguin_data)
embedding.shape



plt.scatter(
    embedding[:, 0],
    embedding[:, 1],
    c=[sns.color_palette()[x] for x in penguins.Type.map({ "Control":0, "OCD":1})])
plt.gca().set_aspect('equal', 'datalim')
# plt.colorbar(boundaries=np.arange(2)-0.5).set_ticks(np.arange(2))
plt.legend((0,1),
           ('Control', 'OCD'),
           scatterpoints=1,
           loc='lower left',
           ncol=3,
           fontsize=8)
plt.title('UMAP projection of the OCD dataset', fontsize=24);


