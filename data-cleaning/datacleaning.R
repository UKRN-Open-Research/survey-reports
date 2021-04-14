#==============================================================================================
# DATA CLEANING TO PREPARE FOR DATA DEPOSITORY UPLOAD
#==============================================================================================

# Aims:
# * Read in raw data
# * Remove columns not required for data deposit

# --- SET UP ----------------------------------------------------------------------------------

library(tidyverse)                      # Tidyverse packages
source("code/functions/function_read_survey.R")  # Read in and format survey data

# --- READ IN RAW DATA ------------------------------------------------------------------------
# Minimal data cleaning is performed to replace column names with more readable column names.
# Unit, MRC_Taxonomy, and Discipline are also added.


# Clean column text
col_order <- read_csv("data-cleaning/data-helpers/colOrder.csv")
# MRC taxonomy
mrc_group <- read_csv("data-cleaning/data-helpers/mrcTaxonomy.csv")

# Read in survey data
dat_mrc <- read_survey("data-cleaning/data-raw", "MRC") # MRC-funded institutions (+ 1 Bristol that is reassigned to UoB)
dat_uob <- read_survey("data-cleaning/data-raw", "UoB") # University of Bristol
dat_bab <- read_survey("data-cleaning/data-raw", "Babraham") # Babraham Institute
# Bind into one dataframe
dat <- rbind(dat_mrc, dat_uob, dat_bab)

# Clear environment
rm(col_order, dat_bab, dat_mrc, dat_uob, mrc_group)

# --- REMOVE NOT REQUIRED COLUMNS -------------------------------------------------------------

dat <- select(dat, -Progress, -Status, -Finished, -ResponseId, -DistributionChannel, -UserLanguage)

# --- WRITE DATA TO CSV -----------------------------------------------------------------------

write.csv(dat, "data/survey_data.csv", row.names = F)
