# plot2.R, Produce Plot2 for Course Project 1 - Exploratory Data Analysis
# Josh Venman, March 2015
#
# Assumes working directory is set to the location of this script and that the household_power_consumption.txt file exists
# in the same directory

library(dplyr)

# Read the data - assigning column types and dealing with NA characters as "?"
rawdata <- read.csv(file="household_power_consumption.txt",header=TRUE,sep=";",na.strings=c("?"),colClasses=c("character","character",rep("numeric",7)))

# Add a column to the data that combines the separate date and time data in to one date type value
rawdata$DateTimeVal <- as.Date(paste(rawdata$Date,rawdata$Time), format = "%d/%m/%Y %H:%M:%S")

# Use dplyr filter to get only the data from 1st Feb 2007 and 2nd Feb 2007

d <- filter(rawdata, DateTimeVal >= as.Date("2007-02-01 00:00:00"), DateTimeVal < as.Date("2007-02-03 00:00:00"))

# Get full time including minutes for plotting
d$plottime <- strptime(paste(d$Date,d$Time),format="%d/%m/%Y %H:%M:%S")

# Create plot with required params
par(mar=c(5,5,4,4),cex.axis=0.75,cex.lab=0.75,cex.main=1,font.lab=2)
plot(d$plottime,d$Global_active_power,type="s",xlab="",ylab="Global Active Power (kilowatts)")


# Now output to PNG image of required size (480 x 480 pixels)
dev.copy(png,"plot2.png",width=480,height=480)

dev.off()





