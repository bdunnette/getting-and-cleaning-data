this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

library(jpeg)

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/getdata-jeff.jpg")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    download.file(fileUrl, destfile="data/getdata-jeff.jpg", method="curl")
}

img <- readJPEG("./data/getdata-jeff.jpg", native=TRUE)

img_quantiles <- quantile(img, probs = c(0.3, 0.8))
