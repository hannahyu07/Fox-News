#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Hannah Yu
# Date: 8 April 2024 
# Contact: realhannah.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R
# Any other information needed?  dropped none

#### Workspace setup ####
library(tidyverse)
library(dplyr)


# Read the data and assign it to raw_ces2020
raw_ces2020 <- read_parquet("data/raw_data/raw_ces2020.parquet", col_types = cols(
  "votereg" = col_integer(),
  "CC20_410" = col_integer(),
  "cc20_300a" = col_integer(),
  "cc20_300c" = col_integer(),
  "cc20_300b_1" = col_integer(),
  "cc20_300b_2" = col_integer(),
  "cc20_300b_3" = col_integer(),
  "cc20_300b_4" = col_integer(),
  "cc20_300b_5" = col_integer(),
  "cc20_300b_6" = col_integer(),
  "cc20_300b_7" = col_integer(),
  "cc20_300b_8" = col_integer(),
  "CC20_433a" = col_integer()
))




# only interested in:
# respondents who are registered to vote: votereg = 1
# vote for Trump or Biden: CC20_410 = 1 Biden, 2 Trump
# no NA in independent variables

cleaned_ces2020 <- 
  raw_ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  filter(!is.na(CC20_433a) &
           !is.na(CC20_300a) &
           !is.na(CC20_300b_1) &
           !is.na(CC20_300b_2) &
           !is.na(CC20_300b_3) &
           !is.na(CC20_300b_4) &
           !is.na(CC20_300b_5) &
           !is.na(CC20_300b_6) &
           !is.na(CC20_300b_7) &
           !is.na(CC20_300b_8)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    ABC = if_else(CC20_300b_1 == 1, "Yes", "No"),
    CBS = if_else(CC20_300b_2 == 1, "Yes", "No"),
    NBC = if_else(CC20_300b_3 == 1, "Yes", "No"),
    CNN = if_else(CC20_300b_4 == 1, "Yes", "No"),
    Fox_News = if_else(CC20_300b_5 == 1, "Yes", "No"),
    MSNBC = if_else(CC20_300b_6 == 1, "Yes", "No"),
    PBS = if_else(CC20_300b_7 == 1, "Yes", "No"),
    Other = if_else(CC20_300b_8 == 1, "Yes", "No"),
    TV_type = case_when(
      CC20_300a == 1 ~ "Local Newscast",
      CC20_300a == 2 ~ "National Newscast",
      CC20_300a == 3 ~ "Both",
    ),
    Party = case_when(
      CC20_433a == 1 ~ "Democrat",
      CC20_433a == 2 ~ "Republican",
      CC20_433a == 3 ~ "Independent",
      CC20_433a == 4 ~ "Other",
  )) |>
  select(voted_for, ABC, CBS, NBC, CNN, Fox_News, MSNBC, PBS, Other, TV_type, Party)



#### Save data ####
write_parquet(cleaned_ces2020, "data/analysis_data/cleaned_ces2020.parquet")

head2020 <- head(cleaned_ces2020, 100)

write_csv(head2020, "data/analysis_data/head2020.csv")


row_count <- nrow(cleaned_ces2020)
print(row_count)





