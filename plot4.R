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
png(file="plot4.png", width=480, height=480)

## setting the plotting area
par(mfrow=c(2, 2))

## creating the first plot
with(TimeData, plot(Global_active_power ~ dateTime, type="l", xlab="", ylab="Global Active Power"))

## creating the second plot
with(TimeData, plot(Voltage ~ dateTime, type="l", xlab="datetime"))

## creating the third plot
with(TimeData, plot(Sub_metering_1 ~ dateTime, type="n", xlab="", ylab="Energy sub metering"))
with(TimeData, points(Sub_metering_1 ~ dateTime, type="l"))
with(TimeData, points(Sub_metering_2 ~ dateTime, type="l", col="red"))
with(TimeData, points(Sub_metering_3 ~ dateTime, type="l", col="blue"))
with(TimeData, legend(legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), x="topright", col=c("black", "red", "blue"), cex=0.8, bty="n", lty=1))

## creating the fourth plot
with(TimeData, plot(Global_reactive_power ~ dateTime, type="l", xlab="datetime"))

## closing the opened grahics device
dev.off()