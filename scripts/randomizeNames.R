library(stringr)
randomizeNames <- function(x) {
  y <- unlist(str_split(x, ","))
  z <- sample(y, size = length(y), replace = FALSE)

  return(z)
}

paste_here <- ""
randomizeNames(paste_here)
