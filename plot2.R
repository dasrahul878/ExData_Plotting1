library("data.table")

setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")


dataDF<-data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


dataDF[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


dataDF[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


dataDF<-dataDF[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)


plot(x =dataDF[, dateTime]
     , y = dataDF[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()