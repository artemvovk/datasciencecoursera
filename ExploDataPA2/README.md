## Assignment

* The overall goal of this assignment is to explore the National Emissions Inventory database
and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008.

* You may use any R package you want to support your analysis.

### Questions

* For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
  
  1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
  
I plotted the sums of all emissions by year
  
  2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

I plotted the sums of all emissions in Baltimore City by year

  3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

I plotted the sums of all emissions in Baltimore City by year, separated by type

  4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
  
I plotted the sums of Coal Combustion related emissions by year (separated by year, just for fun - interesting to see why non-point emissions went up for a bit)
  
  5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
  
I plotted the sums of Vehicle related emissions by year in Baltimore City
  
  6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
  
I plotted the data from question 5 against the same data for Los Angeles

### Making and Submitting Plots

* For each plot you should

	1. Construct the plot and save it to a PNG file.
	
	2. Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
	
	3. Upload the PNG file on the Assignment submission page
	
	4. Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.
