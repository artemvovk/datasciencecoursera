# I will not make a script that downloads files because that is dangerous
# Assume the data was downloaded and the .zip file extracted in the directory with the script
pm25data <- readRDS("summarySCC_PM25.rds")

# Subset the Baltimore data: fips=24510
pm25baltimore <- subset(pm25data, pm25data$fips == "24510")

# Sum the Emission data by year
pm25baltimoreSums <- tapply(pm25baltimore$Emissions, factor(pm25baltimore$year), sum)

png("plot2.png", width = 480, height = 480, units = "px")
barplot(pm25baltimoreSums, xlab = "Year", ylab = "Total Emission (tonnes)", main = "Baltimore City Emission Data")
dev.off()