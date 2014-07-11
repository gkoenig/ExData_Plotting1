# read data and filter them on-the-fly
df <- read.table(pipe('grep "^[1-2]/2/2007" "./household_power_consumption.txt"'),header=F, sep=';')
colnames(df) <-names(read.table('./household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
# convert Date string to Date object. This reformats the representation to yyyy-mm-dd implicitly !!!!
df$Date <- as.Date(df$Date,"%d/%m/%Y")
# consider just complete cases
df <- df[!is.na(df$Global_active_power), ]
# plot the histogram containing Global_active_power and its frequency into a PNG file
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, 
     col = "red", 
     xlab = "Global active power (kilowatts)",
     main = "Global active power"
)
dev.off()