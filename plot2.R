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

#creating the plot
plot(subsetdata$Global_active_power ~ subsetdata$Datetime, type = "l", ylab = "Global Active Power", xlab = "") 

#write the plot to a png doc
dev.copy(png, file="plot2.png", height = 480, width = 480) 
dev.off()


                      
                      