# Load necessary libraries
library(dplyr)
library(lubridate)

# Assign column names to the dataframe
names(data) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 
                                     'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')


# Proceed with the rest of your code for filtering and analysis
data$Date <- as.POSIXlt(data$Date, format = "%d/%m/%Y")
# Determine the range of dates for the 6th week in the form "YYYY-MM-DD"
start_date <- as.POSIXlt("2007-02-05") # start date of the 6th week
end_date <- as.POSIXlt("2007-02-11") # end date of the 6th week
# Subset the data for the 6th week
week_data <- data[data$Date >= start_date & data$Date <= end_date, ]



data$Time <- format(strptime(data$Time, format = "%H:%M:%S"), "%H:%M")

daytime_weekdays <- subset(week_data, as.integer(format(week_data$Date, "%u")) %in% 1:5 & 
                             Time >= "07:30" & Time <= "17:00")

average_daytime_weekdays <- aggregate(Global_intensity ~ Time, daytime_weekdays, mean)



weekend_data <- subset(week_data, as.integer(format(week_data$Date, "%u")) %in% c(6, 7))
average_weekend_daytime <- aggregate(Global_intensity ~ Time, weekend_data, mean)
