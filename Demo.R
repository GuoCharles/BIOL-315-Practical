# load the file Gideon shared
library(remotes)
myspecies <- c("Danaus plexippus")

library(rgbif)  #for downloading data from gbif
library(scrubr) # for cleaning occurrence records based on spatial coordinates
library(maps)   #for visualising occurrence records on maps based on spatial coordinates
library(geodata)
library(terra)
library(maps)

# GBIF data set
gbif_dt <- occ_data(scientificName = myspecies, hasCoordinate = TRUE, limit = 1000)

# take a look at the downloaded data:
gbif_dt
head(gbif_dt)

# get the columns that matter for mapping and cleaning the occurrence data:
myspecies_dat <- gbif_dt$data[ , c("decimalLongitude", "decimalLatitude", "individualCount", 
                                   "occurrenceStatus", "coordinateUncertaintyInMeters", "institutionCode", "references")]
head(myspecies_dat)

# map the occurrence data:
map("world", xlim = range(myspecies_dat$decimalLongitude), ylim = range(myspecies_dat$decimalLatitude))  
points(myspecies_dat[ , c("decimalLongitude", "decimalLatitude")], pch = 20, cex = 1, col = "red3")
