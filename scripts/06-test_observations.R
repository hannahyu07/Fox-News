#### Preamble ####
# Purpose: Tests the model number of observations
# Author: Hannah Yu
# Date: 12 April 2024
# Contact: realhananh.yu@mail.utoronto.ca
# Pre-requisites: run 04-model.R to get model

test_that("Check number of observations is correct", {
  # Check if the number of observations is equal to 2500
  expect_equal(nrow(political_preferences$data), 2500,
               info = "The number of observations is 2500"
  )
})