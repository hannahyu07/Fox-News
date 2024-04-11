#### Preamble ####
# Purpose: Downloads and saves the data from dataverse
# Author: Hannah Yu
# Date: 8 April 2024 
# Contact: realhannah.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(dataverse)
#### Download data ####
raw_ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) 




raw_ces2020 <-
  raw_ces2020 |>
  select(votereg, CC20_410, CC20_300a, CC20_300c, CC20_300b_1, CC20_300b_2, 
         CC20_300b_3, CC20_300b_4, CC20_300b_5, CC20_300b_6, CC20_300b_7, 
         CC20_300b_8, CC20_433a)


#### Save data in Parquet Format####
write_parquet(raw_ces2020, "data/raw_data/raw_ces2020.parquet")
              

         
