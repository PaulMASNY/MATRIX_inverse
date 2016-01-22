
<!-- R Commander Markdown Template -->




### Caching the inverse of a Matrix


> Regardless to the growing power of cheap computers, some of computation results could be cached and re-used in further functions, saving substantially some machine resources. This magic is achieved through R environment encapsulation aptitudes.
The technique below uses both R lazy evaluation and different assignment operators.

** Keywords : *R Matrix inverse* -- *R function computation* -- *R Scoping and caching* -- *R Programming Coursera*

#### The problem

Write the following functions:

- makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.
- cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cacheSolve() should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the solve function in R. For example, if X is a square invertible matrix, then solve(X) returns its inverse. For this assignment, assume that the matrix supplied is always invertible.

#### Solution approach



According to the R help : *The operators <<- and ->> are normally only used in functions, and cause a search to made through parent environments for an existing definition of the variable being assigned.*
According to the Hadley Wickham's book, R has four special environments :
- The **globalenv()**,or global environment,is the interactive workspace.This is the environment in which you normally work.The parent of
the global environment is the last package that you attached with library() or require().
- The **baseenv()**,or base environment,is the environment of the base package.Its parent is the empty environment.
- The **emptyenv()**,or empty environment,is the ultimate ancestor of all environments,and the only environment without a parent.
- The **environment()**is the current environment.

The regular assignment arrow, <- ,always creates a variable in the current environment.The deep assignment arrow, <<- ,never creates avariable in the current environment,bu tinsteadmodiﬁesanexistingvariable
foundbywalkinguptheparentenvironments.Youcanalsododeep bindingwithassign():name <<- valueisequivalenttoassign("name", value,inherits = TRUE).

If<<-doesnâtï¬ndanexistingvariable,itwillcreateoneintheglobal environment.Thisisusuallyundesirable,becauseglobalvariablesin-
troducenon-obviousdependenciesbetweenfunctions.<<-ismostoften usedinconjunctionwit


##### Test Matrix

This matrix is generated using a set of real numbers, more prone to a heavier processor use than their integer counterparts.
Also, it should be mentioned that a successful generation of non-singular matrices is a quite separate mathematical problem !
Here I have helped myself by injecting a set of 1 in the diagonal. As a result, we have a truly invertible 2000x2000 matrix down here :  


```r
iv   <- 2000
fill <- .3

matTest <- matrix(rep(fill, k*k), nrow=k)
diag(matTest) <- 1

dim(matTest)
det(matTest)

# Let's test the inversion execution time :
system.time(solve(matTest))
```

##### The Matrix inversing function



```r
makeCacheMatrix<- function(x = matrix()) {
    inv <- c()
    set <- function(y) {
        x <<- y
        inv <<- c()
    }
    get <- function() x
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}

makeCacheMatrix(matTest)
```


##### Matrix caching function


```r
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

cacheSolve(matTest)
```

As we can consider by looking on the **Test Matrix** section above, the caching technique improves computation on our object by nearly 29 seconds. A non-negligible amount of time!
 
#### Conclusion

Caching and lazy evaluation has a hereby proven influence on computational speed. Therefore, those techniques are not alone to achieve improvements in the field. 
I suggest to try also a somewhat different, but very effective combination of multicore computing ( eg:**DoMc** and **Paralel**) and highly optimized R object manipulation libraries (eg: **data.table**) to bring some additional time and ressource spares. Every R object can not benefit from caching, very often due to the machine RAM limitations.

#### Sources

*Hadley Wickham : Advanced R , CRC Press 2015

**Contact**

- [Paul MASNY] paul.masny@securesafety.org













