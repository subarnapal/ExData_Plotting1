## Before running this code pls save the data file in your working directory

## creating an object with the file name
myFile <- "household_power_consumption.txt"

## creating an object containing the specific criteria of 2 given dates
mySql <- "Select * from file where Date='1/2/2007' OR Date='2/2/2007'"

## loading the "sqldf" package to have the function "read.csv.sql"
library(sqldf)

## reading the data with the condition specified
dfData <- read.csv.sql(myFile, mySql, header=TRUE, sep=";")

## creating a new dataframe with the data read in the last step and the date & time variables combined
TimeData <- cbind(dfData, dateTime=with(dfData, strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))

## opening up a .png file as a output graphics device
png(file="plot3.png", width=480, height=480)

## creating a blank plot
with(TimeData, plot(Sub_metering_1 ~ dateTime, type="n", xlab="", ylab="Energy sub metering"))

## creating the plots with Sub_metering_1 , 2 & 3 one by one
with(TimeData, points(Sub_metering_1 ~ dateTime, type="l"))
with(TimeData, points(Sub_metering_2 ~ dateTime, type="l", col="red"))
with(TimeData, points(Sub_metering_3 ~ dateTime, type="l", col="blue"))

## adding the legend on the plotted area
with(TimeData, legend(legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x="topright", col=c("black", "red", "blue"), cex=0.8, lty=1))

## closing the opened grahics device
dev.off()