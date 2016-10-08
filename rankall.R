rankall <- function(outcome, num="best"){
    # ------------ INPUT VALIDATION GALORE
    # ------------ I'm just rewriting best function here
    
    if(num != "best" && num != "worst" && num > 5000){
        # IQ check, we only have ~4700 data rows
        stop("Invalid ranking parameter. Try \"best,\" \"worst,\" or a number under 5000")
    }
    # Setting expected outcome input
    validOutcomes <- c("heart attack", "heart failure", "pneumonia")
    # I can change the default for outcome parameter to "heart attack," but meh
    if(length(outcome) > 1){
        stop("Please specify only one outcome.")
    }else if(is.na(outcome)){
        stop("Expecting outcome parameter. Try: \"heart attack,\" \"heart failure,\" \"pneumonia,\"")
    }else if (!(outcome %in% validOutcomes)){
        stop("Invalid outcome request. Try: \"heart attack,\" \"heart failure,\" \"pneumonia,\"")
    }
    
    # NOTE: NA values are represented by "Not Available" string, so gotta convert
    outcomeData <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
    
    # Collecting state names
    stateNames <- names(split(outcomeData, outcomeData$State))
    
    # select appropriate column based on outcome parameter
    outcomeColumn <- switch(outcome, "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                            "heart failure"="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                            "pneumonia"="Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    
    # accumulator data.frame that will be built and returned
    # this process can be optimized, but meh
    rankedHospitalsDF <- data.frame("Hosptal Name"=character(0), "State"=character(0), stringsAsFactors = FALSE)
    
    for (state in stateNames){
        # extract columns for Hospital Name and Outcome
        # then split it based on State levels
        # then extract the rows that correspond to the state parameter
        # ALL IN ONE LINE! THAT'S RIGHT!
        stateOutcomeValues <- split(cbind(outcomeData$Hospital.Name, 
                                          outcomeData[outcomeColumn]),
                                    outcomeData$State)[[state]]
        # is this what you call tidying data?
        # remove NA entries
        stateOutcomeValues <- na.omit(stateOutcomeValues)
        
        # sort by Hospital name and then by outcome parameter to handle ties
        stateOutcomeValues <- stateOutcomeValues[order(stateOutcomeValues[outcomeColumn],
                                                       stateOutcomeValues$`outcomeData$Hospital.Name`,
                                                       decreasing = FALSE), ]
        
        # determine if num parameter applies to this state's subset
        # new numS variable will be used for rank search
        numS <- num
        if (num == "best"){
            numS <- 1;
        } else if(num == "worst"){
            numS <- length(stateOutcomeValues[[outcomeColumn]])
        } else if (num > length(stateOutcomeValues[[outcomeColumn]])){
            # return NA if there is not enough hospitals with data in the state
            rankedHospitalsDF <- rbind(rankedHospitalsDF, data.frame("Hospital Name"=NA, "State"=state))
            next
        }
        # add Rank column to make it easy to parse for num parameter
        stateOutcomeValues$Rank <- seq_along(stateOutcomeValues[[outcomeColumn]])
        
        # just making sure that column names will align with accumulator matrix
        stateOutcomeValues$State <- state
        
        # find the row with the appropriate rank
        rankedHospitalRow <- stateOutcomeValues[which(stateOutcomeValues$Rank == numS), ]
        
        # append the accumulator data.frame with the properly formatted hospital name and state
        rankedHospital <- as.character(rankedHospitalRow$`outcomeData$Hospital.Name`)
        rankedHospitalsDF <- rbind(rankedHospitalsDF, data.frame("Hospital Name"=rankedHospital, 
                                                                 "State"=state))
    }
    
    # Ordering the data.frame by state just because
    rankedHospitalsDF <- rankedHospitalsDF[order(rankedHospitalsDF["State"]), ]
    
    #WOOOHOO!
    return(rankedHospitalsDF)
}