require(sqldf)

this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-ss06pid.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileUrl, destfile="data/getdata-data-ss06pid.csv")
}

acs <- read.csv("data/getdata-data-ss06pid.csv")

unique_agep <- sqldf("select distinct AGEP from acs")