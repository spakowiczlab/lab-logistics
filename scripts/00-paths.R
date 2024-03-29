###############################
### Locate the $HOME directory
# home <- Sys.getenv(x = "R_USER", unset = NA)
# if (is.na(home)) stop("Cannot find 'HOME' from environment variable s.")

### Find the JSON path information in the appropriate directory.
jinfo <- file.path("/Users", "spakowicz.1", "Documents", "GitHub", "aspire", "lab-logistics","lab-logistics.json")
if (!file.exists(jinfo)) stop("Cannot locate file: '", jinfo, "'.\n", sep='')
## parse it
library(rjson)
temp <- fromJSON(file = jinfo)
paths <- temp$paths
detach("package:rjson")
### clean up
rm(home, jinfo, temp)
