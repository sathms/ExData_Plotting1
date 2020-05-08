# Get the file

filename <- 'hhld_power_consumption.zip'
if(!file.exists(filename)){
  fileurl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(fileurl,filename)
  unzip(filename, exdir = getwd())
}

# Prepare the data

full_data <- read.table('./household_power_consumption.txt',na.strings = '?',header = TRUE,sep = ';')
dates = as.Date(c('01/02/2007','02/02/2007'), '%d/%m/%Y')
df <- full_data[as.Date(full_data$Date, '%d/%m/%Y') %in% dates,]
rm(full_data)
which(df$Time=='23:49:00')

# Make a basic graph

dev.off()

x11(width=4, height=6)

par(mfrow=c(2,2))

plot(df$Global_active_power,type="l", ylab="Global Active Power",xlab="",axes=FALSE)
axis(1, at = c(0,1431,2870),labels = c("Thu","Fri","Sat"))
axis(2,at=c(0,2,4,6))
box(lty = 1, col = 'black')

plot(df$Voltage,type="l", ylab="Voltage",xlab="datetime", axes=FALSE)
axis(1, at = c(0,1431,2870),labels = c("Thu","Fri","Sat"))
axis(2, at= c(234,238,242,246))
box(lty = 1, col = 'black')

plot(df$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="", axes=FALSE)
lines(df$Sub_metering_2, col="red")
lines(df$Sub_metering_3, col="blue")
axis(1, at = c(0,1431,2870),labels = c("Thu","Fri","Sat"))
axis(2,at=c(0,10,20,30))
box(lty = 1, col = 'black')

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = 1,
       cex = 0.4,
       text.col = "black", 
       horiz = F , 
       inset = c(0.00, 0.00))

#par(cex = 1)
plot(df$Global_reactive_power,type="l", ylab="Global Active Power",xlab="datetime",axes=FALSE)
axis(1, at = c(0,1431,2870),labels = c("Thu","Fri","Sat"))
axis(2,at=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6))
box(lty = 1, col = 'black')

dev.copy(png,"plot4.png")
dev.off()

