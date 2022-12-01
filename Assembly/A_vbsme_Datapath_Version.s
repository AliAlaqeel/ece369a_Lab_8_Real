#  Fall 2022
#  Team Members:    
#  % Effort    :   
#
# ECE369A,  
# 

########################################################################################################################
### data
########################################################################################################################
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column


# test 1 For the 16X16 frame size and a 8X4 window size
# The result should be 3, 2
asize1:  .word    16, 16, 8, 4    #i, j, k, l
frame1:  .word    7, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
         .word    7, 8, 8, 8, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
         .word    7, 8, 8, 8, 2, 8, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 
         .word    7, 8, 8, 8, 8, 8, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 
         .word    0, 4, 8, 8, 8, 8, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 8, 8, 8, 8, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 8, 8, 8, 8, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window1: .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8 


# test 2 For the 32X32 frame and a 8X16 window size
# The result should be 16, 0
asize2:  .word    32, 32, 8, 16    #i, j, k, l
frame2:  .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8, 
         .word    1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8
         
window2: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         

# test 3 For the 16X16 frame and a 4X8 window size
# The result should be 12, 0
asize3:  .word    16, 16, 4, 8    #i, j, k, l
frame3:  .word    9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7, 7, 7, 
         .word    9, 7, 7, 7, 7, 5, 6, 7, 8, 9, 10, 11, 6, 7, 7, 7, 
         .word    9, 7, 7, 7, 7, 3, 12, 14, 16, 18, 20, 6, 6, 7, 7, 7, 
         .word    9, 7, 7, 7, 7, 4, 18, 21, 24, 27, 30, 33, 6, 7, 7, 7, 
         .word    0, 7, 7, 7, 7, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3
         
window3: .word    9, 9, 9, 9, 9, 9, 9, 9, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 
         .word    9, 9, 9, 9, 9, 9, 9, 9, 
         .word    9, 9, 9, 9, 9, 9, 9, 9


                  
# test 4 For the 16X16 frame and a 8X8 window size
# The result should be 8, 3
asize4: .word    16, 16, 8, 8    #i, j, k, l
frame4: .word    9, 19, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 91, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 19, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 91, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    91, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 19, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 91, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    1, 2, 3, 9, 9, 19, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0, 
         .word    1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 96, 108, 120, 132, 0
                  
window4:   .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9, 
            .word    9, 9, 9, 9, 9, 9, 9, 9
   

# test 5 For the 32X32 frame and a 4X4 window size
# The result should be 5, 16 since its the first of multiple repeating occurences
asize5: .word    32, 32, 4, 4    #i, j, k, l
frame5: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
                  
window5:   .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10




         
newline: .asciiz     "\n" 


########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address
         
    # Start test 1 
    ############################################################
    la      $a0, asize1     # 1st parameter: address of asize1[0]
    la      $a1, frame1     # 2nd parameter: address of frame1[0]
    la      $a2, window1    # 3rd parameter: address of window1[0] 
   
    jal     vbsme           # call function
 #   jal     print_result    # print results to console
    
    ############################################################
    # End of test 1   

   
    # Start test 2 
    ############################################################
    la      $a0, asize2     # 1st parameter: address of asize2[0]
    la      $a1, frame2     # 2nd parameter: address of frame2[0]
    la      $a2, window2    # 3rd parameter: address of window2[0] 
   
    jal     vbsme           # call function
 #   jal     print_result    # print results to console
    ############################################################
    # End of test 2   
                    
               
    # Start test 3
    ############################################################
    la      $a0, asize3     # 1st parameter: address of asize3[0]
    la      $a1, frame3     # 2nd parameter: address of frame3[0]
    la      $a2, window3    # 3rd parameter: address of window3[0] 

    jal     vbsme           # call function
 #   jal     print_result    # print results to console 
    ############################################################
    # End of test 3   
      
      
    # Start test 4 
    ############################################################
    la      $a0, asize4     # 1st parameter: address of asize4[0]
    la      $a1, frame4     # 2nd parameter: address of frame4[0]
    la      $a2, window4    # 3rd parameter: address of window4[0] 

    jal     vbsme           # call function
 #   jal     print_result    # print results to console
    ############################################################
    # End of test 4   
   
   
    # Start test 5
    ############################################################
    la      $a0, asize5     # 1st parameter: address of asize5[0]
    la      $a1, frame5     # 2nd parameter: address of frame5[0]
    la      $a2, window5    # 3rd parameter: address of window5[0] 

    jal     vbsme           # call function
 #  jal     print_result    # print results to console
    ############################################################
    # End of test 5

    lw      $ra, 0($sp)         # Restore return address
    addi    $sp, $sp, 4         # Restore stack pointer
    j       end_program                 # Return

