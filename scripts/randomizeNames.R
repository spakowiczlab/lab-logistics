library(stringr)
randomizeNames <- function(x){
  y <- unlist(str_split(x, ","))
  z <- sample(y, size = length(y), replace = F)

  return(z)
}

randomizeNames(c("a, b, c", "d, e, f", "g, h, i"
))

