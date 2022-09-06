# Read data
library(tidyverse)
library(prospectr)
library(clhs)
library(rsample)

setwd('~/MWalsh/Geonutrition/Clean data')

list.files()

grain <- read.csv('MWI_grain_CoDa.csv')

str(grain)

with(grain, plot(lat, lon), type = "n")

with(grain, points(lat, lon, col = as.factor(source), pch = 16))

soil <- read.csv('MWI_soil_mir_spectra.csv')

m <- which(!soil$ssid %in% grain$ssid)

n <- which(!grain$ssid %in% soil$ssid)

length(m); length(n)

length(soil$ssid); length(grain$ssid)

grain$ssid[c(n,n-1,n+1)]

# Preprocess soil spectra using 
# Merge grain data with soil spectra

# Get first derivative with Savitzky_Golay

specd <- savitzkyGolay(soil[,-1], m = 1, p =2, w = 23)

# Take SNV

specdsnv <- standardNormalVariate(specd)

spec0 <- as.data.frame(specdsnv)

# Drop the noisy NIR spectral regions to work with MIR part only

mir <- which(as.numeric(gsub('m','',colnames(spec0))) < 4004)

spec0 <- spec0[,mir]

pcs <- prcomp(spec0)

pc <- pcs$x[,1:5]

pc <- as.data.frame(pc)

# Select 10% of the total number in the spectral table
size <- round(0.70 * nrow(spec0)) #or specify size manually

set.seed(2731)

# Two methods for splittng the data to training and testing

# Conditioned latin hypercube sampling
sel_index <- clhs(pc, size = size, progress  = TRUE, iter = 2000, simple = FALSE)

plot(sel_index)

plot(pc[,1:2])

points(pc[sel_index$index_samples,1:2], col = 'red')

k <- sel_index$index_samples # Get the selected for training

spec0 <- spec0 %>%
	mutate(ssid = as.matrix(soil[,1])) %>%
	select(ssid, everything())

	    
spec0[k[1:2],1:8]

# Get the pre
cgrains <- c('ssid','Na', 'Mg', 'P', 'S', 'K','Ca','Cr', 'Mn', 'Fe', 'Co', 'Cu', 'Zn', 'Se', 'Mo', 'I')

grain_soil  <-  left_join(grain[,c('ssid','Mg')], spec0, by = 'ssid')

# Select by rsample
# split train and test data from grain_soil
# set seed 

set.seed(2021)
spl <- initial_split(grain_soil, strata = "Mg")
train <- training(spl)
test <- testing(spl)

train_5fold <- train %>%
  vfold_cv(5)






