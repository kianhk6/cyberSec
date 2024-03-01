#libraries 
library("zoo")
library("dplyr")
library("car")
library("forcats")
library("ggplot2")
library("gplots")
library("effects")
library("lubridate")
library("tidyverse")
library("corrplot")

getwd()
#PLEASE SET USE setwd TO GET THE DATA
setwd("C:/Users/okbuddy/Documents/GitHub/cyberSec")
#ingest data
DataDf <- read.table("data.csv", header = T, sep = ",")

data <- read.csv(
  "data.csv", 
  sep = ",", 
  header = TRUE
)


########################################### QUESTION 3 ########################################################

# Assign column names to the data frame
names(df) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 
               'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')


# Proceed with the rest of your code for filtering and analysis
df$Date <- as.POSIXlt(df$Date, format = "%d/%m/%Y")


# There is an entry for every minute, 60 minutes x 24 hours x 7 days = 10080 entries for each week.
observations_per_week <- 60 * 24 * 7
# number of completed 
num_complete_weeks <- nrow(data) %/% observations_per_week

window_size <- 480 # 8 hours (540 minutes)

# Add a week column to group by week
data$Week <- (seq_along(data$Date) - 1) %/% observations_per_week + 1




smoothened_df <- data.frame()
# 1. mutate(Smoothened_Global_Intensity = rollapply(Global_intensity, width = window_size, FUN = mean, fill = NA, align = 'center')):
#    - `mutate()` adds a new column or modifies existing ones in the data frame. Here, it's adding the `Smoothened_Global_Intensity` column.


#    - `rollapply()` is a function from the `zoo` package that applies a function (in this case, `mean`) over a rolling window of a specified width (here, `window_size`) across the data. 

#    - `Global_intensity` is the column over which the rolling mean is calculated.

#    - `width = window_size` specifies the size of the rolling window. In this context, it's set to 480, representing 8 hours, assuming there's one observation per minute.

#    - `FUN = mean` tells `rollapply` to compute the mean of the values within each window.

#    - `fill = NA` determines how to handle cases where the window does not fully overlap the data at the beginning and end of the dataset; here, it fills these with `NA` (missing values).

#    - `align = 'center'` specifies that the rolling window should be centered around the current observation. 
#     This means for a given point, the window includes observations before and after it, centered on the point.

smoothened_df <- data %>%
  group_by(Week) %>%
  mutate(Smoothened_Global_Intensity = rollapply(Global_intensity, width = window_size, FUN = mean, fill = NA, align = 'center')) %>%
  ungroup()


# Compute the row-wise mean to get the average smoothed week:
reshaped_data <- matrix(smoothened_df$Smoothened_Global_Intensity, nrow = observations_per_week)

# how this matrix works

# the number of rows here are the amount of obeservation in each week
# and the values are the smoothened global intencity 
# so the columns basically become number of weeks
# total values / number of values in each week = number of weeks
# meaning: total values (number of enteries) = number of values in each week (times or minutes as rows) * number of weeks (as column)

# so average each row means averaging the same time (same row) accross all different weeks (columns)
average_smoothed_week <- rowMeans(reshaped_data, na.rm = TRUE)



# Compute anomaly scores for each week
anomaly_scores_df <- smoothened_df %>%
  group_by(Week) %>%
  #  compare each smoothened week to the average smoothened week and quantify the deviation in terms of squared differences
  summarise(Anomaly_Score = sqrt(mean((Smoothened_Global_Intensity - average_smoothed_week)^2, na.rm = TRUE))) %>%
  ungroup()

# sort it
sorted_anomaly_table_desc <- anomaly_scores_df[order(-anomaly_scores_df$Anomaly_Score), ]

# extract most and least
most_anomalous_week <- sorted_anomaly_table_desc$Week[1]
least_anomalous_week <- sorted_anomaly_table_desc$Week[nrow(sorted_anomaly_table_desc)]

# Print out the week numbers for the most and least anomalous weeks:
cat("The most anomalous week is: Week", most_anomalous_week, "\n")
cat("The least anomalous week is: Week", least_anomalous_week, "\n")


# Plotting:
p <- ggplot() +
  geom_line(aes(x = 1:observations_per_week, y = average_smoothed_week, color = "Average Smoothed Week")) +
  geom_line(data = smoothened_df[((most_anomalous_week-1)*observations_per_week + 1):(most_anomalous_week*observations_per_week), ],
            aes(x = 1:observations_per_week, y = Smoothened_Global_Intensity, color = "Most Anomalous Week")) +
  geom_line(data = smoothened_df[((least_anomalous_week-1)*observations_per_week + 1):(least_anomalous_week*observations_per_week), ],
            aes(x = 1:observations_per_week, y = Smoothened_Global_Intensity, color = "Least Anomalous Week")) +
  labs(title = "Comparison of Most and Least Anomalous Weeks vs Average Smoothed Week",
       x = "Observation Number",
       y = "Global Intensity",
       color = "Legend") +
  theme_minimal()

print(p)



