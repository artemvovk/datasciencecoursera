pollutantmean <- function(directory, pollutant, id=1:332){
    
    ## format the filepaths
    filePaths <- paste(directory,"/",sprintf("%03d",id),".csv", sep="")
    
    ## collect all pollutant data here
    totalPollutant <- vector(mode = "numeric")
    
    
    ## main data collection loop
    ## reads file, extracts pollutant column and removes NA values
    ## appends the remaining values to totalPollutant vector
    for(monitorPath in filePaths){
        
        sourceMonitor <- file.path(monitorPath)
        monitorData <- read.csv(sourceMonitor)
        pollutantData = monitorData[[pollutant]]
        totalPollutant <- c(totalPollutant, pollutantData[!is.na(pollutantData)])
        
    }
    
    ## put the result value in a variable for easier debugging
    ## double check to remove NAs, not really necessary
    returnMean <- mean(totalPollutant, na.rm=TRUE)
    return(returnMean)
}