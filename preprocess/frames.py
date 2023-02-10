import cv2
import numpy as np
import os


def child():

    os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\frames\child")
    
    video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\crop\child"
    
    video_list = os.listdir(video_dir)
    
    for idx, video in enumerate(video_list):
    
        # Playing video from file:
        cap = cv2.VideoCapture(os.path.join(video_dir,video))
    
        
        currentFrame = 0
        while(True):
            # Capture frame-by-frame
            ret, frame = cap.read()
        
            # Saves image of the current frame in jpg file
            name = 'frame_' + str(currentFrame) + '.jpg'
            print ('Creating...' + name)
            cv2.imwrite(name, frame)
        
            # To stop duplicate images
            currentFrame += 1
        
        # When everything done, release the capture
        cap.release()
        cv2.destroyAllWindows()
    


def adult():

    os.chdir(r"C:\Users\VRYA0001\Downloads\preprocess\frames\adult")
    
    video_dir = r"C:\Users\VRYA0001\Downloads\preprocess\crop\adult"
    
    video_list = os.listdir(video_dir)
    
    for idx, video in enumerate(video_list):
    
        # Playing video from file:
        cap = cv2.VideoCapture(os.path.join(video_dir,video))
    
        
        currentFrame = 0
        while(True):
            # Capture frame-by-frame
            ret, frame = cap.read()
        
            # Saves image of the current frame in jpg file
            name = 'frame_' + str(currentFrame) + '.jpg'
            print ('Creating...' + name)
            cv2.imwrite(name, frame)
        
            # To stop duplicate images
            currentFrame += 1
        
        # When everything done, release the capture
        cap.release()
        cv2.destroyAllWindows()
    
    
if __name__ == "__main__":
    child()
    # adult()
    