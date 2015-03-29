# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)

#Get all AMZN values for 2012
amzn_2012 <- amzn['2012']

#Convert to a data frame for easier manipulation
amzn_df <- as.data.frame(amzn_2012)

#Get row names (dates) so that we can convert to days of the week
row_names <- row.names(amzn_df)

#Get day of week for each row using the weekdays() function
row_names_weekdays <- lapply(row_names, function(date_str) weekdays(as.Date(date_str)))

#Add day of week column to amzn_df data frame
amzn_df$weekday <- row_names_weekdays

#Create a logical vector based on whether each observation was on a Monday
is_monday <- amzn_df$weekday == "Monday"

#Finally, select only Monday observations
amzn_mondays <- amzn_df[which(is_monday),]