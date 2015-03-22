this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-GDP.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(fileUrl, destfile="data/getdata-data-GDP.csv", method="curl")
}

if (!file.exists("data/getdata-data-EDSTATS_Country.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(fileUrl, destfile="data/getdata-data-EDSTATS_Country.csv", method="curl")
}

gdp <- read.csv("data/getdata-data-GDP.csv", skip=4, nrows=231, blank.lines.skip=TRUE,
                colClasses = c("character", "integer", "character", "character", "character", "character", "character", "character", "character", "character"))
colnames(gdp)[1] <- "CountryCode"
colnames(gdp)[2] <- "GDPRank"

edstats <- read.csv("data/getdata-data-EDSTATS_Country.csv")
data_merged <- merge(gdp, edstats)
data_ordered <- data_merged[order(data_merged$GDPRank, decreasing=TRUE, na.last=TRUE),]
oecd <- mean(data_merged$GDPRank[data_merged$Income.Group == "High income: OECD"], na.rm=TRUE)
non_oecd <- mean(data_merged$GDPRank[data_merged$Income.Group == "High income: nonOECD"], na.rm=TRUE)
