# -*- coding: utf-8 -*-
"""
Created on Mon Nov  7 15:59:24 2022

@author: MJA
"""

from fer import FER
import cv2
import os

# assign directory for numerically ascending frames in the form of "frame_xx.txt"
directory = r'C:\Users\VRYA0001\Downloads\preprocess\frames\child_sharp\4'

def extract_integer(filename):
    return int(filename.split('.')[0].split('_')[1])

angry = []
disgust = []
fear = []
happy = []
sad = []
surprise = []
neutral = []

# iterate over files in
# that directory
detector = FER(mtcnn=True)

for filename in sorted(os.listdir(directory), key=extract_integer):
    f = os.path.join(directory, filename)
    img = cv2.imread(f)
    emotion = detector.detect_emotions(img)
    print(emotion)
    if emotion:
        print("I am HEREEEEE")
        emotion_list = emotion[0]
        angry.append(emotion_list['emotions']['angry'])
        disgust.append(emotion_list['emotions']['disgust'])
        fear.append(emotion_list['emotions']['fear'])
        happy.append(emotion_list['emotions']['happy'])
        sad.append(emotion_list['emotions']['sad'])
        surprise.append(emotion_list['emotions']['surprise'])
        neutral.append(emotion_list['emotions']['neutral'])
        print(filename)
        #print("asta e", emotion_list['emotions']['angry'])   
        with open(r'C:\Users\VRYA0001\Downloads\preprocess\fer_out\fer_out_4.txt', 'a') as f:
            f.write("%s,%s,%s,%s,%s,%s,%s\n" % (emotion_list['emotions']['angry'], emotion_list['emotions']['disgust'],emotion_list['emotions']['fear'],emotion_list['emotions']['happy'],emotion_list['emotions']['sad'],emotion_list['emotions']['surprise'],emotion_list['emotions']['neutral']))
    
    else:
        print("I am in elsee")
        angry.append(0.00)
        disgust.append(0.00)
        fear.append(0.00)
        happy.append(0.00)
        sad.append(0.00)
        surprise.append(0.00)
        neutral.append(0.00)
        print(filename)
        #print("asta e", emotion_list['emotions']['angry'])   
        with open(r'C:\Users\VRYA0001\Downloads\preprocess\fer_out\fer_out_4.txt', 'a') as f:
            f.write("%s,%s,%s,%s,%s,%s,%s\n" % (0,0,0,0,0,0,0))
    
    