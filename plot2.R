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

# Plot the Global Active Power as a line with no markers
plot(df$datetime, df$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
# Copy the plot to PNG
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
