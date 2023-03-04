
## LIBRARIES --------------------------------------------------------------
library(terra)
library(here)
library(dplyr)
library(sf)
library(tmap)
library(rgdal)


## DATA DIRECTORY ---------------------------------------------------------
rootdir <- getwd() 
datadir <- path.expand("~/../../capstone/pyforest/data/")

## READ IN DATA -----------------------------------------------------------------

# POLITICAL BOUNDARIES (DEPARTMENTS & DISTRICTS) 
department <- st_read(file.path(datadir, "Political_Boundaries", "departamento.shp")) 
districts <- st_read(file.path(datadir,"Political_Boundaries","distritos.shp"))
dept_disctricts <- st_read(file.path(datadir, "Dpt_Dist", "political_boundaries_dpt_dist.shp"))
dist_sub <- st_read(file.path(datadir, "dist_filadelphia", "dist_filadelphia.shp"))


# FOREST COVER ALL YEARS
# shp <- grep(".shp$", files, value=TRUE)
# cf <- grep("cf", shp, value = TRUE)
# all_fc_filenames <- cf[!grepl("cf_1986", cf, perl = TRUE)]
# all_fc_filenames

fc_2000 <- st_read(file.path(datadir, "Forest", "cf_2000.shp")) 
fc_2005 <- st_read(file.path(datadir, "Forest", "cf_2005.shp")) 
fc_2011 <- st_read(file.path(datadir, "Forest", "cf_2011.shp"))
fc_2013 <- st_read(file.path(datadir, "Forest", "cf_2013.shp"))
fc_2016 <- st_read(file.path(datadir, "Forest", "cf_2016.shp"))
fc_2017 <- st_read(file.path(datadir, "Forest", "cf_2017.shp"))
fc_2018 <- st_read(file.path(datadir, "Forest", "cf_2018.shp"))
fc_2020 <- st_read(file.path(datadir, "Forest", "cf_2020.shp"))



# Wildlife Protection Areas (Reserve Areas, Eco-regions, private, parks)
# r_bios <- st_read(file.path(datadir, "Biosphere_Chaco", "biosfera_chaco.shp"))
# 
# ecoregions <- st_read(file.path(datadir, "Forest Statum", "ecoregiones_ROccidental.shp"))
# 
# private_protected_areas <- st_read(file.path(datadir, "Certificadas", "certificadas.shp"))
# 
# parks <- st_read(file.path(datadir, "National_Park", "ASP_RORI.shp"))

