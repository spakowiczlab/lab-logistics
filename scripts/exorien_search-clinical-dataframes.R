# Use this to see files columns are located in the standard exorien clinical data.
# This will be missing Spakowicz Lab additions, such as TCGA.code.
# Should produce a 2 column df with the column names and all files that name occurs in.
library(tidyverse)

columnLocations <- function(){
  all.poss <- list.files("/fs/ess/PAS1695/projects/exorien/data/clinical", pattern = ".csv")
  tmp <- lapply(all.poss,
                function(x)
                  read.csv(file.path("/fs/ess/PAS1695/projects/exorien/data/clinical", x)) %>%
                  colnames())
  
  names(tmp) <- all.poss
  tmp2 <- lapply(all.poss, function(x)
    tmp[[x]] %>%
      as.data.frame %>%
      mutate(file = x)) %>%
    bind_rows()
  colnames(tmp2)[1] <- "colname"
  
  tmp3 <- tmp2 %>%
    group_by(colname) %>%
    summarize(files.in = paste(file, collapse = ", "))
  return(tmp3)
}

clindat.locations <- columnLocations()