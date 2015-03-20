# set working directory to be the directory the script is located in
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# create data dir if it doesn't already exist
if (!file.exists("data")) {
  dir.create("data")
}

# download zipped data files (using cURL, since it's HTTPS)
if (!file.exists("data/UCI_HAR_Dataset.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="data/UCI_HAR_Dataset.zip", method="curl")
}

# unzip data files to 'data' directory
unzip("data/UCI_HAR_Dataset.zip", exdir="data")

# get column names from features.txt
column_names <- read.table("data/UCI HAR Dataset/features.txt")

# read data from both train and test datasets
train_data <- read.table("data/UCI HAR Dataset/train/X_train.txt")
test_data <- read.table("data/UCI HAR Dataset/test/X_test.txt")

# write.table() using row.name=FALSE