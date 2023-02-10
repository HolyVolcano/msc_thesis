# -*- coding: utf-8 -*-
"""
Created on Wed Nov 16 14:40:08 2022

@author: MJA
"""


##########################################################################################

#CIRCUMPHÆEX CIRCLE PART

from fer import FER
import cv2
import os
import operator
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.legend import Legend

# Using readlines()
file1 = open(r'C:\Users\VRYA0001\Downloads\preprocess\fer_out\fer_out.txt', 'r')
Lines = file1.readlines()


valence = [] # list to keep valences values (neutral)
activation = [] # list to keep activation values(list of the other emptions) 

'''
# Strips the newline character
for line in Lines:
    line1 = line.strip()
    line2 = line1.split(",")
    
    el1 = max(line2[0:5]) # element to append for activation list
    el2 = line2[-1] #element to append for valence list
    
    # if emotion is ANGER or FEAR
    if line2.index(el1) == 0 or line2.index(el1) == 2:
        activation.append(float(el1))
        valence.append(-abs(float(el2)))
        
    # if emotion is HAPPY    
    elif line2.index(el1) == 3 or line2.index(el1) == 5:
        activation.append(float(el1))
        valence.append(float(el2))
        
    elif line2.index(el1) == 1 or line2.index(el1) == 4:  
        activation.append(-abs(float(el1)))
        valence.append(-abs(float(el2)))


# Create the cartesian axis
# axes = Axes(xlim=(0,10), ylim=(-5,5), figsize=(9,7))
# axes.draw()

########################################################################################

fig, ax = plt.subplots()
ax.scatter(valence, activation)
#ax.grid(True, which='both')

ax.spines['left'].set_position('zero')

# turn off the right spine/ticks
ax.spines['right'].set_color('none')
#ax.yaxis.tick_left()

# set the y-spine
ax.spines['bottom'].set_position('zero')

# turn off the top spine/ticks
ax.spines['top'].set_color('none')
#ax.xaxis.tick_bottom()

ax.set_xlabel('Valence')
ax.set_ylabel('Activation')
ax.set_title('Circumplex Circle 1')
# plt.scatter( valence, activation)

#########################################################################################


plt.scatter(valence, activation)

plt.xlim(-1, 1)
plt.ylim(-1,1)

plt.title("Circumplex Circle")
plt.xlabel("Valence")
plt.ylabel("Activation")

plt.show()

print(activation)
print("count activation is", len(activation))
print("##########################")
print(valence)  
print("count valence is", len(valence))  

'''
#######################################################################################

#draw all of the emotions on top of each other as they are not frame related

fear = []
angry = []
disgust = []
happy = []
sad = []
surprise = []
valence1 = []
valence2 = []
valence3 = []
valence4 = []
valence5 = []
valence6 = []

for line in Lines:
    line1 = line.strip()
    line2 = line1.split(",")
    
    el1 = max(line2[0:5]) # element to append for activation list
    el2 = line2[-1] #element to append for valence list
    
    # if emotion is ANGER 
    if line2.index(el1) == 0 :
        angry.append(float(el1))
        valence1.append(-abs(float(el2)))
        
    #FEAR
    elif line2.index(el1) == 2:
        fear.append(float(el1))
        valence2.append(-abs(float(el2)))
        
    # if emotion is HAPPY 
    elif line2.index(el1) == 3:
        happy.append(float(el1))
        valence3.append(float(el2))
    
    # emotion is surprise
    elif line2.index(el1) == 5:
        surprise.append(float(el1))
        valence4.append(float(el2))
    
    #emotion is disgust
    elif line2.index(el1) == 1 :  
        activation.append(-abs(float(el1)))
        valence5.append(-abs(float(el2)))
    
    # emotion is sad
    elif line2.index(el1) == 4:  
        sad.append(-abs(float(el1)))
        valence6.append(-abs(float(el2)))



fig, ax = plt.subplots()
ax.scatter(valence1, angry, color='red', label='angry')
ax.scatter(valence5, disgust, color='blue') #we have none with disgust
ax.scatter(valence2, fear, color='green', label='fear')
ax.scatter(valence3, happy, color='yellow', label='happy')
ax.scatter(valence6, sad, color='purple', label='sad')
ax.scatter(valence4, surprise, color='orange', label='suprise')

ax.spines['left'].set_position('zero')

# turn off the right spine/ticks
ax.spines['right'].set_color('none')
#ax.yaxis.tick_left()

# set the y-spine
ax.spines['bottom'].set_position('zero')

# turn off the top spine/ticks
ax.spines['top'].set_color('none')
#ax.xaxis.tick_bottom()

ax.set_xlabel('Valence')
ax.set_ylabel('Activation')
ax.set_title('Circumplex Circle 1')
# plt.scatter( valence, activation)



plt.xlim(-1, 1)
plt.ylim(-1,1)

plt.title("Circumplex Circle")
plt.xlabel("Valence")
plt.ylabel("Activation")

plt.legend()
plt.show()        
        
        