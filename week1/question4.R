this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

require(XML)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-restaurants.xml")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
    download.file(fileUrl, destfile="data/getdata-data-restaurants.xml", method="auto")
}

doc <- xmlTreeParse("data/getdata-data-restaurants.xml",useInternal=TRUE)

zips <- xpathSApply(doc, "//row[zipcode/text()='21231']", xmlValue)

