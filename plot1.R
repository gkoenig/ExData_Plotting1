# Loading the data
# When loading the dataset into R, please consider the following:
# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
# Note that in this dataset missing values are coded as ?.

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

# consider just complete cases
data_small <- data_small[!is.na(data_small$Global_active_power), ]
# plot the histogram containing Global_active_power and its frequency into a PNG file
png("plot1.png", width=480, height=480)
hist(data_small$Global_active_power, 
     col = "red", 
     xlab = "Global active power (kilowatts)",
     main = "Global active power"
)
dev.off()