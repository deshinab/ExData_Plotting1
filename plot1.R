temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
    unzip(temp, list =TRUE)
data <- read.table(unzip(temp, "household_power_consumption.txt"),
            na.strings = "?", 
            sep = ";", 
            header = TRUE)

##Subset data
data_sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007",
            select = Date:Sub_metering_3)
##Remove missing values
na.omit(data_sub)

##Print upcoming graphic to png.
png("plot1.png", height = 480, width = 480, unit = "px")

##Creare Global Active Power histogram.
hist(data_sub$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)"
     , main = "Global Active Power")
dev.off()



        

            