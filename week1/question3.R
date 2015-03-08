this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

require(xlsx)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-DATA.gov_NGAP.xlsx")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    download.file(fileUrl, destfile="data/getdata-data-DATA.gov_NGAP.xlsx", method="auto")
}

dat <- read.xlsx("data/getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1, startRow=18, endRow=23, colIndex=c(7:15), header=TRUE)

mySum <- sum(dat$Zip*dat$Ext,na.rm=T)