corr <- function(directory, threshold=0){
    
    ## format the filepaths
    filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
    
    
    ## initialize the aggregate vector for return values
    ## set to numeric to avoid logical type coercion
    returnVal <-vector(mode = "numeric")
    
    
    ## main data collection loop
    ## reads file, extracts a sum of complete.cases
    ## if the sum is > threshold, proceed to extract nitrate and sulfate values
    ## run the cor() on nitrate and sulfate values, then append to aggregate returnVal vector
    for(monitorPath in filenames){
        
        sourceMonitor <- file.path(monitorPath)
        monitorData <- read.csv(sourceMonitor)
        if (sum(complete.cases(monitorData)) > threshold){
            nits <- monitorData$nitrate[complete.cases(monitorData)]
            sulfs <- monitorData$sulfate[complete.cases(monitorData)]
            returnVal <- c(returnVal, cor(nits, sulfs))
        }
    }
    
    return(returnVal)
}