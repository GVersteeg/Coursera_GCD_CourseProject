---
title: "CodeBook"
file: "tidySet.txt"
author: "Gerrit Versteeg"
date: "23 August 2016"
output: html_document
---
please be also refered to the orginal dataset dictionary features.info.txt
available at: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Data Dictionary - tidySet.txt 

Variable                Type    Values
                        Description
---------------         ------- ----------------------------------------- 

Activity                Factor  "LAYING", "SITTING", "STANDING", "WALKING",
                                "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"
                        One of the six activities performed by subject
                        during measurement
                         

Subject                 Int     Range from 1 to 30
                        Reference to the subject that performed the activity

                
86 Measurement          Num     Range from -1 to 1
   variables            All contain the AVERAGE of the means and standard deviations
                        of the original measurements that were done at a 50Hz
                        frequency during the specified Activity of the Subject.
                        (see README.md and read.me of original zip referenced above)
                        
                        All 86 measurement variables have names that contain
                        multiple components. The combined components explain the
                        essence of the measurement. To understand the measurement
                        just combine the meaning of the components listed below.

Component               Meaning
---------------         ---------------------------------------
t                       refers to time (i.e. the time domain of the signals 
                        of movement recorded at 50Hz)
f                       refers to frequency (i.e. the frequency domain of the
                        signals of movement at 50Hz, derived from the movements
                        in time using a Fast Fourier Tranformation
Body                    refers to the body motion component of the sensor
Gravity                 refers to the gravitational motion component of the sensor
Acc                     refers to the smartphone embedded accelerometer,
                        recording the 3-axial linear acceleration (tAcc-XYZ).
Gyro                    refers to the smartphone embedded gyroscope,
                        recording 3-axial linear velocity (tGyro-XYZ) 
Jerk                    Jerk signals derived from the body linear acceleration
                        and angular velocity analyzed over time to determine jerk.
Mag                     Magnitude of the three-dimensional signals:
                        tBodyAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk,
                        tGravityAcc
angle                   Angle between two directional vectors
mean                    the average of the 50Hz movement recordings
meanFreq                the weighted average of the frequency components
                        to obtain a mean frequency
std                     the standard deviation of the 50Hz movement recordings
X                       movement along the X-axis
Y                       movement along the Y-axis
Z                       movement along the Z-axis

Example:
                        
tBodyAcc.std.Y         the average over the standaard deviations of 
                       all movements of the body in the Y-direction
                       measured by the accelerometer over time. 

List of the 86 averages contained in the measurement variables:

"tBodyAcc.mean.X"
"tBodyAcc.mean.Y"
"tBodyAcc.mean.Z"
"tBodyAcc.std.X"
"tBodyAcc.std.Y"
"tBodyAcc.std.Z"
"tGravityAcc.mean.X"
"tGravityAcc.mean.Y"
"tGravityAcc.mean.Z"
"tGravityAcc.std.X"
"tGravityAcc.std.Y"
"tGravityAcc.std.Z"
"tBodyAccJerk.mean.X"
"tBodyAccJerk.mean.Y"
"tBodyAccJerk.mean.Z"
"tBodyAccJerk.std.X"
"tBodyAccJerk.std.Y"
"tBodyAccJerk.std.Z"
"tBodyGyro.mean.X"
"tBodyGyro.mean.Y"
"tBodyGyro.mean.Z"
"tBodyGyro.std.X"
"tBodyGyro.std.Y"
"tBodyGyro.std.Z"
"tBodyGyroJerk.mean.X"
"tBodyGyroJerk.mean.Y"
"tBodyGyroJerk.mean.Z"
"tBodyGyroJerk.std.X"
"tBodyGyroJerk.std.Y"
"tBodyGyroJerk.std.Z"
"tBodyAccMag.mean"
"tBodyAccMag.std"
"tGravityAccMag.mean"
"tGravityAccMag.std"
"tBodyAccJerkMag.mean"
"tBodyAccJerkMag.std"
"tBodyGyroMag.mean"
"tBodyGyroMag.std"
"tBodyGyroJerkMag.mean"
"tBodyGyroJerkMag.std"
"fBodyAcc.mean.X"
"fBodyAcc.mean.Y"
"fBodyAcc.mean.Z"
"fBodyAcc.std.X"
"fBodyAcc.std.Y"
"fBodyAcc.std.Z"
"fBodyAcc.meanFreq.X"
"fBodyAcc.meanFreq.Y"
"fBodyAcc.meanFreq.Z"
"fBodyAccJerk.mean.X"
"fBodyAccJerk.mean.Y"
"fBodyAccJerk.mean.Z"
"fBodyAccJerk.std.X"
"fBodyAccJerk.std.Y"
"fBodyAccJerk.std.Z"
"fBodyAccJerk.meanFreq.X"
"fBodyAccJerk.meanFreq.Y"
"fBodyAccJerk.meanFreq.Z"
"fBodyGyro.mean.X"
"fBodyGyro.mean.Y"
"fBodyGyro.mean.Z"
"fBodyGyro.std.X"
"fBodyGyro.std.Y"
"fBodyGyro.std.Z"
"fBodyGyro.meanFreq.X"
"fBodyGyro.meanFreq.Y"
"fBodyGyro.meanFreq.Z"
"fBodyAccMag.mean"
"fBodyAccMag.std"
"fBodyAccMag.meanFreq"
"fBodyBodyAccJerkMag.mean"
"fBodyBodyAccJerkMag.std"
"fBodyBodyAccJerkMag.meanFreq"
"fBodyBodyGyroMag.mean"
"fBodyBodyGyroMag.std"
"fBodyBodyGyroMag.meanFreq"
"fBodyBodyGyroJerkMag.mean"
"fBodyBodyGyroJerkMag.std"
"fBodyBodyGyroJerkMag.meanFreq"
"angle.tBodyAccMean.gravity"
"angle.tBodyAccJerkMeangravityMean"
"angle.tBodyGyroMean.gravityMean"
"angle.tBodyGyroJerkMean.gravityMean"
"angle.X.gravityMean"
"angle.Y.gravityMean"
"angle.Z.gravityMean"

