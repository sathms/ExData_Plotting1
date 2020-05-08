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

plot(df$Sub_metering_1, type="l", ylab="Energy Sub Metering", axes=FALSE)
lines(df$Sub_metering_2, col="red")
lines(df$Sub_metering_3, col="blue")
axis(1, at = c(0,1431,2870),labels = c("Thu","Fri","Sat"))
axis(2,at=c(0,10,20,30))
box(lty = 1, col = 'black')

# Add a legend

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = 1,
       bty = "0", 
       pt.cex = 0.8, 
       cex = 0.8, 
       text.col = "black", 
       horiz = F , 
       inset = c(0.00, 0.00))

# Print to png file

dev.copy(png,"plot3.png")
dev.off()
