# Set-up for Botany 2022
## 00_Setup.R
## ML Gaynor


# Install R packages
## Make a list of packages
list_of_packages <- c("dplyr", 
                      "tidyr",
                      "plyr", 
                      "spocc", 
                      "ridigbio",
                      "tibble", 
                      "tidyverse",
                      "rbison",
                      "CoordinateCleaner",
                      "lubridate",
                      "ggplot2",
                      "gtools",
                      "raster", 
                      "sp", 
                      "spatstat", 
                      "spThin", 
                      "fields", 
                      "ggspatial", 
                      "rgdal", 
                      "rangeBuilder", 
                      "sf", 
                      "dismo", 
                      "devtools", 
                      "ENMeval", 
                      "caret", 
                      "usdm", 
                      "stringr", 
                      "factoextra", 
                      "FactoMineR", 
                      "multcompView", 
                      "ggsci",
                      "gridExtra", 
                      "ecospat", 
                      "rJava", 
                      "viridis", 
                      "ENMTools", 
                      "ape", 
                      "RStoolbox", 
                      "hypervolume", 
                      "phytools",
                      "picante", 
                      "leaflet")

## Here we identify which packages are not installed and install these for you
### Please do install all package which need compilation
new.packages <- list_of_packages[!(list_of_packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Dealing with ecospat

## Check version of packages
### Compare to package version used for demo creation
### This data frame has two columns: (1) package (2) version, indicating which
### version of the package was used to develop this workshop
versiondf <- read.csv("data/setup/setup.csv", stringsAsFactors = FALSE)

versiondf_w_updates <- versiondf %>% 
  mutate(updated_version = case_when(
    packages == "dplyr" ~ packageVersion("dplyr"), 
    packages == "tidyr" ~ packageVersion("tidyr"),
    packages == "plyr" ~ packageVersion("plyr"), 
    packages == "spocc" ~ packageVersion("spocc"), 
    packages == "ridigbio" ~ packageVersion("ridigbio"),
    packages == "tibble" ~ packageVersion("tibble"), 
    packages == "tidyverse" ~ packageVersion("tidyverse"),
    packages == "rbison" ~ packageVersion("rbison"),
    packages == "CoordinateCleaner" ~ packageVersion("CoordinateCleaner"),
    packages == "lubridate" ~ packageVersion("lubridate"),
    packages == "ggplot2" ~ packageVersion("ggplot2"),
    packages == "gtools" ~ packageVersion("gtools"),
    packages == "raster" ~ packageVersion("raster"), 
    packages == "sp" ~ packageVersion("sp"), 
    packages == "spatstat" ~ packageVersion("spatstat"), 
    packages == "spThin" ~ packageVersion("spThin"), 
    packages == "fields" ~ packageVersion("fields"), 
    packages == "ggspatial" ~ packageVersion("ggspatial"), 
    packages == "rgdal" ~ packageVersion("rgdal"), 
    packages == "rangeBuilder" ~ packageVersion("rangeBuilder"), 
    packages == "sf" ~ packageVersion("sf"), 
    packages == "dismo" ~ packageVersion("dismo"), 
    packages == "devtools" ~ packageVersion("devtools"), 
    packages == "ENMeval" ~ packageVersion("ENMeval"), 
    packages == "caret" ~ packageVersion("caret"), 
    packages == "usdm" ~ packageVersion("usdm"), 
    packages == "stringr" ~ packageVersion("stringr"), 
    packages == "factoextra" ~ packageVersion("factoextra"), 
    packages == "FactoMineR" ~ packageVersion("FactoMineR"), 
    packages == "multcompView" ~ packageVersion("multcompView"), 
    packages == "ggsci" ~ packageVersion("ggsci"),
    packages == "gridExtra" ~ packageVersion("gridExtra"), 
    packages == "ecospat" ~ packageVersion("ecospat"), 
    packages == "rJava" ~ packageVersion("rJava"), 
    packages == "viridis" ~ packageVersion("viridis"), 
    packages == "ENMTools" ~ packageVersion("ENMTools"), 
    packages == "ape" ~ packageVersion("ape"), 
    packages == "RStoolbox"~ packageVersion("RStoolbox"), 
    packages == "hypervolume" ~ packageVersion("hypervolume"), 
    packages == "phytools" ~ packageVersion("phytools"),
    packages == "picante" ~ packageVersion("picante"), 
    packages == "leaflet" ~ packageVersion("leaflet")
  ))
### Save your version under a new column named "current_version"
versiondf$current_version <- as.character(do.call(c, lapply(list_of_packages, packageVersion)))
### Compare the version the workshop was developed with to your current version
updatelist <- versiondf[which(versiondf$updated_version != versiondf$current_version), ]
### Update packages with old versions
lapply(as.character(updatelist$packages), install.packages, ask = FALSE)

## Make sure all packages load
## Packages that are FALSE did not load
### If anything prints here, then something went wrong and a package did not install
loaded <- lapply(list_of_packages, require, character.only = TRUE)
list_of_packages[loaded == FALSE]

# Install packages not in CRAN
library(devtools)
install_github('johnbaums/rmaxent')
install_github("marlonecobos/kuenm")

## Check and make sure all github packages load
github_packages <- c("rmaxent", "kuenm")
github_loaded <- lapply(github_packages, require, character.only = TRUE)
### If anything prints here, then something went wrong and a package did not install
github_packages[github_loaded == FALSE]

##################################################################################
# Debugging 

# spatstat, spThin, and feilds
## for spatstat, for OS make sure xcode is installed
## in terminal - xcode-select --install
## do not compile from source for spThin or feilds

## ENMTools and/or Java issues - please check the html file for more help!
