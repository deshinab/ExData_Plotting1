temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip(temp, list =TRUE)
data <- read.table(unzip(temp, "household_power_consumption.txt"),
                   na.strings = "?", 
                   sep = ";", 
                   header = TRUE)

##Subset data. Set date to the date format currently used by the file, "%d/%m/%Y", hence 2/1/2007 is printed 1/2/2017. 
data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007",
                   select = Date:Sub_metering_3)
##Remove missing values
na.omit(data_sub)

##Create a formated date and time column.
data_sub$Date_Time <- paste(data_sub$Date, data_sub$Time)
data_sub$Date_Time <- strptime(data_sub$Date_Time, "%d/%m/%Y %H:%M:%S")

##Print upcoming graphic to png.
png("plot2.png", height = 480, width = 480, unit = "px")

##Create a Date_Time by Global_active_power plot.
with(data_sub,plot(Date_Time,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " "))

#Turn the png device off. 
dev.off()
