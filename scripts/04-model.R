#### Preamble ####
# Purpose: Models
# Author: Hannah Yu
# Date: 8 April 2024 
# Contact: realhannah.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R, 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(testthat)
library(arrow)
#### Read data ####
analysis_data1 <- read_parquet("data/analysis_data/cleaned_ces2020.parquet")


# Convert variables to factors
analysis_data1$ABC <- factor(analysis_data1$ABC)
analysis_data1$CBS <- factor(analysis_data1$CBS)
analysis_data1$NBC <- factor(analysis_data1$NBC)
analysis_data1$CNN <- factor(analysis_data1$CNN)
analysis_data1$Fox_News <- factor(analysis_data1$Fox_News)
analysis_data1$MSNBC <- factor(analysis_data1$MSNBC)
analysis_data1$PBS <- factor(analysis_data1$PBS)
analysis_data1$Other <- factor(analysis_data1$Other)
analysis_data1$TV_type <- factor(analysis_data1$TV_type)
#analysis_data1$Newspaper_type <- factor(analysis_data1$Newspaper_type)
analysis_data1$Party <- factor(analysis_data1$Party)


# Create voted_for variable in binary form
analysis_data1$voted_for_binary <- ifelse(analysis_data1$voted_for == "Biden", 1, 0)

# Model  for n = 2000
set.seed(853)

ces2020_reduced <- 
  analysis_data1 |> 
  slice_sample(n = 2500)
print(unique(ces2020_reduced$TV_type))

write.csv(ces2020_reduced, file = "reduced_ces2020.csv")

political_preferences <-
  stan_glm(
    voted_for_binary ~ ABC + CBS + NBC + CNN + Fox_News + MSNBC + PBS + Other + 
      TV_type + Party, 
    data = ces2020_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  political_preferences,
  file = "models/political_preferences.rds"
)


#test_file("scripts/05-test_class.R")
#test_file("scripts/06-test_observations.R")
#test_file("scripts/07-test_coefficients.R")



# Print unique values of tv_news24 and newspaper24 in the sliced sample
print(unique(ces2020_reduced$TV_type))
print(unique(ces2020_reduced$Newspaper_type))
print(unique(analysis_data1$TV_type))





