# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average? 

library(dplyr)

this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-data-GDP.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(fileUrl, destfile="data/getdata-data-GDP.csv", method="auto")
}

gdp <- read.csv("data/getdata-data-GDP.csv", skip=4, nrows=231, blank.lines.skip=TRUE)

colnames(gdp)[1] <- "CountryCode"
colnames(gdp)[2] <- "GDPRank"
colnames(gdp)[4] <- "CountryName"
colnames(gdp)[5] <- "GDP"

gdp_tbl <- tbl_df(gdp)
gdp_tbl <- mutate(gdp_tbl, gdp2 = as.numeric(gsub(",","",GDP)))
gdp_tbl2 <- filter(gdp_tbl, !is.na(gdp2), !is.na(GDPRank))
