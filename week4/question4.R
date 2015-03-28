# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June? 
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-GDP.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(fileUrl, destfile="data/getdata-data-GDP.csv", method="auto")
}

if (!file.exists("data/getdata-data-EDSTATS_Country.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(fileUrl, destfile="data/getdata-data-EDSTATS_Country.csv", method="auto")
}

gdp <- read.csv("data/getdata-data-GDP.csv", skip=4, nrows=231, blank.lines.skip=TRUE)
colnames(gdp)[1] <- "CountryCode"
colnames(gdp)[2] <- "GDPRank"

edstats <- read.csv("data/getdata-data-EDSTATS_Country.csv")
data_merged <- merge(gdp, edstats)
fy_june <- grep("Fiscal year end: June", data_merged$Special.Notes, ignore.case=TRUE)