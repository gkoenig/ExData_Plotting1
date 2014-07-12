# import the data
df <- read.table(pipe('grep "^[1-2]/2/2007" "./household_power_consumption.txt"'),
                 header=F, 
                 sep=';',
                 dec = ".",
                 na.strings = "?")
colnames(df) <-names(read.table('./household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

# convert Date string to Date object. This reformats the representation to yyyy-mm-dd implicitly !!!!
df$Date <- as.Date(df$Date,"%d/%m/%Y")

# merge Date and Time into DateTime column
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")
# consider just complete cases
cc <- complete.cases(df)
df <- df[cc, ]
#********************************************************************
Sys.setlocale(category = "LC_TIME", locale = "C")
# plot the histogram containing Global_active_power and its frequency into a PNG file
png("plot2.png", width=480, height=480)
plot(df$DateTime,
     df$Global_active_power, 
     type="l",
     xlab = "",
     ylab = "Global active power (kilowatts)"
     )
dev.off()