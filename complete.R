complete <- function(directory, id=1:332){
    
    ## format the filepaths
    filePaths <- paste(directory,"/",sprintf("%03d",id),".csv", sep="")
    
    
    ## initialize the sum of complete.cases vector
    sums <-vector()
    
    
    ## main data collection loop
    ## reads file, extracts a sum of complete.cases
    ## appends the sum to the sums vector
    for(monitorPath in filePaths){
        
        sourceMonitor <- file.path(monitorPath)
        monitorData <- read.csv(sourceMonitor)
        sums <- c(sums, sum(complete.cases(monitorData)))
    }
    
    ## make the output data.frame
    returnDF <- data.frame(id, sums)
    colnames(returnDF) <- c("id", "nobs")
    
    return(returnDF)
}