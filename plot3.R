#sqldf in Mac requires X11. To overrule the requirement the following line is used. 
options(gsubfn.engine = "R") #Without this R Crashes
library(sqldf)
require("sqldf")

#Query for picking only two days
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myFile <- "./household_power_consumption.txt"
myData <- read.csv2.sql(myFile,mySql)

#Getting the Datetime
#Combining the Date and Time
getTime <- paste(myData$Date, myData$Time)

#Converting to proper time format
datetime <- strptime(getTime, "%d/%m/%Y %H:%M:%S")


#Plotting
png(file = "plot3.png", bg="white", width = 480, height = 480, units = "px")
plot(datetime, myData$Sub_metering_1, type="l", xlab= "", ylab = "Energy sub metering")
lines(datetime, myData$Sub_metering_2, type ="l", col = "red")
lines(datetime, myData$Sub_metering_3,type ="l", col = "blue")
legend("topright", lty=1, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"))
dev.off()