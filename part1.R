getwd()
setwd("C:/Users/parmi/cmpt318/cyberSec/")

DataDf <- read.table("Group_Assignment_Dataset.txt", header = T, sep = ",")
# I think you need to install packages before here 

library(ggplot2)

# Assuming 'data' is your data frame and it contains several columns with NAs

# Applying linear interpolation for each column
data_interp <- DataDf  # Create a copy of the data to store interpolated values

# Loop over each column in the data frame
for(i in 1:ncol(DataDf)) {
  # Check if the column has any missing values
  if(any(is.na(DataDf[[i]]))) {
    # Get the indices of non-missing values
    good_data <- na.omit(DataDf[[i]])
    # Interpolate missing values using the good data
    data_interp[[i]] <- approx(good_data, xout = seq_along(DataDf[[i]]))$y
  }
}

# Now, data_interp contains the data with interpolated values
options(digits=15)
data_interp[168502,]
DataDf[168502,]

#approxm(data1, n, method = "linear")
library(dplyr)
library(zoo)
df <- DataDf
#interpolate missing values in 'sales' column
df <- df %>%
   mutate(Global_reactive_power = na.approx(Global_reactive_power))
df <- df %>%
  mutate(Voltage  = na.approx(Voltage ))
df <- df %>%
   mutate(Global_intensity = na.approx(Global_intensity))
df <- df %>%
   mutate(Sub_metering_1  = na.approx(Sub_metering_1 ))
df <- df %>%
   mutate(Sub_metering_2  = na.approx(Sub_metering_2 ))
df <- df %>%
   mutate(Sub_metering_3  = na.approx(Sub_metering_3 ))
#view updated data frame

df[168502,]
data_interp[168502,]
DataDf[168502,]
###############################################
# the date formatted as "DD/MM/YYYY"

DataDf$Date <- as.POSIXlt(DataDf$Date, format = "%d/%m/%Y")

# Determine the range of dates for the 6th week in the form "YYYY-MM-DD"
start_date <- as.POSIXlt("2007-02-05") # start date of the 6th week
end_date <- as.POSIXlt("2007-02-11") # end date of the 6th week

# Subset the data for the 6th week
week_data <- DataDf[DataDf$Date >= start_date & DataDf$Date <= end_date, ]
################################################

ggplot()+layer(data = DataDf, mapping = aes(x=Time, y=Voltage), geom = "point",stat="identity", position = position_identity())

###############################################

ggplot()+
  layer(data = DataDf, mapping = aes(x=Date, y=Voltage), geom = "point",stat="identity", position = position_identity())

###############################################

ggplot()+
  layer(data = DataDf, mapping = aes(x=Date, y=Voltage), geom = "point",stat="identity", position = position_jitter(width = 0.3, height = 0)) +
  coord_cartesian() +
  scale_x_discrete() +
  scale_y_continuous()

###############################################

ggplot()+
  layer(data = DataDf, mapping = aes(x=Date, y=Voltage), geom = "point",stat="identity", position = position_jitter(width = 0.3, height = 0)) +
  layer(data = DataDf, mapping = aes(x=Date, y=Voltage), geom = "boxplot" ,stat="boxplot", position = position_identity()) +
  coord_cartesian() +
  scale_x_discrete() +
  scale_y_continuous()

###############################################

ggplot()+
  layer(data = DataDf, mapping = aes(x=Time, y=Voltage, color = Date), geom = "point",stat="identity", position = position_identity()) +
  coord_cartesian() +
  scale_x_discrete() +
  scale_y_continuous() +
  scale_color_hue()

###############################################

ggplot()+
  layer(data = DataDf, mapping = aes(x=Time, y=Voltage, color = Global_intensity), geom = "point",stat="identity", position = position_identity()) +
  coord_cartesian() +
  scale_x_discrete() +
  scale_y_continuous() +
  scale_color_continuous() +
  facet_wrap(~Date)

###############################################

ggplot()+
  layer(data = DataDf, mapping = aes(x=Time, y=Voltage, color = Global_intensity), geom = "point",stat="identity", position = position_identity()) +
  coord_cartesian() +
  scale_x_discrete() +
  scale_y_continuous() +
  scale_color_continuous(low = "#0061ff", high = "#00ffe1", name = "Global_Intensity", guide = guide_colorbar(direction = "vertical")) +
  facet_wrap(~Date)

###############################################