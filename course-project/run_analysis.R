##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Brian Dunnette
## 2015-03-21

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# 1. Merge the training and the test sets to create one data set
# 2. Extract only the measurements on the mean and standard deviation for each measurement 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names 
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

##########################################################################################################

# Clean up workspace
rm(list=ls())

# set working directory to be the directory the script is located in
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

library(dplyr)

# create data dir if it doesn't already exist
if (!file.exists("data")) {
  dir.create("data")
}

# download zipped data files (using cURL, since it's HTTPS)
if (!file.exists("data/UCI_HAR_Dataset.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="data/UCI_HAR_Dataset.zip", method="auto")
}

# unzip data files to 'data' directory 
unzip("data/UCI_HAR_Dataset.zip", exdir="data")

# STEP 1: Merge the training and the test sets to create one data set

# get data column names from features.txt
features <- read.table("data/UCI HAR Dataset/features.txt")

# get activity info from activity_labels.txt
activities <- read.table("data/UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id", "activity_name"))

# read data from both train and test datasets, setting column names from column 2 of features.txt
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", col.names=features[,2])

# read activity IDs for both datasets
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"))
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt", col.names=c("activity_id"))

# read subject IDs for both datasets
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", col.names=c("subject_id"))
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", col.names=c("subject_id"))

# merge subject, activity, and accelerometer data for each dataset
data_train <- cbind(subject_train, y_train, x_train)
data_test <- cbind(subject_test, y_test, x_test)

# merge both datasets
data_merged <- rbind(data_train, data_test)

# use dplyr's tbl_df to make data frames more manageable
data_tbl <- tbl_df(data_merged)

# select only identifying columns, means, and standard deviations
data_selected <- select(data_tbl, subject_id, activity_id, contains('mean'), contains('std'))

# label the data set with descriptive activity names. 
colNames  = colnames(data_selected); 
colNames <- gsub("(^t)", "Time", colNames)
colNames <- gsub("(^f)", "Frequency", colNames)
colNames <- gsub("mag", "Magnitude", colNames, ignore.case=TRUE)
colNames <- gsub("acc", "Acceleration", colNames, ignore.case=TRUE)
colNames <- gsub(".std", ".StdDev", colNames)
colNames <- gsub(".mean", ".Mean", colNames)

# assign the new descriptive column names to the dataset
colnames(data_selected) = colNames;

# get means of non-identifying columns
data_summary <- summarise_each(group_by(data_selected, subject_id, activity_id), funs(mean))

# add activity labels
data_labeled <- merge(activities, data_summary, by="activity_id")

# sort by subject & activity
data_labeled <- arrange(data_labeled, subject_id, activity_id)

# export data with write.table() using row.names=FALSE for submission
write.table(data_labeled, file="tidy_data.txt", row.names=FALSE, sep="\t")