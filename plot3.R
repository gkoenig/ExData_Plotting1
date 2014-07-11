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
png("plot3.png", width=480, height=480)
plot(data_small$DateTime,
     data_small$Sub_metering_1, 
     type="l",
     xlab = "",
     ylab = "Energy sub metering"
     )
lines(data_small$DateTime,
      data_small$Sub_metering_2,
      col = "red")
lines(data_small$DateTime,
      data_small$Sub_metering_3,
      col = "purple")
legend("topright", pch="___", col=c("black","red","purple"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# close the graphics device
dev.off()

