this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/ss06hid.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl, destfile="data/ss06hid.csv")
}

data <- read.csv("data/ss06hid.csv")

idaho <- data[which(data$ST=='16'),]

idaho_mil <- idaho[which(idaho$VAL=='24'),]