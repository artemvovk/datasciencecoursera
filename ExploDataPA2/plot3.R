library(ggplot2)
library(dplyr)
# I will not make a script that downloads files because that is dangerous
# Assume the data was downloaded and the .zip file extracted in the directory with the script
pm25data <- readRDS("summarySCC_PM25.rds")

# Subset the Baltimore data: fips=24510
pm25baltimore <- subset(pm25data, pm25data$fips == "24510")

# Sum and mean of the data by Type and Year
pm25baltimoreSumAvgByTypeYear <- pm25baltimore %>% 
    group_by(year, type) %>% 
    summarise(avg=mean(Emissions), sum=sum(Emissions))

# Graph the sums of each emission type over te years
png("plot3.png", width = 480, height = 480, units = "px")
ggplot() + geom_smooth(data=pm25baltimoreSumAvgByTypeYear, 
                       mapping = aes(x=year, y=sum, col=type)) + labs(x="Year", 
                                                                      y="Total Emissions(tonnes)", 
                                                                      title = "Emission Totals by type for Baltimore City")
dev.off()