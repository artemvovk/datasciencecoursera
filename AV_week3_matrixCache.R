## A function to have a matrix be able to chache its inverse
# inv is set to NULL until called
makeCacheMatrix <- function(x = matrix()){
    inv <- NULL
    # function to make a matrix and set its value
    # sets inverse to NULL until calculated
    make <- function(y){
        x <<- y
        inv <<- NULL
    }
    # getter method
    get <- function() x
    
    # inverstion getter and setter methods
    # will NOT calculate
    makeinv <- function(inverse) inv <<- inverse
    getinv <- function() inv
    list(make = make, get = get, makeinv = makeinv, getinv = getinv)
}

## Return a matrix that is the inverse of 'x'
cacheSolve <- function(x, ...) {
    # check if inverse is stored already
    # if not, calculate and store it
    tempinv <- x$getinv()
    if (is.null(tempinv)){
        tempdata <- x$get()
        tempinv <- solve(tempdata)
        x$makeinv(tempinv)
        
    }
    return(tempinv)
}
