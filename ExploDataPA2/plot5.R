library(ggplot2)
library(dplyr)
# I will not make a script that downloads files because that is dangerous
# Assume the data was downloaded and the .zip file extracted in the directory with the script
pm25data <- readRDS("summarySCC_PM25.rds")

# Extract Classification Codes to find Combustion sources that use Coal
sccodes <- readRDS("Source_Classification_Code.rds")

# Extract the emissions for Baltimore city
pm25baltimore <- subset(pm25data, pm25data$fips == "24510")

# Find the SC codes for Vehicle-related sources
vehicleSCC <- sccodes$SCC[grepl("Veh", sccodes$Short.Name)]

# Subset the emission data by vehicle SCC
pm25baltimoreVeh <- pm25baltimore[pm25baltimore$SCC %in% vehicleSCC,]


# Plot the sums of emissions subset grouped by year
png("plot5.png", width = 480, height = 480, units = "px")
ggplot(pm25baltimoreVeh, 
       aes(x=year, y=Emissions)) + 
    stat_summary(fun.y="sum", geom="bar") + 
    labs(x = "Year", 
         y = "Total Emissions (tonnes)", 
         title = "Motor Vehicle Emissions in Baltimore City")
dev.off()