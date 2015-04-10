#reading data from the text file
dataset <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"') 

#converting format of Data variable
dataset$Date = as.Date(dataset$Date, format="%d/%m/%Y")

#subsetting and only recording values of the required dates
subsetdata <- subset(dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Converting date time in posix
datetime <- paste(as.Date(subsetdata$Date), subsetdata$Time)
subsetdata$Datetime <- as.POSIXct(datetime)  

#setting the parametres of the graph
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

#plotting the graphs
with(subsetdata, {
plot(Global_active_power ~Datetime, type = "l", ylab = "Global Active Power", xlab = "") 

plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime") 

plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", 
                       xlab = "")
lines(Sub_metering_2 ~ Datetime, col = "red")
lines(Sub_metering_3 ~ Datetime, col = "blue") 
legend("topright", col = c("black", "red", "blue"), lty = 1,bty="n",cex = 0.5,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
plot(Global_reactive_power ~ Datetime,type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})  

#write the plot to a png doc
dev.copy(png, file="plot4.png", height = 480, width = 480) 
dev.off()
