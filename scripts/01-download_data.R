#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


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
  select(votereg, CC20_410, CC20_300_1, CC20_300_2, CC20_300_3, CC20_300_4, CC20_300_5, 
         CC20_300a, CC20_300c, CC20_300b_1, CC20_300b_2, CC20_300b_3, CC20_300b_4, 
         CC20_300b_5, CC20_300b_6, CC20_300b_7, CC20_300b_8)

#### Save data in Parquet Format####

#write_csv(the_raw_data, "inputs/data/raw_data.csv") 
write_parquet(raw_ces2020, "data/raw_data/raw_ces2020.parquet")
              

         
