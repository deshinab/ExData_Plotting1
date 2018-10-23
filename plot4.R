temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip(temp, list =TRUE)
data <- read.table(unzip(temp, "household_power_consumption.txt"),
                   na.strings = "?", 
                   sep = ";", 
                   header = TRUE)
#Convert date
strptime(data$Date, format = "%d/%m/%Y")

##Subset data
data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007",
                   select = Date:Sub_metering_3)
##Remove missing values
na.omit(data_sub)

##Create a formated date and time column.
data_sub$Date_Time <- paste(data_sub$Date, data_sub$Time)
data_sub$Date_Time <- strptime(data_sub$Date_Time, "%d/%m/%Y %H:%M:%S")
#Create a 2by2 canvas.
par(mfcol = c(2,2))

##Print upcoming graphic to png.
png("plot4.png", height = 480, width = 480, unit = "px")

##Duplicate the Global_active_power by Time plot
with(data_sub,plot(Date_Time,Global_active_power, 
                   type = "l", 
                   ylab = "Global Active Power", 
                   xlab = " "))
## Create the Energy sub metering by Time plot
plot(x = data_sub$Date_Time, y = data_sub$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
lines(x = data_sub$Date_Time, y = data_sub$Sub_metering_1)
lines(x = data_sub$Date_Time, y = data_sub$Sub_metering_2, col = "red")
lines(x = data_sub$Date_Time, y = data_sub$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n")

## Create the Voltage by Time plot
plot(x = data_sub$Date_Time, y = data_sub$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

## Create the Global_reactive_power by Time plot
plot(x = data_sub$Date_Time, y = data_sub$Global_reactive_power, 
     type = "l", xlab = "datetime", ylab = "Global_Reactive_Power")
dev.off()