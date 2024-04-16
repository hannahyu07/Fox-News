#### Preamble ####
# Purpose: Tests the cleaned US CES 2020 data 
# Author: Hannah
# Date: 12 April 2024
# Contact: realhannah.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-download_data.R and 02-data_cleaning.R first to
# get the cleaned dataset


#### Workspace setup ####
library(tidyverse)
library(readr)


#### Test data ####
# read in cleaned data
cleaned_ces2020 <-  read_parquet("data/analysis_data/cleaned_ces2020.parquet")


# Check column class
class(cleaned_ces2020$voted_for) == "factor"
class(cleaned_ces2020$ABC) == "character"
class(cleaned_ces2020$CBS) == "character"
class(cleaned_ces2020$NBC) == "character"
class(cleaned_ces2020$CNN) == "character"
class(cleaned_ces2020$Fox_News) == "character"
class(cleaned_ces2020$MSNBC) == "character"
class(cleaned_ces2020$PBS) == "character"
class(cleaned_ces2020$Other) == "character"
class(cleaned_ces2020$TV_type) == "character"
class(cleaned_ces2020$Party) == "character"

# Range of data
# Check range of data for voted_for  
correct_voted_for <- 
  c("Trump", "Biden")

if (all(cleaned_ces2020$voted_for |>
        unique() %in% correct_voted_for)) 
{
  "The cleaned voted_for match the expected voted_for"
} else {
  "Not all of the voted_for have been cleaned completely"
}


# Check range of data for tv
correct_tv <-
  c(
    "Local Newscast",
    "National Newscast",
    "Both"
  )

if (all(cleaned_ces2020$TV_type |>
        unique() %in% correct_tv)) 
{
  "The cleaned tv types match the expected tv types"
} else {
  "Not all of the tv types have been cleaned completely"
}


# Check range of data for party
correct_party <-
  c(
    "Democrat",
    "Republican",
    "Independent",
    "Other"
  )

if (all(cleaned_ces2020$Party |>
        unique() %in% correct_party)) 
{
  "The cleaned party match the expected party"
} else {
  "Not all of the party have been cleaned completely"
}


# Check range of data for media 
# Define the correct levels for each variable
correct_levels <- list(
  ABC = c("Yes", "No"),
  CBS = c("Yes", "No"),
  NBC = c("Yes", "No"),
  CNN = c("Yes", "No"),
  Fox_News = c("Yes", "No"),
  MSNBC = c("Yes", "No"),
  PBS = c("Yes", "No"),
  Other = c("Yes", "No")
)

# Iterate over the variables and check if their levels match the correct levels
for (var in names(correct_levels)) {
  if (all(cleaned_ces2020[[var]] %in% correct_levels[[var]])) {
    message(paste("The cleaned", var, "match the expected", var))
  } else {
    message(paste("Not all of the", var, "have been cleaned completely"))
  }
}

