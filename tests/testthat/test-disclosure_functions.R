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
  r_data <- sdcshinyapp::Stat_Round(r_sample_data, r_vars, r_base)

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
  testthat::expect_error(sdcshinyapp::Stat_Round(NULL, c("20-24"), 3), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
  testthat::expect_error(sdcshinyapp::Stat_Round(list(), c("20-24"), 3), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
})

testthat::test_that("Invalid var_choice", {
  testthat::expect_error(sdcshinyapp::Stat_Round(r_sample_data, NULL, 3), "Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
  testthat::expect_error(sdcshinyapp::Stat_Round(r_sample_data, c("nonexistent"), 3), "Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
})

testthat::test_that("Invalid round_cond", {
  testthat::expect_error(sdcshinyapp::Stat_Round(r_sample_data, c("20-24"), -10), "Error: 'round_cond' must be a single positive whole integer.")
  testthat::expect_error(sdcshinyapp::Stat_Round(r_sample_data, c("20-24"), 0), "Error: 'round_cond' must be a single positive whole integer.")
  testthat::expect_error(sdcshinyapp::Stat_Round(r_sample_data, c("20-24"), 10.5), "Error: 'round_cond' must be a single positive whole integer.")
})

testthat::test_that("No numeric variables selected", {
  r_vars <- c("line")
  testthat::expect_warning(sdcshinyapp::Stat_Round(r_sample_data, r_vars, 3), "No numeric variables have been selected. The original input data will be returned.")
})

# Primary Suppression Test ----

# Sample data for testing
ps_sample_data <- data.frame(
  `20-24` = c(1, 2, 3, 4, 5),
  `25-29` = c(0, 1, 2, 3, 4),
  `30-34` = c(5, 6, 7, 8, 9),
  `35-39` = c(NA, 2, 3, 4, 5),
  `40-44` = c(1, 2, 3, 4, 5),
  `45-49` = c(0, 0, 0, 0, 0),
  `50-54` = c(1, 2, 3, 4, 5),
  `55-59` = c(1, 2, 3, 4, 5),
  `Total` = c(8, 15, 21, 27, 33),
  check.names = FALSE, stringsAsFactors = FALSE
  )

testthat::test_that("Function handles non-dataframe input", {
  testthat::expect_error(sdcshinyapp::Stat_Primary_Supress(NULL, c("20-24"), "*", 3, TRUE), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
  testthat::expect_error(sdcshinyapp::Stat_Primary_Supress(list(), c("20-24"), "*", 3, TRUE), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
})

testthat::test_that("Function handles non-existent columns", {
  testthat::expect_error(sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("nonexistent"), "*", 3, TRUE), "Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
})

# testthat::test_that("Function handles invalid suppression character", {
#   testthat::expect_error(sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("20-24"), "x", 3, TRUE), "Error: 'char_supp' must be either '*' or 'c'.")
# })

testthat::test_that("Function handles invalid suppression condition", {
  testthat::expect_error(sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("20-24"), "*", -1, TRUE), "Error: 'sup_cond' must be a single positive whole integer.")
})

testthat::test_that("Function handles invalid zero suppression flag", {
  testthat::expect_error(sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("20-24"), "*", 3, "yes"), "Error: 'zero' must be a single logical value.")
})

testthat::test_that("Function suppresses values correctly", {
  result <- sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("20-24", "25-29"), "*", 3, TRUE)
  expected <- ps_sample_data
  expected$`20-24`[1:3] <- "*"
  expected$`25-29`[2:4] <- "*"
  testthat::expect_equal(result, expected)
})

testthat::test_that("Function preserves NA values", {
  result <- sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("35-39"), "*", 3, TRUE)
  testthat::expect_true(is.na(result$`35-39`[1]))
})

testthat::test_that("Function returns original data if no numeric variables are selected", {
  result <- sdcshinyapp::Stat_Primary_Supress(ps_sample_data, c("Total"), "*", 3, TRUE)
  testthat::expect_equal(result, ps_sample_data)
})

# Secondary Suppression Test ----

