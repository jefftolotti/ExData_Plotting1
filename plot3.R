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

# Plot the Sub Metering 1 line
plot(df$datetime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
# Add a red line for Sub Metering 2
lines(df$datetime, df$Sub_metering_2, type = "l", col = "red")
# Add a blue line for Sub Metering 3
lines(df$datetime, df$Sub_metering_3, type = "l", col = "blue")
# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, lwd = 1)
# Copy the plot to PNG
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
