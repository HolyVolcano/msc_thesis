# -*- coding: utf-8 -*-
"""
Created on Wed Jan 11 13:05:52 2023

@author: VRYA0001
"""

import mediapipe as mp
import os
import time

from videosource import FileSource
from mediapipe.framework.formats import landmark_pb2

mp_drawing = mp.solutions.drawing_utils
mp_holistic = mp.solutions.holistic
drawing_spec = mp_drawing.DrawingSpec(thickness=1, circle_radius=3)





def main1():
    
    head_landmarks_x = []
    head_landmarks_y = []
    left_hand_landmarks_x = []
    left_hand_landmarks_y = []
    right_hand_landmarks_x = []
    right_hand_landmarks_y = []
    
    os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\child")

    video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\crop_mediapipe\child"

    video_list = os.listdir(video_dir)
    
    for idx, video in enumerate(video_list):
        source = FileSource(os.path.join(video_dir,video))
    
        with mp_holistic.Holistic(
            min_detection_confidence=0.5, min_tracking_confidence=0.5
        ) as holistic:
    
            for idx, (frame, frame_rgb) in enumerate(source):
                print(idx)
    
                results = holistic.process(frame_rgb)
                if results.pose_landmarks is None:
                    head_landmarks_x.append(0.00)
                    head_landmarks_y.append(0.00)
                    left_hand_landmarks_x.append(0.00)
                    left_hand_landmarks_y.append(0.00)
                    right_hand_landmarks_x.append(0.00)
                    right_hand_landmarks_y.append(0.00)
                else:
                    head_landmark_subset = landmark_pb2.NormalizedLandmarkList(landmark = [results.pose_landmarks.landmark[0]])
                    left_hand_landmark_subset = landmark_pb2.NormalizedLandmarkList(landmark = [results.pose_landmarks.landmark[11]])
                    right_hand_landmark_subset = landmark_pb2.NormalizedLandmarkList(landmark = [results.pose_landmarks.landmark[12]])
                
                    if results:
                        for data_point in head_landmark_subset.landmark:
                            head_landmarks_x.append(data_point.x)
                            head_landmarks_y.append(data_point.y)
                        for data_point in left_hand_landmark_subset.landmark:
                            left_hand_landmarks_x.append(data_point.x)
                            left_hand_landmarks_y.append(data_point.y)
                        for data_point in right_hand_landmark_subset.landmark:
                            right_hand_landmarks_x.append(data_point.x)
                            right_hand_landmarks_y.append(data_point.y)
                    else:
                        face_landmarks.append(0.00)
                        pose_landmarks.append(0.00)
                        left_hand_landmarks.append(0.00)
                        right_hand_landmarks.append(0.00)
    
                mp_drawing.draw_landmarks(
                    frame,
                    results.face_landmarks,
                    mp_holistic.FACEMESH_CONTOURS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
                mp_drawing.draw_landmarks(
                    frame,
                    results.left_hand_landmarks,
                    mp_holistic.HAND_CONNECTIONS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
                mp_drawing.draw_landmarks(
                    frame,
                    results.right_hand_landmarks,
                    mp_holistic.HAND_CONNECTIONS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
                mp_drawing.draw_landmarks(
                    frame,
                    results.pose_landmarks,
                    mp_holistic.POSE_CONNECTIONS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
    
                source.show(frame)
                
        with open("head_x.txt", 'w+') as f:
            for item in head_landmarks_x:
                f.write("%s\n" % item)
    
        with open("head_y.txt", 'w+') as f:
            for item in head_landmarks_y:
                f.write("%s\n" % item)            
                
        with open("hand_left_x.txt", 'w+') as f:
            for item in left_hand_landmarks_x:
                f.write("%s\n" % item)
                
        with open("hand_left_y.txt", 'w+') as f:
            for item in left_hand_landmarks_y:
                f.write("%s\n" % item)    
                
        with open("hand_right_x.txt", 'w+') as f:
            for item in right_hand_landmarks_x:
                f.write("%s\n" % item)
                
        with open("hand_right_y.txt", 'w+') as f:
            for item in right_hand_landmarks_y:
                f.write("%s\n" % item)        


def main2():
    
    head_landmarks_x = []
    head_landmarks_y = []
    left_hand_landmarks_x = []
    left_hand_landmarks_y = []
    right_hand_landmarks_x = []
    right_hand_landmarks_y = []
    
    os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\mediapipe\adult")

    video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\crop_mediapipe\adult"

    video_list = os.listdir(video_dir)
    
    for idx, video in enumerate(video_list):
        source = FileSource(os.path.join(video_dir,video))
    
        with mp_holistic.Holistic(
            min_detection_confidence=0.5, min_tracking_confidence=0.5
        ) as holistic:
    
            for idx, (frame, frame_rgb) in enumerate(source):
                print(idx)
    
                results = holistic.process(frame_rgb)
                if results.pose_landmarks is None:
                    head_landmarks_x.append(0.00)
                    head_landmarks_y.append(0.00)
                    left_hand_landmarks_x.append(0.00)
                    left_hand_landmarks_y.append(0.00)
                    right_hand_landmarks_x.append(0.00)
                    right_hand_landmarks_y.append(0.00)
                else:
                    head_landmark_subset = landmark_pb2.NormalizedLandmarkList(landmark = [results.pose_landmarks.landmark[0]])
                    left_hand_landmark_subset = landmark_pb2.NormalizedLandmarkList(landmark = [results.pose_landmarks.landmark[11]])
                    right_hand_landmark_subset = landmark_pb2.NormalizedLandmarkList(landmark = [results.pose_landmarks.landmark[12]])
                
                    if results:
                        for data_point in head_landmark_subset.landmark:
                            head_landmarks_x.append(data_point.x)
                            head_landmarks_y.append(data_point.y)
                        for data_point in left_hand_landmark_subset.landmark:
                            left_hand_landmarks_x.append(data_point.x)
                            left_hand_landmarks_y.append(data_point.y)
                        for data_point in right_hand_landmark_subset.landmark:
                            right_hand_landmarks_x.append(data_point.x)
                            right_hand_landmarks_y.append(data_point.y)
                    else:
                        face_landmarks.append(0.00)
                        pose_landmarks.append(0.00)
                        left_hand_landmarks.append(0.00)
                        right_hand_landmarks.append(0.00)
    
                mp_drawing.draw_landmarks(
                    frame,
                    results.face_landmarks,
                    mp_holistic.FACEMESH_CONTOURS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
                mp_drawing.draw_landmarks(
                    frame,
                    results.left_hand_landmarks,
                    mp_holistic.HAND_CONNECTIONS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
                mp_drawing.draw_landmarks(
                    frame,
                    results.right_hand_landmarks,
                    mp_holistic.HAND_CONNECTIONS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
                mp_drawing.draw_landmarks(
                    frame,
                    results.pose_landmarks,
                    mp_holistic.POSE_CONNECTIONS,
                    landmark_drawing_spec=drawing_spec,
                    connection_drawing_spec=drawing_spec,
                )
    
                source.show(frame)
                
        with open("head_x.txt", 'w+') as f:
            for item in head_landmarks_x:
                f.write("%s\n" % item)
    
        with open("head_y.txt", 'w+') as f:
            for item in head_landmarks_y:
                f.write("%s\n" % item)            
                
        with open("hand_left_x.txt", 'w+') as f:
            for item in left_hand_landmarks_x:
                f.write("%s\n" % item)
                
        with open("hand_left_y.txt", 'w+') as f:
            for item in left_hand_landmarks_y:
                f.write("%s\n" % item)    
                
        with open("hand_right_x.txt", 'w+') as f:
            for item in right_hand_landmarks_x:
                f.write("%s\n" % item)
                
        with open("hand_right_y.txt", 'w+') as f:
            for item in right_hand_landmarks_y:
                f.write("%s\n" % item)        

if __name__ == "__main__":
    main1()
    main2()