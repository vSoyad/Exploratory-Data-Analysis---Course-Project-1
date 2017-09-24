# create the directory if does not exist.
if(!file.exists("Data")){dir.create("Data")}

# unzip the data file it does not exist
if(!file.exists("./data/household_power_consumption.txt"))
      {
  
          #unzip the data set file for the course project
          unzip(zipfile="./data/exdata_data_household_power_consumption.zip",exdir="./data")
      }

if(is.null(Dataset))
  
      {
        Dataset <- read.csv("./Data/household_power_consumption.txt", header=F, sep=';', na.strings="?", 
                              nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
      }

# Provide column names to the dataset

colnames(Dataset) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                       "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Convert the date column to subset the data for 01/02/2007 and 02/02/2007
Dataset$Date <- as.Date(Dataset$Date,format="%d/%m/%Y")
data <- subset(Dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# convert Global active power to numeric
Dataset$Global_active_power <- as.numeric(Dataset$Global_active_power)


# generate the histogram with x axis lable, header and color for the graph
hist(data$Global_active_power,col="red",xlab="Global active power(kilowatts)",main="Global Active Power")

dev.copy2pdf(device = windows(), file = "./data/Plot1.pdf")
dev.off()

 


