
library(data.table)
library(dplyr)

## Download, unzip, and read file
url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "household_data.zip")
unzip("household_data.zip")
homeData <- fread("household_power_consumption.txt", header=TRUE, 
                  na.strings="?")

## Subset to the dates of interest; format date/time properly
home_dt <- subset(homeData, Date=="1/2/2007" | Date=="2/2/2007")
home_dt$Date <- sub("/2/", "/02/", home_dt$Date)
home_dt$Date <- paste(home_dt$Date, home_dt$Time)
home_dt$Date <- as.POSIXct(home_dt$Date, format="%d/%m/%Y %H:%M:%S")

## Create plot and save as png file
plot(home_dt$Date,home_dt$Sub_metering_1, 
     ylab="Energy sub metering", xlab="", type="l")
lines(home_dt$Date, home_dt$Sub_metering_2, xlab="", ylab="Energy sub metering",
     type = "l", col="red")
lines(home_dt$Date, home_dt$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue"))
dev.copy(png, file="plot3.png")
dev.off()