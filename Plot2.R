#clear screen
rm(list = ls())
# create the directory if does not exist.
if(!file.exists("Data")){dir.create("Data")}

# unzip the data file it does not exist
if(!file.exists("./data/household_power_consumption.txt"))
        {
  
            #unzip the data set file for the course project
            unzip(zipfile="./data/exdata_data_household_power_consumption.zip",exdir="./data")
        }

Dataset <- read.csv("./Data/household_power_consumption.txt", header=F, sep=';', na.strings="?", 
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# Provide column names to the dataset

colnames(Dataset) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Convert the date column to subset the data for 01/02/2007 and 02/02/2007
Dataset$Date <- as.Date(Dataset$Date,format="%d/%m/%Y")
data <- subset(Dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# convert the Global active power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# use the strptime and POSIXct to convert the data into datetime
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

data$datetime <- as.POSIXct(data$datetime)

#plot the graph
with(data,plot(Global_active_power ~ datetime, type = "l",ylab = "Global Active Power (kilowatts)", xlab = ""))

#copy the plot to png file
dev.copy(png,file="./data/Plot2.png",height=480,width=480)
dev.off()






