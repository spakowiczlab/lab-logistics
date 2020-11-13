# # How to call up data in your code
## Problem: 
We have multiple people working with the same scripts, and/or the same person working on multiple computers, such that hard coding paths will break. Relative paths within the GitHub repo isn’t possible for really big data files (e.g. sequencing data). 

## Solution:
Adopt the `00-paths.R` and `proj.json` structure developed by Kevin Coomes. 

Scripts should be kept in a project repository, following this example structure:

```
LCMC3/
├── LCMC3.Rproj
├── LCMC3.json
├── README.md
├── .gitignore
├── LICENSE
├── scripts
│   ├── 00-paths.R
│   ├── 01-rewrite.R
│   ├── 02-peek.R
│   ├── 03-cytokines.Rmd
│   ├── 03-cytokines.html
└── figures
    └── fig1.png
```

First edit the path to the `proj.json` file in `00-paths.R`

```
###############################
### Locate the $HOME directory
home <- Sys.getenv("HOME", unset = NA)
if (is.na(home)) stop("Cannot find 'HOME' from environment variable s.")

### Find the JSON path information in the appropriate directory.
jinfo <- file.path(home, "Documents","GitHub", "LCMC3","LCMC3.json") # THIS IS WHERE YOU EDIT
if (!file.exists(jinfo)) stop("Cannot locate file: '", jinfo, "'.\n", sep='')
### parse it
library(rjson)
temp <- fromJSON(file = jinfo)
paths <- temp$paths
detach("package:rjson")
### clean up
rm(home, jinfo, temp)
```

Next, change `proj.json` paths to where you keep your files

```
{
  "paths" : {
      "raw"     : "/Users/danielspakowicz/Documents/lcmc3/raw", # EDIT THIS PATH
      "derived"   : "/Users/danielspakowicz/Documents/lcmc3/derived", # EDIT THIS PATH
  }
}
```

 This has two subdirectories, `raw` and `derived`. 

`raw` includes any files from collaborators, or any unprocessed data 
`derived` is anything produced by one of the scripts. 

We’ll continue to use Box for manuscript word files, powerpoint figure packs, and anything that should be shared with collaborators who don’t have access to the GitHub repo. 

To call up data, within your `.Rmd`,  start with something like this:

```{r}
source("00-paths.R")
cyto <- read.csv(file.path(paths$raw, "cyto-clin.csv"))
```

Note that  `00-paths.R` and `proj.json` should always be in the `.gitignore` so it doesn’t commit to the repository. Each user will have their own set of  `00-paths.R` and `proj.json` files that are not interoperable.

But, whenever anyone runs your `.Rmd`,  the code above should load the data into their environment just like it does on your computer.