end_program:                    # remain in infinite loop
	j end_program
################### Print Result ####################################
#print_result:
    # Printing $v0
 #   add     $a0, $v0, $zero     # Load $v0 for printing
 #   li      $v0, 1              # Load the system call numbers
 #   syscall
   
    # Print newline.
 #   la      $a0, newline          # Load value for printing
 #   li      $v0, 4                # Load the system call numbers
 #   syscall
   
    # Printing $v1
 #   add     $a0, $v1, $zero      # Load $v1 for printing
 #   li      $v0, 1                # Load the system call numbers
 #   syscall

    # Print newline.
 #   la      $a0, newline          # Load value for printing
 #   li      $v0, 4                # Load the system call numbers
 #   syscall
   
    # Print newline.
 #   la      $a0, newline          # Load value for printing
 #   li      $v0, 4                # Load the system call numbers
 #   syscall
   
 #   jr      $ra                   #function return

#####################################################################
### vbsme
#####################################################################


# vbsme.s 
# motion estimation is a routine in h.264 video codec that 
# takes about 80% of the execution time of the whole code
# given a frame(2d array, x and y dimensions can be any integer 
# between 16 and 64) where "frame data" is stored under "frame"  
# and a window (2d array of size 4x4, 4x8, 8x4, 8x8, 8x16, 16x8 or 16x16) 
# where "window data" is stored under "window" 
# and size of "window" and "frame" arrays are stored under "asize"

# - initially current sum of difference is set to a very large value
# - move "window" over the "frame" one cell at a time starting with location (0,0)
# - moves are based circular pattern 
# - for each move, function calculates  the sum of absolute difference (SAD) 
#   between the window and the overlapping block on the frame.
# - if the calculated sum of difference is LESS THAN the current sum of difference
#   then the current sum of difference is updated and the coordinate of the top left corner 
#   for that matching block in the frame is recorded. 

# for example SAD of two 4x4 arrays "window" and "block" shown below is 3  
# window         block
# -------       --------
# 1 2 2 3       1 4 2 3  
# 0 0 3 2       0 0 3 2
# 0 0 0 0       0 0 0 0 
# 1 0 0 5       1 0 0 4

# program keeps track of the window position that results 
# with the minimum sum of absolute difference. 
# after scannig the whole frame
# program returns the coordinates of the block with the minimum SAD
# in $v0 (row) and $v1 (col) 


# Sample Inputs and Output shown below:
# Frame:
#
#  0   1   2   3   0   0   0   0   0   0   0   0   0   0   0   0 
#  1   2   3   4   4   5   6   7   8   9  10  11  12  13  14  15 
#  2   3  32   1   2   3  12  14  16  18  20  22  24  26  28  30 
#  3   4   1   2   3   4  18  21  24  27  30  33  36  39  42  45 
#  0   4   2   3   4   5  24  28  32  36  40  44  48  52  56  60 
#  0   5   3   4   5   6  30  35  40  45  50  55  60  65  70  75 
#  0   6  12  18  24  30  36  42  48  54  60  66  72  78  84  90 
#  0   7  14  21  28  35  42  49  56  63  70  77  84  91  98 105 
#  0   8  16  24  32  40  48  56  64  72  80  88  96 104 112 120 
#  0   9  18  27  36  45  54  63  72  81  90  99 108 117 126 135 
#  0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 
#  0  11  22  33  44  55  66  77  88  99 110 121 132 143 154 165 
#  0  12  24  36  48  60  72  84  96 108 120 132   0   1   2   3 
#  0  13  26  39  52  65  78  91 104 117 130 143   1   2   3   4 
#  0  14  28  42  56  70  84  98 112 126 140 154   2   3   4   5 
#  0  15  30  45  60  75  90 105 120 135 150 165   3   4   5   6 

# Window:
#  0   1   2   3 
#  1   2   3   4 
#  2   3   4   5 
#  3   4   5   6 

# cord x = 12, cord y = 12 returned in $v0 and $v1 registers

.text
.globl  vbsme

# Your program must follow circular search pattern.  

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:	
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD


