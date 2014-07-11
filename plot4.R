# import the data
df <- read.table(file = "./household_power_consumption.txt", 
                   sep = ";", 
                   header = TRUE, 
                   dec = ".",
                   na.strings = "?"
                 )
# convert Date string to Date object. This reformats the representation to yyyy-mm-dd implicitly !!!!
df$Date <- as.Date(df$Date,"%d/%m/%Y")
# filter the data
data_small <- subset(df,
                     Date =="2007-02-01" |
                     Date =="2007-02-02"
)

# merge Date and Time into DateTime column
data_small$DateTime <- paste(data_small$Date, data_small$Time)
data_small$DateTime <- strptime(data_small$DateTime, "%Y-%m-%d %H:%M:%S")
# consider just complete cases
data_small <- data_small[!is.na(data_small$Global_active_power), ]
#********************************************************************
Sys.setlocale(category = "LC_TIME", locale = "C")
# plot the graphics
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(data_small, {
  # figure 1
  plot(DateTime, Global_active_power, type="l",xlab = "",ylab = "Global active power (kilowatts)")
  # figure 2
  plot(DateTime, Voltage, type="l",xlab = "datetime",ylab = "Voltage")
  # figure 3
  plot(DateTime, Sub_metering_1, type="l",xlab = "",ylab = "Energy sub metering")
  lines(DateTime,Sub_metering_2,col = "red")
  lines(DateTime,Sub_metering_3,col = "purple")
  legend("topright", pch="___", col=c("black","red","purple"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  # figure 4
  plot(DateTime, Global_reactive_power, type="l",xlab = "datetime",ylab = "")
})
# close the graphics device
dev.off()

