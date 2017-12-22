#R script to plot histogram of "Global Active Power" from 2007-02-01 to 2007-02-02 
#from dataset "Individual household electric power consumption Data Set"

#Instruction:
#Manually set the working directory first to the folder containing raw data
#before running(sourcing) this R-script.

#Use library lubridate on working date and time.
library(lubridate)

#Read raw csv data.
column_classes<-c(rep("character",2),rep("numeric",7))
raw_data<-read.csv("household_power_consumption.txt", sep=";", colClasses = column_classes,stringsAsFactors = FALSE,na.strings = "?")

#Get data indices for dates from 2007-02-01 to 2007-02-02.
date_and_time<-paste(raw_data$Date, raw_data$Time)
date_and_time<-dmy_hms(date_and_time) #Convert to date/time format
two_days_indices<-date_and_time>=ymd("2007-02-01") & date_and_time<ymd("2007-02-03")

#Regroup valid data falling on the said required dates.
two_day_data<-cbind(date_and_time[two_days_indices],raw_data[two_days_indices,-c(1:2)])

#Plot multiple x-y plots to screen, set rows and columns.
par(mfrow = c(2, 2))

#First plot
plot(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Global_active_power,type = "l",xlab = "",ylab="Global Active Power")

#Second plot
plot(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Voltage,type = "l",xlab = "datetime",ylab="Voltage")

#Third plot
plot(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Sub_metering_1,type = "n",xlab = "",ylab="Energy sub metering")
points(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Sub_metering_1,type="l")
points(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Sub_metering_2,type="l",col="red")
points(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Sub_metering_3,type="l",col="blue")
legend("topright",lty = 1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Last plot
plot(two_day_data$`date_and_time[two_days_indices]`,two_day_data$Global_reactive_power,type = "l",xlab = "datetime",ylab="Global_reactive_power")


#copy to png file.
dev.copy(png, file="plot4.png")
dev.off()