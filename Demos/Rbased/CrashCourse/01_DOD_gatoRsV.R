# 01-DOD-gatoRsV

# Same concept as Download Occurrence Data, but utilizing Natalie's and Shelly's gatoRs package
# Some of their functions...
source("functions/gators.R")

# The libraries necessary...
library(gatoRs)
library(leaflet)
library(tidyverse)

# Use gatoRs to pull in the data
galaxdf <- gators_download(synonyms.list = c("Galax urceolata", "Galax aphylla"), 
                           write.file = FALSE,
                           gbif.match = "fuzzy",
                           idigbio.filter = TRUE)

# Pull in the raster data to figure out resolution...
bio1 <- raster("data/climate_processing/bioclim/bio_1.tif")


# clean_data <- full_clean(galaxdf,
#                          synonyms.list = c("Galax urceolata", "Galax aphylla"), 
#                          digits = 2,
#                          basis.list = c("Preserved Specimen","Physical specimen"), 
#                          accepted.name = "Galax urceolata", 
#                          raster = bio1[[1]] # Adding this for the resolution level at which the occurrence records need to be cleaned
#                          )

galaxdf <- taxa_clean(df = galaxdf,  
                      synonyms.list = c("Galax urceolata", "Galax aphylla"), 
                      taxa.filter = "fuzzy", 
                      accepted.name = "Galax urceolata")

galaxdf <- basis_clean(galaxdf, basis.list = c("Preserved Specimen","Physical specimen"))


galaxdf2 <- remove_duplicates(galaxdf)

test_df <- galaxdf %>% 
  filter(!is.na(longitude)) %>% 
  filter(!is.na(latitude))


sample <- one_point_per_pixel(test_df, 
                               resolution = 0.5, # for 30 arc sec raster layers
                               precision = TRUE, 
                               digits = 2) 

sample2 <- one_point_per_pixel(test_df, 
                               raster = bio1,
                               precision = TRUE, 
                               digits = 2)

class(bio1)

one_point_per_pixel2 <- function(df, raster = NULL, resolution = 0.5, precision = TRUE, digits = 2,
                                longitude = "longitude", latitude = "latitude"){
  
  df <- basic_locality_clean(df, latitude = "latitude", longitude = "longitude", remove.zero = FALSE,
                             precision = precision, digits = digits, remove.skewed = FALSE)
  
  if(is.null(raster) == TRUE){
    if(resolution == 0.5){
      rasterResolution  <- 0.008333333
    }else if(resolution == 2.5){
      rasterResolution  <- 0.04166667
    }else if(resolution == 5){
      rasterResolution  <- 0.08333333
    }else if(resolution == 10){
      rasterResolution  <- 0.1666667
    }
  } else{
    rasterResolution  <- max(raster::res(raster))
  }
  
  while(min(spatstat.geom::nndist(df[, c(longitude,latitude)])) < rasterResolution){
    nnD <- spatstat.geom::nndist(df[,c(longitude,latitude)])
    df <- df[-(which(min(nnD) == nnD) [1]), ]
  }
  
  return(df)
}


test_fxn <- function(df, raster = NULL, longitude = "longitude", latitude = "latitude"){
  if(is.null(raster) == TRUE){
    print("YES")
  }
  else {
    rasterResolution  <- max(raster::res(raster))
      min(spatstat.geom::nndist(df[, c(longitude,latitude)])) < rasterResolution
      nnD <- spatstat.geom::nndist(df[,c(longitude,latitude)])
      df <- df[-(which(min(nnD) == nnD) [1]), ]
    print(df)
  }
}

test_fxn(test_df, raster = bio1)


rasterResolution <- max(raster::res(bio1))
                    
while(min(spatstat.geom::nndist(test_df[, c(longitude,latitude)])) < rasterResolution){
  nnD <- spatstat.geom::nndist(test_df[,c("longitude","latitude")])
  test_df <- test_df[-(which(min(nnD) == nnD) [1]), ] }


name <- rep("test", 10)
number <- as.numeric(1:10)

dataframe <- data.frame(name, number)

dataframe[,c("name","number")]
