rankhospital <- function(state, outcome, num="best"){
    
    # ------------ INPUT VALIDATION GALORE
    # ------------ I'm just rewriting best function here
    
    if(num != "best" && num != "worst" && num > 5000){
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
    # remove NA entries
    stateOutcomeValues <- na.omit(stateOutcomeValues)
    
    # sort by Hospital name and then by outcome parameter to handle ties
    stateOutcomeValues <- stateOutcomeValues[order(stateOutcomeValues[outcomeColumn],
                                                   stateOutcomeValues$`outcomeData$Hospital.Name`,
                                                   decreasing = FALSE), ]
    if (num == "best"){
        num <- 1;
    } else if(num == "worst"){
        num <- length(stateOutcomeValues[[outcomeColumn]])
    } else if (num > length(stateOutcomeValues[[outcomeColumn]])){
        return(NA)
    }
    # add Rank column to make it easy to parse for num parameter
    stateOutcomeValues$Rank <- seq_along(stateOutcomeValues[[outcomeColumn]])
    
    rankedHospitalRow <- stateOutcomeValues[which(stateOutcomeValues$Rank == num), ]
    
    # cast the hospital name from the row to a string
    rankedHospitalName <- as.character(rankedHospitalRow$`outcomeData$Hospital.Name`)
    return(rankedHospitalName)
}