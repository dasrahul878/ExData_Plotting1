library("data.table")


dataDF <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


dataDF[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


dataDF[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


dataDF <- dataDF[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))


plot(dataDF[, dateTime], dataDF[, Global_active_power], type="l", xlab="", ylab="Global Active Power")


plot(dataDF[, dateTime],dataDF[, Voltage], type="l", xlab="datetime", ylab="Voltage")


plot(dataDF[, dateTime], dataDF[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(dataDF[, dateTime], dataDF[, Sub_metering_2], col="red")
lines(dataDF[, dateTime], dataDF[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

plot(dataDF[, dateTime], dataDF[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()