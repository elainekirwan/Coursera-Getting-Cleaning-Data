## Getting and Cleaning Data - Course Project

## Check for the data files, download and extract if they do not already exist
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("download.zip")) {
  
   download.file(fileURL, destfile = "./download.zip")
   unzip("download.zip")

}
file.remove("download.zip")
setwd('UCI HAR Dataset/')
library(dplyr)
library(reshape2)


## Step 1: Merge the training and test data to create a single data set
test_data <- read.table("test/X_test.txt")
test_label <- read.table("test/y_test.txt", col.names = "Activity")
test_subject <- read.table("test/subject_test.txt", col.names = "Subject")

train_data <- read.table("train/X_train.txt")
train_label <- read.table("train/y_train.txt", col.names = "Activity")
train_subject <- read.table("train/subject_train.txt", col.names = "Subject")

# Add the column names of the feature variables
features <- read.table("features.txt")
names(train_data) <- features$V2
names(test_data) <- features$V2

# Merge the subject, activity and data files
test <- cbind(test_subject, test_label, test_data)
train <- cbind(train_subject, train_label, train_data)
mergedData <- rbind(train, test)


## Step 2: Extract only the mean and standard deviation for each measurement 

# Identify only the variables that contain a reference to std() and mean()
variables <- grep("(mean|std)\\(\\)", names(mergedData))

# Combine these variables with the subject and activity columns
subsetData <- mergedData[, c(1, 2, variables)]    


## Step 3: Use descriptive activity names
activities <- read.table("activity_labels.txt")

# Join the working data set with the activities labels using the activity id 
subsetData <- select((merge(activities, subsetData, by.x = "V1", by.y = "Activity")), -(V1)) 
subsetData <- rename(subsetData, Activity = V2)

## Step 4: Appropriately label the data set with descriptive variable name
names(subsetData) <- gsub("^f", "Frequency", names(subsetData))
names(subsetData) <- gsub("^t", "Time", names(subsetData))
names(subsetData) <- gsub("-mean[(][)]", "Mean", names(subsetData))
names(subsetData) <- gsub("-std[(][)]", "Std", names(subsetData))
names(subsetData) <- gsub("BodyBody", "Body", names(subsetData))

## Step 5: Create an independent tidy data set with the average of each variable 
##         for each activity and each subject

# Specify the ID Variables (we need to display a column for each)
idvariables <- melt(subsetData, id.vars = c("Subject", "Activity"))

# Use dcast to reshape the data 
tidyData <- dcast(idvariables, Subject + Activity ~ variable, mean)

# Export the tidy data set 
write.table(tidyData, "tidyData.txt", row.names = FALSE)
