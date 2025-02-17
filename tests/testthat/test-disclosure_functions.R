# Rounding Tests ----

test_that("Rows and Columns of output remain the same", {

  inp_data <- dummy_wide
  r_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
  r_base <- 3
  r_data <- Stat_Round(inp_data, r_vars, r_base)

  expect_equal(nrow(inp_data), nrow(r_data))
  expect_equal(ncol(inp_data), ncol(r_data))

})

test_that("No changes to data if no numeric variables are selected", {

  inp_data <- dummy_wide
  r_vars <- c("line")
  r_base <- 3
  r_data <- Stat_Round(inp_data, r_vars, r_base)

  expect_equal(inp_data, r_data)

})

test_that("No changes to data if no variables are selected", {

  inp_data <- dummy_wide
  r_vars <- c()
  r_base <- 3
  r_data <- Stat_Round(inp_data, r_vars, r_base)

  expect_equal(inp_data, r_data)

})

test_that("Selected variable values are rounded to the chosen base", {

  inp_data <- dummy_wide
  r_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
  r_base <- 3
  r_data <- Stat_Round(inp_data, r_vars, r_base)

  expect_equal(r_data,
               data.frame(
                 line = c("Sensitive A", "Sensitive B", "Sensitive C"),
                 `20-24` = c(6, 0, 24),
                 `25-29` = c(9, 6, 27),
                 `30-34` = c(15, 3, 18),
                 `35-39` = c(12, 3, 21),
                 `40-44` = c(21, 9, 36),
                 `45-49` = c(3, 9, 39),
                 `50-54` = c(15, 3, 27),
                 `55-59` = c(9, 12, 27),
                 `Total` = c(87, 45, 222), check.names = FALSE, stringsAsFactors = FALSE
               ))

})

# Swapping Tests ----

test_that("Rows and Columns of output remain the same", {

  inp_data <- dummy_wide
  s_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
  s_cond <- 3
  s_data <- Stat_Swap(inp_data, s_vars, s_cond)

  expect_equal(nrow(inp_data), nrow(s_data))
  expect_equal(ncol(inp_data), ncol(s_data))

})

test_that("No changes to data if no numeric variables are selected", {

  inp_data <- dummy_wide
  s_vars <- c("line")
  s_cond <- 3
  s_data <- Stat_Swap(inp_data, s_vars, s_cond)


  expect_equal(inp_data, s_data)

})

test_that("No changes to data if no variables are selected", {

  inp_data <- dummy_wide
  s_vars <- c()
  s_cond <- 3
  s_data <- Stat_Swap(inp_data, s_vars, s_cond)

  expect_equal(inp_data, s_data)

})

# Primary Suppression Tests ----

test_that("Rows and Columns of output remain the same", {

  inp_data <- dummy_wide
  ps_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
  ps_char <- "*"
  ps_cond <- 3
  z_cond <- TRUE

  ps_data <- Stat_Primary_Supress(inp_data, ps_vars, ps_char, ps_cond, z_cond)

  expect_equal(nrow(inp_data), nrow(ps_data))
  expect_equal(ncol(inp_data), ncol(ps_data))

})

test_that("No changes to data if no numeric variables are selected", {

  inp_data <- dummy_wide
  ps_vars <- c("line")
  ps_char <- "*"
  ps_cond <- 3
  z_cond <- TRUE

  ps_data <- Stat_Primary_Supress(inp_data, ps_vars, ps_char, ps_cond, z_cond)


  expect_equal(inp_data, ps_data)

})

test_that("No changes to data if no variables are selected", {

  inp_data <- dummy_wide
  ps_vars <- c()
  ps_char <- "*"
  ps_cond <- 3
  z_cond <- TRUE

  ps_data <- Stat_Primary_Supress(inp_data, ps_vars, ps_char, ps_cond, z_cond)

  expect_equal(inp_data, ps_data)

})

test_that("Selected numeric variable values are supressed if value is <= suppression condition", {

  inp_data <- dummy_wide
  ps_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
  ps_char <- "*"
  ps_cond <- 3
  z_cond <- TRUE

  ps_data <- Stat_Primary_Supress(inp_data, ps_vars, ps_char, ps_cond, z_cond)


  expect_equal(ps_data,
               data.frame(
                 line = c("Sensitive A", "Sensitive B", "Sensitive C"),
                 `20-24` = c("5", "*", "24"),
                 `25-29` = c("9", "6", "28"),
                 `30-34` = c("14", "4", "19"),
                 `35-39` = c("11", "*", "22"),
                 `40-44` = c("20", "8", "35"),
                 `45-49` = c("*", "9", "39"),
                 `50-54` = c("14", "*", "28"),
                 `55-59` = c("10", "11", "27"),
                 `Total` = c("86", "44", "222"), check.names = FALSE, stringsAsFactors = FALSE
               )

               )

  })
