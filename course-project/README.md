# Getting and Cleaning Data: Course Project

The enclosed [run_analysis](./run_analysis.R) script does the following:

1. Downloads and unzips the UCI HAR dataset
2. Merges the training and the test sets
3. Extracts only the measurements on the mean and standard deviation for each measurement
4. Gives variables more descriptive/explicit names (e.g. variables beginning with "t" are Time-related)
5. Summarizes data, giving mean of each selected variable for a given subject and activity
6. Gives descriptive activity names from the UCI activity_labels table
7. Outputs the tidy data to tidy_data.txt