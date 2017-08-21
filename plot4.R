# Read data from text file and assign classes
df_all <- read.table("household_power_consumption.txt", header = T, sep = ";",
    na.strings = "?", colClasses = c("character", "character", "numeric", "numeric",
    "numeric", "numeric", "numeric", "numeric", "numeric"))
# Create a new vector coercing the Date and Time columns into a timestamp
datetime <- strptime(paste(df_all$Date, df_all$Time), "%d/%m/%Y %H:%M:%S")
# Bind the timestamp to the original data frame
df_all <- cbind(df_all, datetime)
# Subset the data frame to only the two dates needed
df <- subset(df_all, datetime >= '2007-02-01' & datetime < '2007-02-03')

# Set the parameters to a 2x2 grid of plots
par(mfrow = c(2,2))
# Plot the first line chart
plot(df$datetime, df$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")
# Plot the second line chart
plot(df$datetime, df$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")
# Plot the third line chart and scale legend to fit
plot(df$datetime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(df$datetime, df$Sub_metering_2, type = "l", col = "red")
lines(df$datetime, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n", cex = 0.65)
# Plot the fourth line chart and scale axis labels to fit
plot(df$datetime, df$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime", cex.axis = 0.8)
# Copy the plot to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()