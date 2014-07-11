# import the data
df <- read.table(pipe('grep "^[1-2]/2/2007" "./household_power_consumption.txt"'),header=F, sep=';')
colnames(df) <-names(read.table('./household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

# convert Date string to Date object. This reformats the representation to yyyy-mm-dd implicitly !!!!
df$Date <- as.Date(df$Date,"%d/%m/%Y")

# merge Date and Time into DateTime column
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")
# consider just complete cases
df <- df[!is.na(df$Global_active_power), ]
#********************************************************************
Sys.setlocale(category = "LC_TIME", locale = "C")
# plot the graphics
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(df, {
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


