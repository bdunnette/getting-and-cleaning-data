this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists("data/UCI_HAR_Dataset.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="data/UCI_HAR_Dataset.zip", method="curl")
}

unzip("data/UCI_HAR_Dataset.zip", exdir="data")


