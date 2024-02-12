getwd()
setwd("C:/Users/parmi/cmpt318/cyberSec/")

DataDf <- read.table("Group_Assignment_Dataset.txt", header = T, sep = ",")
# I think you need to install packages before here 

library(ggplot2)


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