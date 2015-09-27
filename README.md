## Getting and Cleaning Data - Course Project

This Coursera programming assignment requires students to demonstrate their ability to 
collect, work with, and clean a data set within R. Using a combination of file download and 
data manipulation techniques we have been asked to create an R script (run_analysis.R) 
that does the following:

1.  Merge the training and the test sets to create one data set
2.  Extract only the measurements on the mean and standard deviation for each measurement 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately label the data set with descriptive variable names
5.  From the data set in step 4, create a second, independent tidy data set with the average of 
    each variable for each activity and each subject


## Within this Repository
README.md: Contains information about the other files in this repository

CodeBook.md: Describes the variables, data and any transformations or work performed to clean up the data 

run_analysis.R: The R script which performs the transformation steps, producing the tidy data output

tidyData.txt: The resulting tidy data set


## Data Set
For this assignment we are using the 'Human Activity Recognition Using Smartphones' data set and
the zip file containing the test and training data and full details of the features and activities
is available at the link below:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Executing run_analysis.R
Please see run_analysis.R for a more detailed description of each step. Below provides the steps at a high level:

To run this script, the libraries dplyr and reshape2 must be loaded

### Step 1:
* Check for the data set and if not present, download and extract to the working directory
* Import the test and training data sets to R 
* Import the feature vector label data from features.txt to name the variable columns
* Using a combination of cbind and rbind, merge the datasets into a single data frame

### Step 2:
* Use grep to identify the variables that hold the mean and standard deviation for each measurement 
* Combine these variables with the subject and activity columns

### Step 3:
* Import the activity labels from activity_labels.txt
* Use the numeric id to merge with the activity id in subsetData
* Rename the V2 column to Activity

### Step 4:
* gsub is used to label the data set with more appropriate and descriptive variable names

### Step 5:
* Melt the data using the Subject and Activity columns as ids and all variables within subsetData as the measures
* Use dcast to reshape the data frame in order to provide the mean of each measure by the subject and activity
* Export the tidy data set to tidyData.txt


