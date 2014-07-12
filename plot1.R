## Before running this code pls save the data file in your working directory

## creating an object with the file name
myFile <- "household_power_consumption.txt"

## creating an object containing the specific criteria of 2 given dates
mySql <- "Select * from file where Date='1/2/2007' OR Date='2/2/2007'"

## loading the "sqldf" package to have the function "read.csv.sql"
library(sqldf)

## reading the data with the condition specified
dfData <- read.csv.sql(myFile, mySql, header=TRUE, sep=";")

## opening up a .png file as a output graphics device
png(file="plot1.png", width=480, height=480)

## creating the reqd. histogram
with(dfData, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))

## closing the opened grahics device
dev.off()