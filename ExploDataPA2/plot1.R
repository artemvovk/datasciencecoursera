# I will not make a script that downloads files because that is dangerous
# Assume the data was downloaded and the .zip file extracted in the directory with the script
pm25data <- readRDS("summarySCC_PM25.rds")

# Group the Emissions by year and apply sum
pm25sums <- tapply(pm25data$Emissions, factor(pm25data$year), sum)

# Plot the resulting array as a barplot
png("plot1.png", width = 480, height = 480, units = "px")
barplot(pm25sums, xlab = "Year", ylab = "Total Emission (tonnes)", main = "Total Emissions by Year")
dev.off()