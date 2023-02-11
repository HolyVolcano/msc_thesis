# -*- coding: utf-8 -*-
"""
Created on Mon Jan 23 13:24:31 2023

@author: MJAR0016
"""

with open(r"C:\Users\MJAR0016\Desktop\python\hand_left_x.txt", "r") as f:
    new_lines = []
    for idx, line in enumerate(f):
        if idx in [x for x in range(2215,4429)]: #[2,3,4]
            new_lines.append(line)

with open(r"C:\Users\MJAR0016\Desktop\python\hand_left_x_good.txt", "w") as f:
    for line in new_lines:
        f.write(line)
        
           
with open(r"C:\Users\MJAR0016\Desktop\python\hand_left_y.txt", "r") as f:
    new_lines = []
    for idx, line in enumerate(f):
        if idx in [x for x in range(2215,4429)]: #[2,3,4]
            new_lines.append(line)

with open(r"C:\Users\MJAR0016\Desktop\python\\hand_left_y_good.txt", "w") as f:
    for line in new_lines:
        f.write(line)
        


with open(r"C:\Users\MJAR0016\Desktop\python\hand_right_x.txt", "r") as f:
    new_lines = []
    for idx, line in enumerate(f):
        if idx in [x for x in range(2215,4429)]: #[2,3,4]
            new_lines.append(line)

with open(r"C:\Users\MJAR0016\Desktop\python\hand_right_x_good.txt", "w") as f:
    for line in new_lines:
        f.write(line)
        
        
        
with open(r"C:\Users\MJAR0016\Desktop\python\hand_right_y.txt", "r") as f:
    new_lines = []
    for idx, line in enumerate(f):
        if idx in [x for x in range(2215,4429)]: #[2,3,4]
            new_lines.append(line)

with open(r"C:\Users\MJAR0016\Desktop\python\hand_right_y_good.txt", "w") as f:
    for line in new_lines:
        f.write(line)
        

with open(r"C:\Users\MJAR0016\Desktop\python\head_x.txt", "r") as f:
    new_lines = []
    for idx, line in enumerate(f):
        if idx in [x for x in range(2215,4429)]: #[2,3,4]
            new_lines.append(line)

with open(r"C:\Users\MJAR0016\Desktop\python\head_x_good.txt", "w") as f:
    for line in new_lines:
        f.write(line)
        

with open(r"C:\Users\MJAR0016\Desktop\python\head_y.txt", "r") as f:
    new_lines = []
    for idx, line in enumerate(f):
        if idx in [x for x in range(2215,4429)]: #[2,3,4]
            new_lines.append(line)

with open(r"C:\Users\MJAR0016\Desktop\python\\head_y_good.txt", "w") as f:
    for line in new_lines:
        f.write(line)
        
        
        
        
        