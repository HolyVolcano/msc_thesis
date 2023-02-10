# -*- coding: utf-8 -*-
"""
Created on Mon Nov  7 17:16:03 2022

@author: MJA
"""

from fer import FER
import cv2
import os
import operator
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.legend import Legend

# Using readlines()
file1 = open(r"C:\Users\VRYA0001\Downloads\preprocess\fer_out\fer_out.txt")
Lines = file1.readlines()

count_list = 0 #variable to know I past through the first element
# also numbver of frames
list_max_indexes = [] #list in which to keep the indexes of 2 maxs in a vector
final_list_indexes = [] #discretising the signal based on indexes corresponding to diff emo
final_list_values = [] #final values corresp to emotions


# Strips the newline character
for line in Lines:
    line1 = line.strip()
    line2 = line1.split(",")
    line3 = max(line2) # keeps the first max in the vector
    index_1 = line2.index(line3) #index of first max
    
    #build exception for the first frame, otherwise out of range
    if count_list == 0 :
        final_list_indexes.append(index_1) 
        final_list_values.append(line3)
        
    # check if there are any other max's in the vector
    if count_list!=0:
        for i, item in enumerate(line2):
            if item==line3 and index_1!=i:
                list_max_indexes.append(index_1)
                list_max_indexes.append(i)
                
  
    # variable to initialise with the last element from final list
    previous_frame_index = final_list_indexes[-1]
    
    #check if the current frame index matches with the old one
    if len(list_max_indexes) !=0 :
        for j, item1 in enumerate(list_max_indexes):
            if item1 == previous_frame_index:
                final_list_indexes.append(item1)
                final_list_values.append(line3)
                list_max_indexes = []
        # if after the for loop before list_max_indexes is not null it means the frames 
        # do not have equal indexes case in which the value will be the first max
        if len(list_max_indexes)!=0:
            final_list_indexes.append(index_1)
            final_list_values.append(line3)
    # in case the list is empty and it is not about the first frame => it goes to general
    # initialization
    elif len(list_max_indexes) == 0 and count_list!=0:    
        final_list_indexes.append(index_1)
        final_list_values.append(line3)
        
    count_list = count_list + 1
    
print(final_list_indexes)
print(final_list_values)
#print(len(final_list_values))

#put the out in a txt file to plot in matlab
# THE EMOTION
with open(r"C:\Users\VRYA0001\Downloads\preprocess\fer_out\EMOTION_CLASS.txt", 'w+') as f:
    for item in final_list_indexes:
        f.write("%s\n" % item)

########## the EMOTION INTENSITY ##############       
with open(r"C:\Users\VRYA0001\Downloads\preprocess\fer_out\Emotion_Intensity.txt", 'w+') as f:
    for item in final_list_values:
        f.write("%s\n" % item)
        
x = np.linspace(0, 10, 1000)
fig = plt.figure(figsize=(12, 6))
plt.plot(final_list_values) 
#plt.ylabel('some numbers')

plt.show()


#########################################################################################

# visualising discrete emotions
       
import pandas as pd
import random
import string

strings = [str(x) for x in final_list_indexes]    
strings = list(map(lambda x: x.replace('0', 'angry'), strings))
strings = list(map(lambda x: x.replace('1', 'disgust'), strings))
strings = list(map(lambda x: x.replace('2', 'fear'), strings))
strings = list(map(lambda x: x.replace('3', 'happy'), strings))
strings = list(map(lambda x: x.replace('4', 'sad'), strings))
strings = list(map(lambda x: x.replace('5', 'surprise'), strings))
strings = list(map(lambda x: x.replace('6', 'neutral'), strings))
#print(strings)


df = pd.DataFrame(strings, columns=['Emotions'])
#print(df)
'''
plt.hist(df['Emotions'], bins=6, color='purple', edgecolor='black', linewidth=1 )
plt.title('Distribution of emotions per frames',fontsize=12)
plt.xlabel('Emotions',fontsize=10)
plt.ylabel('Number of frames',fontsize=10)
'''


N, bins, patches = plt.hist(df['Emotions'], bins=6,edgecolor='black', linewidth=1 )
# Random facecolor for each bar
for i in range(len(N)):
    patches[i].set_facecolor("#" + ''.join(random.choices("ABCDEF" + string.digits, k=6)))


plt.title('Distribution of emotions per frames',fontsize=12)
plt.xlabel('Emotions',fontsize=10)
plt.ylabel('Number of frames',fontsize=10)
plt.show()

##########################################################################################

# A box and whisker plot is a diagram that shows the statistical distribution of a set of data. 
# This makes it easy to see how data is distributed along a number line.

import plotly. offline as pyo
import plotly. graph_objs as go

# trace2 = go. Box (y = df['Emotions'], name = 'Emotions')
# data = [trace2]
# layout = go. Layout (title = 'Box and Whisker plot')
# fig = go. Figure (data = data, layout = layout)
# pyo. plot(fig)

##########################################################################################

# import plotly. graph_objs as go
# import plotly. offline as pyo
# # data = df['Emotions']
# labels=['neutral','angry','happy','sad', 'fear', 'surprise']
# # values are how many times appear in frames taken from N from hist
# values = [453,20,94,181,147,27]
# fig = go.Figure(data=[go.Pie(labels = labels, values=values)])
# pyo.plot(fig)
# fig.show()
