library(dplyr)
library(tibble)

# The taxonomy assignment table should be saved in a file labelled like this
taxtab <- readRDS("20XX-XX-XX_taxf.RDS")

# Now we can easily fix NAs using dplyr. I've included gsub() here to prevent long chains of unclassified levels.
# We also make the rownames a column to match "tidy" data standards.

fill.tax <- taxtab %>%
  as.data.frame() %>%
  mutate_all(as.character) %>%
  mutate(Phylum = ifelse(is.na(Phylum),paste0("p_unclassified_",Kingdom),Phylum),
         Class = ifelse(is.na(Class),paste0("c_unclassified_",gsub("p_unclassified_", "", Phylum)),Class),
         Order = ifelse(is.na(Order),paste0("o_unclassified_",gsub("c_unclassified_", "", Class)),Order),
         Family = ifelse(is.na(Family),paste0("f_unclassified_",gsub("o_unclassified_", "", Order)),Family),
         Genus = ifelse(is.na(Genus),paste0("g_unclassified_",gsub("f_unclassified_", "", Family)),Genus)) %>%
  rownames_to_column(var = "Sequence")
