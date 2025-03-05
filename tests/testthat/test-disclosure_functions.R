# Rounding Tests ----

# Sample data for Rounding tests
r_sample_data <- data.frame(
  line = c("Sensitive A", "Sensitive B", "Sensitive C"),
  `20-24` = c(NA, 1, 24),
  `25-29` = c(9, NA, 28),
  `30-34` = c(14, 4, NA),
  `35-39` = c(11, 2, 22),
  `40-44` = c(20, 8, 35),
  `45-49` = c(3, 9, 39),
  `50-54` = c(14, 3, 28),
  `55-59` = c(10, 11, 27),
  `Total` = c(NA, 44, 222), check.names = FALSE, stringsAsFactors = FALSE
)

testthat::test_that("Valid inputs", {
  r_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
  r_base <- 3
  r_data <- Stat_Round(r_sample_data, r_vars, r_base)

  testthat::expect_equal(r_data$`20-24`, c(NA, 0, 24))
  testthat::expect_equal(r_data$`25-29`, c(9, NA, 27))
  testthat::expect_equal(r_data$`30-34`, c(15, 3, NA))
  testthat::expect_equal(r_data$`35-39`, c(12, 3, 21))
  testthat::expect_equal(r_data$`40-44`, c(21, 9, 36))
  testthat::expect_equal(r_data$`45-49`, c(3, 9, 39))
  testthat::expect_equal(r_data$`50-54`, c(15, 3, 27))
  testthat::expect_equal(r_data$`55-59`, c(9, 12, 27))
  testthat::expect_equal(r_data$Total, c(NA, 45, 222))
})

testthat::test_that("Invalid orig_data", {
  testthat::expect_error(Stat_Round(NULL, c("20-24"), 3), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
  testthat::expect_error(Stat_Round(list(), c("20-24"), 3), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
})

testthat::test_that("Invalid var_choice", {
  testthat::expect_error(Stat_Round(r_sample_data, NULL, 3), "Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
  testthat::expect_error(Stat_Round(r_sample_data, c("nonexistent"), 3), "Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
})

testthat::test_that("Invalid round_cond", {
  testthat::expect_error(Stat_Round(r_sample_data, c("20-24"), -10), "Error: 'round_cond' must be a single positive whole integer.")
  testthat::expect_error(Stat_Round(r_sample_data, c("20-24"), 0), "Error: 'round_cond' must be a single positive whole integer.")
  testthat::expect_error(Stat_Round(r_sample_data, c("20-24"), 10.5), "Error: 'round_cond' must be a single positive whole integer.")
})

testthat::test_that("No numeric variables selected", {
  r_vars <- c("line")
  testthat::expect_warning(Stat_Round(r_sample_data, r_vars, 3), "No numeric variables have been selected. The original input data will be returned.")
})