# Begin subroutine
vbsme:  
   li      $v0, 0              # reset $v0 and $V1
   li      $v1, 0

   # insert your code here
   
    addi    $sp, $sp, -4    #Increase stack by one
    sw      $ra, 0($sp)     #Store return address to stack

    ### REGISTER USES
    # $s0: stepsLeft, $s1: dirTracker, $s2: frameHeight, $s3: frameWidth, $s4: windowHeight, $s5: windowWidth, $s6: widthSlides, $s7: heightSlides
    # $t0: general use temp (can overwrite), $t9: general use temp (DO NOT OVERWRITE)
    #Free registers (for now): 
    ###

    # Let $s2 = frameHeight
    lw      $s2, 0($a0)

    # Let $s3 = frameWidth  (We'll use frame width later inside the loops)
    lw      $s3, 4($a0)

    # Let $s4 = windowHeight
    lw      $s4, 8($a0)

    # Let $s5 = windowWidth
    lw      $s5, 12($a0)

    # Let $s6 = widthSlides, widthSlides = frameWidth - windowWidth
    sub     $s6, $s3, $s5

    # Let $s7 = heightSlides, heightSlides = frameHeight - windowHeight
    sub     $s7, $s2, $s4

    # Let $s0 = stepsLeft, stepsLeft = (widthSlides + 1) * (heightSlides + 1) - 1 [SIMPLIFIES TO] stepsLeft = (widthSlides * heightSlides) + heightSlides + widthSlides
    addi    $s0, $zero, 0
    mul     $s0, $s6, $s7
    add     $s0, $s0, $s6
    add     $s0, $s0, $s7

    # Let $s1 = dirTracker
    addi    $s1, $zero, 0

    addi    $t7, $zero, 0       #t7 = totalsum on window vs frame

    addi    $s2, $zero, 0   #Current X
    addi    $t8, $zero, 0   #Current Y

    #addi    
    jal     calcSAD

    #Initial Going-Right Loop
    addi    $t9, $zero, 0  #Let t9 == i, loop continues for (i < widthSlides)
    beq     $s6, $zero, skipRight

firstRight:

        addi    $s2, $s2, 1     #Move to right by 1 (currX++)
        addi    $s0, $s0, -1    #subtract stepsLeft by 1
        jal     calcSAD
        addi    $t9, $t9, 1

    slt     $t0, $t9, $s6
    bne     $t0, $zero, firstRight


skipRight:
    #beq     $s0, $zero, skipVBSME
    #blt     $s0, $zero, skipVBSME
    blez    $s0, skipVBSME
vbsmeLoop:  # Mega Loop

    #If dirTracker == 0, 1, 2, or 3, go to their respective tracker
    beq     $s1, $zero, goingDown
    addi    $t0, $zero, 1
    beq     $s1, $t0, goingLeft
    addi    $t0, $zero, 2
    beq     $s1, $t0, goingUp
    addi    $t0, $zero, 3
    beq     $s1, $t0, goingRight

    goingDown: 
        #Going down Loop
        addi    $t9, $zero, 0   # Loop iterator i
        beq     $s7, $zero, breakSwitchCases    #Emergency skip     #Mistake: used s6 instead of s7

        downLoop:
        addi    $t8, $t8, 1     # Y increases by 1
        addi    $s0, $s0, -1    # decrement stepsLeft by 1
        jal     calcSAD

        addi    $t9, $t9, 1
        slt     $t0, $t9, $s7
        bne     $t0, $zero, downLoop    #if(i < heightSlides) loop

        addi    $s7, $s7, -1    # decrement heightSlides by 1
        j breakSwitchCases

    goingLeft:
        #Going left Loop
        addi    $t9, $zero, 0
        beq     $s6, $zero, breakSwitchCases 

        leftLoop:
        addi    $s2, $s2, -1
        addi    $s0, $s0, -1    # decrement stepsLeft by 1
        jal     calcSAD
        addi    $t9, $t9, 1
        slt     $t0, $t9, $s6
        bne     $t0, $zero, leftLoop    #if(i < widthSlides) loop

        addi    $s6, $s6, -1    # decrement widthSlides by 1
        j breakSwitchCases

    goingUp:
        #Going up Loop
        addi    $t9, $zero, 0
        beq     $s7, $zero, breakSwitchCases

        upLoop:
        addi    $s0, $s0, -1    # decrement stepsLeft by 1
        addi    $t8, $t8, -1
        jal     calcSAD
        addi    $t9, $t9, 1
        slt     $t0, $t9, $s7
        bne     $t0, $zero, upLoop    #if(i < heightSlides) loop

        addi    $s7, $s7, -1    # decrement heightSlides by 1
        j breakSwitchCases

    goingRight:
        #Going right Loop
        addi    $t9, $zero, 0
        beq     $s6, $zero, breakSwitchCases 

        rightLoop:
        addi    $s2, $s2, 1
        addi    $s0, $s0, -1    #subtract stepsLeft by 1
        jal     calcSAD
        addi    $t9, $t9, 1
        slt     $t0, $t9, $s6
        bne     $t0, $zero, rightLoop

        addi    $s6, $s6, -1    # decrement widthSlides by 1


    breakSwitchCases:

    #if dirTracker == 3, reset it to zero, increment otherwise
        addi    $t0, $zero, 3
        beq     $s1, $t0, resetTracker

        addi    $s1, $s1, 1
        j dontResetTracker

        resetTracker:
        add     $s1, $zero, $zero

        dontResetTracker:

    #bgt         $s0, $zero, vbsmeLoop   #while(stepsLeft > 0)
    bgtz    $s0, vbsmeLoop

