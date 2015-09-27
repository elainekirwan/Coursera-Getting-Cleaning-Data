## Getting and Cleaning Data - CodeBook 

## Overview
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used in this analysis represents information collected during experiments which were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## Variables

The initial data set contains 561 measurements, however for our analysis we are interested only in the mean and standard deviation measurements (66 variables).

There are also two key identifiers:

* `Subject` - The ID of the test subject
* `Activity` - The activity performed when the corresponding measurements were taken:
  - Walking
  - Walking Upstairs
  - Walking Downstairs
  - Sitting
  - Standing
  - Laying


## Executing run_analysis.R
Please see `run_analysis.R` for a more detailed description of each step. The below provides an overview of the steps at a high level:

To run this script, the libraries dplyr and reshape2 must be loaded

##### Step 1:
* Check for the data set and if not present, download and extract to the working directory
* Import the test and training data sets to R 
* Import the feature vector label data from features.txt to name the variable columns
* Using a combination of cbind and rbind, merge the datasets into a single data frame

##### Step 2:
* Use grep to identify the variables that hold the mean and standard deviation for each measurement 
* Combine these variables with the subject and activity columns

##### Step 3:
* Import the activity labels from activity_labels.txt
* Use the numeric id to merge with the activity id in subsetData
* Rename the V2 column to Activity

##### Step 4:
* gsub is used to label the data set with more appropriate and descriptive variable names

##### Step 5:
* Melt the data using the Subject and Activity columns as ids and all variables within subsetData as the measures
* Use dcast to reshape the data frame in order to provide the mean of each measure by the subject and activity
* Export the tidy data set to tidyData.txt