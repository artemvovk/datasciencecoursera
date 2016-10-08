best <- function(state = NA, outcome=NA){
    
    # ------------ INPUT VALIDATION GALORE
    
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
    
    # Checking state parameter now
    if(is.na(state)){
        stop("Expecting state name.")
    }
    
    # In order to know if the state parameter is valid, 
    # I need to know which states are included in the data
    # NOTE: NA values are represented by "Not Available" string, so gotta convert
    outcomeData <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
    
    # Collecting state names and valid outcome names
    validStateNames <- names(split(outcomeData, outcomeData$State))
    
    # checking arguments
    # I can, technically, do this before loading the whole file,
    # I do not know which states are included
    # and I do assume which outcomes are included
    if(!(state %in% validStateNames)){
        stop("Invalid state name.")
    }
    
    # select appropriate column based on outcome parameter
    outcomeColumn <- switch(outcome, "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", 
                            "heart failure"="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", 
                            "pneumonia"="Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    
    # extract columns for Hospital Name and Outcome
    # then split it based on State levels
    # then extract the rows that correspond to the state parameter
    # ALL IN ONE LINE! THAT'S RIGHT!
    stateOutcomeValues <- split(cbind(outcomeData$Hospital.Name, 
                                      outcomeData[outcomeColumn]),
                                outcomeData$State)[[state]]
    
    # is this what you call tidying data?
    # remove NA entries and sort by Hospital name
    stateOutcomeValues <- na.omit(stateOutcomeValues)
    stateOutcomeValues <- stateOutcomeValues[order(stateOutcomeValues$`outcomeData$Hospital.Name`), ]
    
    # extract the row with the minimum value in the outcome column
    # the data.frame is sorted alphabetically, so the first min value 
    # will be already in alphabetical order in case of tie
    minHospitalRow <- stateOutcomeValues[which.min(stateOutcomeValues[[outcomeColumn]]), ]
    
    
    # cast the hospital name from the row to a string
    minHospitalName <- as.character(minHospitalRow$`outcomeData$Hospital.Name`)
    
    # BOOM! DONE
    return(minHospitalName)
}