library(ggplot2)
library(dplyr)
# I will not make a script that downloads files because that is dangerous
# Assume the data was downloaded and the .zip file extracted in the directory with the script
pm25data <- readRDS("summarySCC_PM25.rds")

# Extract Classification Codes to find Combustion sources that use Coal
sccodes <- readRDS("Source_Classification_Code.rds")

# Select Coal and Combustion related SCC numbers by checking the Short Name to match them to Emission data
sccCoal <- sccodes$SCC[grepl("Comb.*Coal", sccodes$Short.Name)]

# Extract Emission entries matching the SCC for Coal and Combustion related sources
pm25coal <- pm25data[pm25data$SCC %in% sccCoal,]

# Sum and mean of the data by Type and Year
pm25coalSums <- pm25coal %>% 
    group_by(year, type) %>% 
    summarise(sum=sum(Emissions))

# Graph the sums of each emission type over te years
png("plot4.png", width = 480, height = 480, units = "px")
ggplot() + geom_smooth(data=pm25coalSums, 
                       mapping = aes(x=year, y=sum, col=type)) + labs(x="Year", 
                                                                      y="Total Emissions(tonnes)", 
                                                                      title = "Coal Combustion-related Emission Totals")
dev.off()