testthat::test_that("Stat_Secondary_Supress works correctly", {
  # Example dataset
  inp_data <- data.frame(
    Total = c(1, 2, 3, 4, 5, NA),
    `20-24` = c(1, 2, 3, 4, 5, NA),
    `25-29` = c(1, 2, 3, 4, 5, NA),
    `30-34` = c(1, 2, 3, 4, 5, NA),
    `35-39` = c(1, 2, 3, 4, 5, NA),
    `40-44` = c(1, 2, 3, 4, 5, NA),
    `45-49` = c(1, 2, 3, 4, 5, NA),
    `50-54` = c(1, 2, 3, 4, 5, NA),
    `55-59` = c(1, 2, 3, 4, 5, NA),
    check.names = FALSE, stringsAsFactors = FALSE
    )

  # Variables for primary suppression
  ps_vars <- "Total"

  # Variables for secondary suppression
  ss_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59")

  # Suppression character
  s_char <- "*"

  # Suppression condition
  s_cond <- 3

  # Suppress zeros
  z_cond <- TRUE

  # Apply suppression
  s_data <- sdcshinyapp::Stat_Secondary_Supress(inp_data, ps_vars, ss_vars, s_char, s_cond, z_cond)

  # Test primary suppression
  testthat::expect_equal(s_data$Total, c("*", "*", "*", 4, 5, NA))

  # Test secondary suppression
  testthat::expect_equal(s_data$`20-24`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`25-29`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`30-34`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`35-39`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`40-44`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`45-49`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`50-54`, c("*", "*", "*", 4, 5, NA))
  testthat::expect_equal(s_data$`55-59`, c("*", "*", "*", 4, 5, NA))

  # Test suppression character
  testthat::expect_equal(s_data$Total[1], s_char)

  # Test suppression condition
  testthat::expect_equal(s_data$Total[4], "4")

  # Test zero suppression
  testthat::expect_equal(s_data$Total[6], NA_character_)
})

testthat::test_that::testthat::test_that("Stat_Secondary_Supress handles invalid input correctly", {
  # Example dataset
  inp_data <- data.frame(
    Total = c(1, 2, 3, 4, 5, NA),
    `20-24` = c(1, 2, 3, 4, 5, NA),
    `25-29` = c(1, 2, 3, 4, 5, NA),
    `30-34` = c(1, 2, 3, 4, 5, NA),
    `35-39` = c(1, 2, 3, 4, 5, NA),
    `40-44` = c(1, 2, 3, 4, 5, NA),
    `45-49` = c(1, 2, 3, 4, 5, NA),
    `50-54` = c(1, 2, 3, 4, 5, NA),
    `55-59` = c(1, 2, 3, 4, 5, NA),
    check.names = FALSE, stringsAsFactors = FALSE
  )

  # Test missing data
  testthat::expect_error(sdcshinyapp::Stat_Secondary_Supress(NULL, "Total", c("20-24", "25-29"), "*", 3, TRUE), "Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")

  # Test invalid primary variable
  testthat::expect_error(sdcshinyapp::Stat_Secondary_Supress(inp_data, "Invalid", c("20-24", "25-29"), "*", 3, TRUE), "Error: 'pri_var_choice' must be a single character string and must exist in 'orig_data'.")

  # Test invalid secondary variables
  testthat::expect_error(sdcshinyapp::Stat_Secondary_Supress(inp_data, "Total", c("Invalid1", "Invalid2"), "*", 3, TRUE), "Error: 'sec_var_choice' must be a character vector with at least two elements, and all columns must exist in 'orig_data'.")

  # Test invalid suppression character
  # testthat::expect_error(sdcshinyapp::Stat_Secondary_Supress(inp_data, "Total", c("20-24", "25-29"), "x", 3, TRUE), "Error: 'char_supp' must be either '*' or 'c'.")

  # Test invalid suppression condition
  testthat::expect_error(sdcshinyapp::Stat_Secondary_Supress(inp_data, "Total", c("20-24", "25-29"), "*", -1, TRUE), "Error: 'sup_cond' must be a single positive whole integer.")

  # Test invalid zero suppression
  testthat::expect_error(sdcshinyapp::Stat_Secondary_Supress(inp_data, "Total", c("20-24", "25-29"), "*", 3, "TRUE"), "Error: 'zero' must be a single logical value.")
})
