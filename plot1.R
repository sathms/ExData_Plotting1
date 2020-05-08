
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

# Make a histogram

hist(df$Global_active_power, xlab = 'Global Active Power (Kilowatts)', main='Global Active Power', col = 'red')

# Print to png file

dev.copy(png,"plot1.png")
dev.off()
