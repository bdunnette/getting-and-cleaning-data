this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

datafile <- "data/getdata-wksst8110.for"

if (!file.exists(datafile)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
    download.file(fileUrl, destfile=datafile)
}

# Read fixed-width file, skipping 4 header lines
data <- read.fwf(
    file=file(datafile),
    skip=4,
    widths=c(12, 7,4, 9,4, 9,4, 9,4))

# Print sum of values in column 4
print(sum(data[,4]))