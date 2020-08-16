### Load libraries

library(tidyverse)


### Check if raw data is already in working directory. If not, download the file from the web.

if (!file.exists("raw_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","raw_data.zip")
}


### Check if raw data set is already unzipped in working directory. Else, unzip it.

if (!file.exists("household_power_consumption.txt")){
  unzip("raw_data.zip")
}


### Read raw data into R. Explicitly change the field separator for ";" and set the character "?" to be interpreted as a missing value.
### Also coerce Date and Time fields to the correct data types.

household_power_consumption <- read_delim("household_power_consumption.txt", delim = ";",na = "?",
                                          col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                                           Time = col_time(format = "%H:%M:%S")))


### Subset raw data, and obtain the dataset only of dates between 2007-02-01 and 2007-02-02

household_power_consumption_Feb <- filter(household_power_consumption,Date == '2007-02-01' | Date == '2007-02-02')

### Merge date and time fields into one unique POSIXct variable

household_power_consumption_Feb$date_time <- as.POSIXct(paste(household_power_consumption_Feb$Date,household_power_consumption_Feb$Time))


### Create plot nro 2 on screen device

plot(household_power_consumption_Feb$date_time,household_power_consumption_Feb$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")


### Copy plot to PNG file

dev.copy(png,file="plot2.png",width=480,height=480)


### Close PNG device

dev.off()
