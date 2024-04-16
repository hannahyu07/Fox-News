#### Preamble ####
# Purpose: Tests the model cofficient
# Author: Hannah Yu
# Date: 12 April 2024
# Contact: realhananh.yu@mail.utoronto.ca
# Pre-requisites: run 04-model.R to get model


test_that("Check summary", {
  summary_political <- summary(political_preferences)
  expect_true("summary.stanreg" %in% class(summary_political))
})