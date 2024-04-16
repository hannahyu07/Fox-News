#### Preamble ####
# Purpose: Simulates the US political support data
# Author: Hannah Yu
# Date: 8 April 2024
# Contact: realhannah.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: --


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# set seed
set.seed(853)

# Define the number of observations
num_obs <- 1000

# Simulate data for US political preferences
simulate_us_vote <- 
  tibble(
    # Simulate random binary variables representing whether individuals watch each media network
    ABC = sample(0:1, size = num_obs, replace = TRUE),
    CBS = sample(0:1, size = num_obs, replace = TRUE),
    NBC = sample(0:1, size = num_obs, replace = TRUE),
    CNN = sample(0:1, size = num_obs, replace = TRUE),
    Fox_News = sample(0:1, size = num_obs, replace = TRUE),
    MSNBC = sample(0:1, size = num_obs, replace = TRUE),
    PBS = sample(0:1, size = num_obs, replace = TRUE),
    Other = sample(0:1, size = num_obs, replace = TRUE),
    # Include Party variable representing political party affiliation
    Party = sample(0:3, size = num_obs, replace = TRUE),
    # Include TV_type variable representing type of TV news watched
    TV_type = sample(0:2, size = num_obs, replace = TRUE),
    # Calculate the probability of supporting Trump based on the sum of variables divided by 13
    support_prob = ((ABC + CBS + NBC + CNN + Fox_News + MSNBC + PBS + Other + Party + TV_type) / 13), 
  ) |>
  mutate(
    # Determine whether an individual supports Trump based on the calculated probability
    support_biden = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    # Convert numeric values of TV_type into descriptive categories
    TV_type  = case_when(
      TV_type  == 0 ~ "Local Newscast",
      TV_type  == 1 ~ "National Newscast",
      TV_type  == 2 ~ "Both"
    ),
    # Convert numeric values of Party into descriptive categories
    Party = case_when(
      Party == 0 ~ "Democrat",
      Party == 1 ~ "Republican",
      Party == 2 ~ "Independent",
      Party == 3 ~ "Other"
    ),
    ABC = if_else(ABC == 0, "No", "Yes"),
    CBS = if_else(CBS == 0, "No", "Yes"),
    NBC = if_else(NBC == 0, "No", "Yes"),
    CNN = if_else(CNN == 0, "No", "Yes"),
    Fox_News = if_else(Fox_News == 0, "No", "Yes"),
    MSNBC = if_else(MSNBC == 0, "No", "Yes"),
    PBS = if_else(PBS == 0, "No", "Yes"),
    Other = if_else(Other == 0, "No", "Yes")
  ) |>
  # Select relevant variables for analysis
  select(support_biden, ABC, CBS, NBC, CNN, Fox_News, MSNBC, PBS, Other, TV_type, Party)



#### Test Simulated data ####
# Test ABC
table(simulate_us_vote$ABC %in% c("Yes", "No"))

# Test CBS
table(simulate_us_vote$CBS %in% c("Yes", "No"))

# Test NBC
table(simulate_us_vote$NBC %in% c("Yes", "No"))

# Test CNN
table(simulate_us_vote$CNN %in% c("Yes", "No"))

# Test Fox_News
table(simulate_us_vote$Fox_News %in% c("Yes", "No"))

# Test MSNBC
table(simulate_us_vote$MSNBC %in% c("Yes", "No"))

# Test PBS
table(simulate_us_vote$PBS %in% c("Yes", "No"))

# Test Other
table(simulate_us_vote$Other %in% c("Yes", "No"))

# Test TV_type
table(simulate_us_vote$TV_type %in% c("Local Newscast", "National Newscast", "Both"))

# Test Party
table(simulate_us_vote$Party %in% c("Democrat", "Republican", "Independent", "Other"))

# Test support_trump
table(simulate_us_vote$support_biden %in% c("yes", "no"))




