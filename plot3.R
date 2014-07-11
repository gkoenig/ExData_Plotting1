# import the data
df <- read.table(pipe('grep "^[1-2]/2/2007" "./household_power_consumption.txt"'),header=F, sep=';')
colnames(df) <-names(read.table('./household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
# convert Date string to Date object. This reformats the representation to yyyy-mm-dd implicitly !!!!
df$Date <- as.Date(df$Date,"%d/%m/%Y")

## the following is a simpler but much slower approach to read the data and filter it afterwards
#df <- read.table(file = "./household_power_consumption.txt", 
#                   sep = ";", 
#                   header = TRUE, 
#                   dec = ".",
#                   na.strings = "?"
#                 )
## convert Date string to Date object. This reformats the representation to yyyy-mm-dd implicitly !!!!
#df$Date <- as.Date(df$Date,"%d/%m/%Y")
## filter the data
#df <- subset(df,
#                     Date =="2007-02-01" |
#                     Date =="2007-02-02"
#)

# merge Date and Time into DateTime column
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")
# consider just complete cases
df <- df[!is.na(df$Global_active_power), ]
#********************************************************************
Sys.setlocale(category = "LC_TIME", locale = "C")
# plot the graphics
png("plot3.png", width=480, height=480)
plot(df$DateTime,
     df$Sub_metering_1, 
     type="l",
     xlab = "",
     ylab = "Energy sub metering"
     )
lines(df$DateTime,
      df$Sub_metering_2,
      col = "red")
lines(df$DateTime,
      df$Sub_metering_3,
      col = "purple")
legend("topright", pch="___", col=c("black","red","purple"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# close the graphics device
dev.off()

