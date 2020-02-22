library("data.table")

setwd("c:/Desktop/coursera")


dataDF <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


dataDF[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


dataDF[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]


dataDF <- dataDF[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)


hist(dataDF[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()