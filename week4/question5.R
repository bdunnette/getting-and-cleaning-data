# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
amzn_2012 <- amzn['2012']

amzn_df <- as.data.frame(amzn_2012)
row_names <- row.names(amzn_df)
row_names_weekdays <- lapply(row_names, function(date_str) weekdays(as.Date(date_str)))
amzn_df$weekday <- row_names_weekdays
is_monday <- amzn_df$weekday == "Monday"
amzn_mondays <- amzn_df[which(is_monday),]