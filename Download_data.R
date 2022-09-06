library(osfr)

# Set a working directory to download data from the OSF repository

setwd('~/MWalsh/Geonutrition')

# Get osf url with the data to be read 
geonuts <-  osf_retrieve_node('https://osf.io/49px5')

# List the files or directories
geo_files <- osf_ls_files(geonuts)

# Take a glimpse of the list of files
geo_files

# There are three files/folders: Grids, Raw data and Clean data folder

# Download clean folder
osf_download(geo_files[3,], conflicts = "overwrite") # this downlaods data and ensures previous data is overwritten with new one. 
