
git remote add origin https://github.com/PaulMASNY/MAT_inverse.git
git push -u origin master


k   <- 2000
rho <- .8

matTest <- matrix(rep(rho, k*k), nrow=k)
diag(matTest) <- 1

dim(matTest)
det(matTest)

system.time(solve(matTest))

#-----------------------------------------------------------------------------------------
makeCacheMatrix<- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}

system.time(makeCacheMatrix(matTest))

#-----------------------------------------------------------------------------------------

cacheSolve <- function(x, ...) {
    inv <- x$getinverse()
    if(!is.null(inv)) {
        print("vide le cache")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data)
    x$setinverse(inv)
    inv
}
#-----------------------------------------------------------------------------------------
cacheSolve(matTest)



