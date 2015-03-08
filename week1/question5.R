this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

require(data.table)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-ss06pid.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileUrl, destfile="data/getdata-data-ss06pid.csv", method="auto")
}

DT <- fread("data/getdata-data-ss06pid.csv")

means <- DT[,mean(pwgtp15),by=SEX]

