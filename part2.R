library(ggcorrplot)

getwd()
setwd("C:/Users/Kelly/cyberSec/")

data <- read.table("Group_Assignment_Dataset.txt", header = T, sep = ",")

#compute correlation matrix
AB <- cor(data$Global_active_power, data$Global_reactive_power, method = "pearson")
AC <- cor(data$Global_active_power, data$Voltage, method = "pearson")
AD <- cor(data$Global_active_power, data$Global_intensity, method = "pearson")
AE <- cor(data$Global_active_power, data$Sub_metering_1, method = "pearson")
AF <- cor(data$Global_active_power, data$Sub_metering_2, method = "pearson")
AG <- cor(data$Global_active_power, data$Sub_metering_3, method = "pearson")

BC <- cor(data$Global_reactive_power, data$Voltage, method = "pearson")
BD <- cor(data$Global_reactive_power, data$Global_intensity, method = "pearson")
BE <- cor(data$Global_reactive_power, data$Sub_metering_1, method = "pearson")
BF <- cor(data$Global_reactive_power, data$Sub_metering_2, method = "pearson")
BG <- cor(data$Global_reactive_power, data$Sub_metering_3, method = "pearson")

CD <- cor(data$Voltage, data$Global_intensity, method = "pearson")
CE <- cor(data$Voltage, data$Sub_metering_1, method = "pearson")
CF <- cor(data$Voltage, data$Sub_metering_2, method = "pearson")
CG <- cor(data$Voltage, data$Sub_metering_3, method = "pearson")

DE <- cor(data$Global_intensity, data$Sub_metering_1, method = "pearson")
DF <- cor(data$Global_intensity, data$Sub_metering_2, method = "pearson")
DG <- cor(data$Global_intensity, data$Sub_metering_3, method = "pearson")

EF <- cor(data$Sub_metering_1, data$Sub_metering_2, method = "pearson")
EG <- cor(data$Sub_metering_1, data$Sub_metering_3, method = "pearson")

FG <- cor(data$Sub_metering_2, data$Sub_metering_3, method = "pearson")


#correlation_matrix <- cor(data, method = "pearson")
matrix <- round(cor(data[,3:9], method = "pearson", use = "complete.obs"),3)
ggcorrplot(matrix)
head(matrix)


