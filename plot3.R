#-----------------------------
# AUTHOR: Mala Viswanath
# DATE: June 5, 2015
# SPECIALIZATION: Data Scientist
# COURSE: 04 Exploratory Data Analysis
# PROJECT: 1
#-----------------------------------------------------

#-----------------------------------------------------
# DATA COL NAMES 
# Date;Time;Global_active_power;Global_reactive_power; 
# Voltage;Global_intensity;
# Sub_metering_1;Sub_metering_2;Sub_metering_3
#-----------------------------------------------------

#-----------------------------------------------------
# Sample data from original input file
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
#-----------------------------------------------------

#-----------------------------------------------------
# Read original data set - filter by Feb 1st 2007 and Feb 2nd 2007
#-----------------------------------------------------
library(sqldf)
SQL <- 'select * from file where Date in ("1/2/2007","2/2/2007")'
B <- read.csv.sql("household_power_consumption.txt", header = TRUE, stringsAsFactors=FALSE, sep=";", sql=SQL)

#-----------------------------------------------------
# TIDY IMPORTED DATA
# 1. Convert character data to numeric data
#    1.1 Global Active Power
#    1.2 Global Reactive Power
#    1.3 Voltage
#    1.4 Sub Metering 1
#    1.5 Sub Metering 2
#    1.6 Sub Metering 3
# 2. Combine Date and Time columns. Convert via call to strptime function
#-----------------------------------------------------
B$Global_active_power <- gsub("\"", "", B$Global_active_power)
B$Global_active_power <- as.numeric(B$Global_active_power)

B$Global_reactive_power <- gsub("\"", "", B$Global_reactive_power)
B$Global_reactive_power <- as.numeric(B$Global_reactive_power)

B$Voltage <- gsub("\"", "", B$Voltage)
B$Voltage <- as.numeric(B$Voltage)

B$Sub_metering_1 <- gsub("\"", "", B$Sub_metering_1)
B$Sub_metering_1 <- as.numeric(B$Sub_metering_1)

B$Sub_metering_2 <- gsub("\"", "", B$Sub_metering_2)
B$Sub_metering_2 <- as.numeric(B$Sub_metering_2)

B$Sub_metering_3 <- gsub("\"", "", B$Sub_metering_3)
B$Sub_metering_3 <- as.numeric(B$Sub_metering_3)

B$Mod_Date <- paste(B$Date, B$Time)
B$Mod_Date <- strptime(B$Mod_Date, "%d/%m/%Y %X")

#-----------------------------------------------------
# Plot 3 - Plot Energy sub metering Data
#-----------------------------------------------------
png(filename = "plot3.png", width = 480, height = 480)
plot(B$Mod_Date, B$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab ="")
lines(B$Mod_Date, B$Sub_metering_1, col = "black")
lines(B$Mod_Date, B$Sub_metering_2, col ="red")
lines(B$Mod_Date, B$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering1","Sub_metering2","Sub_metering3"), lty=c(1,1), col =c("black", "red", "blue"), lwd = c(2,2))
dev.off()
