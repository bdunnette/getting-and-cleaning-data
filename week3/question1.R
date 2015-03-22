this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/ss06hid.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl, destfile="data/ss06hid.csv", method="curl")
}

data <- read.csv("data/ss06hid.csv")

agricultureLogical <- data$ACR == 3 & data$AGS == 6

data_filtered <- data[which(agricultureLogical),]