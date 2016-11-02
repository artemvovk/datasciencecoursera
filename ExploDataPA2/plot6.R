library(ggplot2)
library(dplyr)
# I will not make a script that downloads files because that is dangerous
# Assume the data was downloaded and the .zip file extracted in the directory with the script
pm25data <- readRDS("summarySCC_PM25.rds")

# Extract Classification Codes to find Combustion sources that use Coal
sccodes <- readRDS("Source_Classification_Code.rds")

# Extract Emissions data for Baltimore and Los Angeles
pm25baltimore <- subset(pm25data, pm25data$fips == "24510")
pm25losangeles <- subset(pm25data, pm25data$fips == "06037")

# Subset the SCC that correspond to vehicle emissions
vehicleSCC <- sccodes$SCC[grepl("Veh", sccodes$Short.Name)]

# Subset the Emissions data by Vehicle source classification codes
pm25baltimoreVeh <- pm25baltimore[pm25baltimore$SCC %in% vehicleSCC,]
pm25losangelesVeh <- pm25losangeles[pm25losangeles$SCC %in% vehicleSCC,]


# Plot the total emissions in both locations by year
# Could also plot the averages, but meh
png("plot6.png", width = 480, height = 480, units = "px")
ggplot(data=NULL, 
       aes(x=year, y=Emissions)) + 
    stat_summary(data=pm25losangelesVeh, 
                 fun.y="sum", 
                 geom="smooth", 
                 aes(colour="Los Angeles")) + 
    stat_summary(data=pm25baltimoreVeh, 
                 fun.y="sum", 
                 geom="smooth", 
                 aes(colour="Baltimore")) + 
    labs(x="Year", y="Emission Total (tonnes)", title="Emission Totals for Baltimore and Los Angeles")
dev.off()