skipVBSME:

    lw      $ra, 0($sp)     #get ye ole return address
    addi    $sp, $sp, 4    #decrease stack by 1
    jr      $ra 


#SAD CALCULATIONS BELOW
# t5: i, t6: j, t3: frame value, t4: window value, 

calcSAD:

    addi    $t7, $zero, 0   # reset currentSum
    addi    $t5, $zero, 0   # reset i
    iLoop:

        addi    $t6, $zero, 0   # reset j
        jLoop:

            # Getting the window pt. 
            mul     $t2, $t6, $s5       #finding the window location ()
            add     $t2, $t2, $t5       #adding the row to the column data for a 1 Dimentional array
            # sll     $t2, $t2, 2         #multiplying by 4 because of int value
            addi    $t0, $zero, 4   # sll doesn't work for now, use mul
            mul     $t2, $t2, $t0
            add     $t2, $t2, $a2       #adding te address to the array
            lw      $t4, 0($t2)         #loads Window Value

            # Getting the frame pt.
            add     $t0, $t8, $t6       #adding the currY to the j value
            mul     $t2, $t0, $s3       # multiplying by the frame width
            add     $t0, $s2, $t5       #adding Current x to the i value
            add     $t2, $t2, $t0       #adding Current X to the Y value
            # sll     $t2, $t2, 2         #multiplies by 4 for int value
            addi    $t0, $zero, 4   # sll doesn't work for now, use mul
            mul     $t2, $t2, $t0
            add     $t2, $t2, $a1       #adds frame value
            lw      $t3, 0($t2)         #loads Frame Value

            # Compare the points
            #blt     $t3, $t4, winBigger
            slt   $t0, $t3, $t4
            bne   $t0, $zero, winBigger   #COULD BE PROBLEM
            sub     $t0, $t3, $t4
            add     $t7, $t7, $t0
            j       winSmaller
            winBigger:
            sub     $t0, $t4, $t3
            add     $t7, $t7, $t0
            winSmaller:

        addi    $t6, $t6, 1
        #blt     $t6, $s4, jLoop
        slt    $t0, $t6, $s4
        bne    $t0, $zero, jLoop


    addi    $t5, $t5, 1
    #blt     $t5, $s5, iLoop
    slt     $t0, $t5, $s5
    bne     $t0, $zero, iLoop


    beq     $s2, $t8, xSamey
    j   notFirstPoint
    xSamey: 
        beq     $s2, $zero, firstEverPoint
        j   notFirstPoint
            firstEverPoint:
            addi    $v0, $zero, 0
            addi    $v1, $zero, 0
            addi    $t1, $t7, 0
            jr $ra
    notFirstPoint:
    #bgt     $t1, $t7, newLowerSum
    slt  $t0, $t7, $t1
    bne  $t0, $zero, newLowerSum
    
    beq     $t7, $t1, SameSum
    addi    $t7, $zero, 0
    jr $ra
    newLowerSum:
    add    $v0, $zero, $t8
    add    $v1, $zero, $s2
    add     $t1, $zero, $t7
    addi    $t7, $zero, 0
    jr $ra
SameSum:
	addi $t7,$zero,0
	jr $ra