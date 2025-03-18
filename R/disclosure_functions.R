### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# Run on Posit version: 4.1.2
# Last updated: 02 Oct 2024
# By: Robert Mitchell
# Script: disclosure_functions.R
# Purpose: Contains all Disclosure functions used by the App
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ##

# Set up Not In Function
`%notin%` <- Negate(`%in%`)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Rounding ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

#' Round Selected Variables in a Dataset
#'
#' This function rounds specified numeric variables within a dataset to a chosen base. It handles missing values by temporarily replacing them with a high value, which is reverted back to `NA` after rounding.
#'
#' @param orig_data A data frame or tibble containing the input data to be rounded.
#' @param var_choice A character vector specifying the names of the variables to be rounded. All specified variables must exist in `orig_data`.
#' @param round_cond A single positive whole integer greater than 1 indicating the rounding base.
#'
#' @return A data frame with the selected variables rounded to the specified base. Non-numeric variables are not modified.
#' @export
#'
#' @examples
#' # Example dataset
#' inp_data <- dummy_wide
#'
#' # Variables to be rounded
#' r_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
#'
#' # Rounding base
#' r_base <- 3
#'
#' # Apply rounding function
#' r_data <- Stat_Round(inp_data, r_vars, r_base)
#'
#' # View original and rounded data
#' inp_data
#' r_data
Stat_Round <- function(orig_data, var_choice, round_cond) {

# Validate input arguments
if (missing(orig_data) || is.null(orig_data) || (!is.data.frame(orig_data) && !tibble::is_tibble(orig_data))) {
  stop("Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
}

if (!is.character(var_choice) || length(var_choice) == 0 || !all(var_choice %in% colnames(orig_data))) {
  stop("Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
}

if (!is.numeric(round_cond) || length(round_cond) != 1 || round_cond <= 1 || round_cond %% 1 != 0) {
  stop("Error: 'round_cond' must be a single positive whole integer greater than 1.")
}

# Replace NA values with a high value (999999999) to avoid issues during rounding
r_data <- orig_data |>
  dplyr::mutate(dplyr::across(dplyr::all_of(var_choice), ~ tidyr::replace_na(., 999999999)))

# Determine the value to replace NA after rounding
rounding_NA_value <- plyr::round_any(999999999, round_cond, round)

# Identify variables that are whole numbers
num_var_choice <- var_choice[sapply(r_data[var_choice], DistributionUtils::is.wholenumber)]

# Return original data if no numeric variables are selected
if (length(num_var_choice) == 0) {
  warning("No numeric variables have been selected. The original input data will be returned.")
  return(orig_data)
}

# Round the selected variables to the specified base
r_data <- r_data |>
  dplyr::mutate(dplyr::across(dplyr::all_of(num_var_choice), ~ plyr::round_any(., round_cond, round)))

# Restore NA values in the rounded data
r_data <- r_data |>
  dplyr::mutate(dplyr::across(dplyr::all_of(var_choice), ~ dplyr::na_if(., rounding_NA_value)))

# Return the rounded data
return(r_data)

}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 2. Swapping ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

#' Stat_Swap Function
#' @description Performs rounding on selected variables within a Dataset
#' @param orig_data Input Data to be disclosed
#' @param var_choice Choice of variables to be swapped
#' @param swap_cond Swapping condtion meaning values below this in a dataset must be swapped
#'
#' @return Disclosed Data with Swapping Applied
#' @export
#'
#' @examples inp_data <- dummy_wide
#' @examples s_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
#' @examples s_cond <- 3
#' @examples s_data <- Stat_Swap(inp_data, s_vars, s_cond)
#' @examples inp_data
#' @examples s_data
Stat_Swap <- function(orig_data, var_choice, swap_cond) {
  # Exit Function with input data if no input variables are provided
  if (is.null(var_choice)) {
    # Data to return
    swapped_data <- orig_data

    # Warning Message
    print("No input variables have been selected. The original input data will be returned.")

    # Return unprocessed data
    return(swapped_data)
  }

  # Variables to be processed
  orig_var <- orig_data[, var_choice]

  # Check if variable is given as vector (use for one pri var)
  vec_check <- is.vector(orig_var)

  # Transform vector into data frame (Used for when one pri var given)
  if (vec_check == TRUE) {
    orig_var <- data.frame(orig_var)

    names(orig_var)[names(orig_var) == "orig_var"] <- var_choice
  } else {

  }

  # Replace any NAs with high value - this is changed back to NA for the disclosed data
  orig_var[is.na(orig_var)] <- 999999999

  # Ensures that replacement of NAs occurs
  orig_data[, var_choice] <- orig_var

  # Copy of original data to process
  swapped_data <- orig_data

  # Check if column headers are all whole numbers
  num_var_choice <- unlist(lapply(orig_data[var_choice], DistributionUtils::is.wholenumber))

  # Only select variables with whole numbers
  num_var_choice <- data.frame(num_var_choice) |>
    dplyr::filter(num_var_choice == TRUE) |>
    rownames(num_var_choice)

  # Exit Function with input data if no numeric variables are provided
  if (length(num_var_choice) == 0) {
    # Data to return
    swapped_data <- orig_data

    # Transform NA value back to NA
    swapped_data[, var_choice][swapped_data[, var_choice] == 999999999] <- NA
    swapped_data[, var_choice][swapped_data[, var_choice] == "999999999"] <- NA

    # Warning Message
    print("No numeric variables have been selected. The original input data will be returned.")

    # Return unprocessed data
    return(swapped_data)
  }

  # Get number of columns containing whole numbers
  var_swap_len <- length(num_var_choice)

  # For Loop to process each numeric column
  for (i in 1:var_swap_len) {
    # checks if variable value is less than or equal to the swapping condition
    chk <- swapped_data[, num_var_choice[i]] <= swap_cond
    chk <- which(chk == TRUE)
    ind_numbers <- length(chk) # For each column, calculate how many values must be swapped

    # If statement for columns where values are swapped, else statements if no value in a column needs to be swapped
    if (length(ind_numbers) > 0) {
      # Allows for indices position to be swapped
      swapindices <- sample(x = c(chk), ind_numbers)
      newindices <- sample(swapindices, ind_numbers)

      # If statement when only one value is below swapping condition to ensure no swapping occurs
      if (length(swapindices) > 1) {
        # Performs Swapping
        swapped_data[swapindices, num_var_choice[i]] <- swapped_data[newindices, num_var_choice[i]]
        # Clear Indices Values
        rm(swapindices, newindices)
      } else {
        # Clear Indices Values
        rm(swapindices, newindices)
        # No Cell Swapping Occurs
        swapped_data <- swapped_data
      }
    } else {
      # No Cell Swapping Occurs
      swapped_data <- swapped_data
    }
  }

  # Add NAs back to data
  swapped_data[, var_choice][swapped_data[, var_choice] == 999999999] <- NA

  # Swapped Data
  return(swapped_data)
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 3. Primary Suppression ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

#' Perform Primary Suppression on Selected Variables
#'
#' This function applies primary suppression to specified variables within a dataset. Values equal to or below a given threshold are replaced with a suppression character.
#'
#' @param orig_data A data frame or tibble containing the input data to have primary suppression applied.
#' @param var_choice A character vector specifying the names of the variables to be rounded. All specified variables must exist in orig_data.
#' @param char_supp A character used to indicate suppression. Default is `*`. Must be either `*` or `c`.
#' @param sup_cond A single positive integer. Values equal to or below this threshold will be suppressed.
#' @param zero A single logical value indicating whether zero should be suppressed. Default is TRUE. If TRUE, zero values will remain un-suppressed.
#'
#' @return A data frame or tibble with primary suppression applied to the specified variables. Original NA values are preserved.
#' @export
#'
#' @examples
#' inp_data <- dummy_wide
#' ps_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
#' ps_char <- "*"
#' ps_cond <- 3
#' z_cond <- TRUE
#' ps_data <- Stat_Primary_Supress(inp_data, ps_vars, ps_char, ps_cond, z_cond)
#' inp_data
#' ps_data
Stat_Primary_Supress <- function(orig_data, var_choice, char_supp = "*", sup_cond, zero = TRUE) {

  # Validate input arguments
  if (missing(orig_data) || is.null(orig_data) || (!is.data.frame(orig_data) && !tibble::is_tibble(orig_data))) {
    stop("Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
  }

  if (!is.character(var_choice) || length(var_choice) == 0 || !all(var_choice %in% colnames(orig_data))) {
    stop("Error: 'var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
  }

  if (!is.character(char_supp) || !(char_supp %in% c("*", "c"))) {
    stop("Error: 'char_supp' must be either '*' or 'c'.")
  }

  if (!is.numeric(sup_cond) || length(sup_cond) != 1 || sup_cond <= 0 || sup_cond %% 1 != 0) {
    stop("Error: 'sup_cond' must be a single positive whole integer.")
  }

  if (!is.logical(zero) || length(zero) != 1) {
    stop("Error: 'zero' must be a single logical value.")
  }

  # Assign Suppression Dataset
  ps_data <- orig_data

  # Store original NA positions
  na_positions <- is.na(ps_data)

  # Replace NAs with a high value
  ps_data <- ps_data |>
    dplyr::mutate(dplyr::across(dplyr::all_of(var_choice), ~ dplyr::coalesce(., 999999999)))

  # Filter numeric columns
  num_var_choice <- var_choice[sapply(ps_data[var_choice], DistributionUtils::is.wholenumber)]

  # Return original data if no numeric variables are selected
  if (length(num_var_choice) == 0) {
    warning("No numeric variables have been selected. The original input data will be returned.")
    return(orig_data)
  }

  # Apply primary suppression to the selected variables
  ps_data <- ps_data |>
    dplyr::mutate(dplyr::across(dplyr::all_of(num_var_choice), ~ ifelse((zero & . <= sup_cond & . > 0) | (!zero & . <= sup_cond), char_supp, .)))

  # Restore NA values in the suppressed data
  ps_data[na_positions] <- NA

  # Return the suppressed data
  return(ps_data)
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 4. Primary & Secondary Suppression ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

#' @title Perform Primary & Secondary Suppression on Selected Variables
#' @description This function applies primary and secondary suppression on selected variables within a dataset. Primary suppression is applied to specified variables, followed by secondary suppression to further protect sensitive information.
#' @param orig_data A data frame or tibble containing the input data to have primary & secondary suppression applied.
#' @param pri_var_choice A character vector specifying the variable to be suppressed using primary suppression. Only one variable can be selected and it must exist in orig_data.
#' @param sec_var_choice A character vector specifying the variables to be suppressed using secondary suppression. All specified variables must exist in orig_data.
#' @param char_supp A character used to indicate suppression. Default is `*`. Must be either `*` or `c`.
#' @param sup_cond A numeric value; values equal to or below this threshold will be suppressed. For secondary suppression, the next lowest number in a row will be suppression if only one secondary values has been suppressed.
#' @param zero A single logical value indicating whether zero should be suppressed. Default is TRUE. If TRUE, zero values will remain un-suppressed.
#' @return A data frame or tibble with primary and secondary suppression applied to the specified variables. Original NA values are preserved.
#' @export
#' @examples
#' # Example dataset
#' inp_data <- dummy_wide
#'
#' # Variables for primary suppression
#' ps_vars <- "Total"
#'
#' # Variables for secondary suppression
#' ss_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59")
#'
#' # Suppression character
#' s_char <- "*"
#'
#' # Suppression condition
#' s_cond <- 3
#'
#' # Suppress zeros
#' z_cond <- TRUE
#'
#' # Apply suppression
#' s_data <- Stat_Secondary_Supress(inp_data, ps_vars, ss_vars, s_char, s_cond, z_cond)
#'
#' # View original data
#' inp_data
#'
#' # View suppressed data
#' s_data
Stat_Secondary_Supress <- function(orig_data, pri_var_choice, sec_var_choice, char_supp = "*", sup_cond, zero = TRUE) {

  ## Validate input arguments ----
  if (missing(orig_data) || is.null(orig_data) || (!is.data.frame(orig_data) && !tibble::is_tibble(orig_data))) {
    stop("Error: 'orig_data' must be provided, cannot be NULL, and must be a dataframe or tibble.")
  }

  if (!is.character(pri_var_choice) || length(pri_var_choice) != 1 || !pri_var_choice %in% colnames(orig_data)) {
    stop("Error: 'pri_var_choice' must be a single character string and must exist in 'orig_data'.")
  }

  if (!is.character(sec_var_choice) || length(sec_var_choice) == 0 || !all(sec_var_choice %in% colnames(orig_data))) {
    stop("Error: 'sec_var_choice' must be a non-empty character vector and all columns must exist in 'orig_data'.")
  }

  if (!is.character(char_supp) || !(char_supp %in% c("*", "c"))) {
    stop("Error: 'char_supp' must be either '*' or 'c'.")
  }

  if (!is.numeric(sup_cond) || length(sup_cond) != 1 || sup_cond <= 0 || sup_cond %% 1 != 0) {
    stop("Error: 'sup_cond' must be a single positive whole integer.")
  }

  if (!is.logical(zero) || length(zero) != 1) {
    stop("Error: 'zero' must be a single logical value.")
  }

  ## Primary Suppresion performed first ----

  # Assign Primary Suppression Dataset
  ps_data <- orig_data

  # Store original NA positions
  ps_na_positions <- is.na(ps_data)

  # Replace NAs with a high value
  ps_data <- ps_data |>
    dplyr::mutate(dplyr::across(dplyr::all_of(pri_var_choice), ~ dplyr::coalesce(., 999999999)))

  # Filter numeric columns
  ps_num_var_choice <- pri_var_choice[sapply(ps_data[pri_var_choice], DistributionUtils::is.wholenumber)]

  # Return original data if no numeric variables are selected
  if (length(ps_num_var_choice) == 0) {
    warning("No numeric variables have been selected. The original input data will be returned.")
    return(orig_data)
  }

  # Apply primary suppression to the selected variables
  ps_data <- ps_data |>
    dplyr::mutate(dplyr::across(dplyr::all_of(ps_num_var_choice), ~ ifelse((zero & . <= sup_cond & . > 0) | (!zero & . <= sup_cond), char_supp, .)))

  # Restore NA values in the suppressed data
  ps_data[ps_na_positions] <- NA

  ## Secondary Suppression ----

  # Assign Secondary Suppression Dataset
  ss_data <- ps_data

  # Store original NA positions
  ss_na_positions <- is.na(ss_data)

  # Replace NAs with a high value
  ss_data <- ss_data |>
    dplyr::mutate(across(all_of(sec_var_choice), ~ dplyr::coalesce(., 999999999)))

  # Filter numeric columns
  ss_num_var_choice <- sec_var_choice[sapply(ss_data[sec_var_choice], DistributionUtils::is.wholenumber)]

  # Return original data if no numeric variables are selected
  if (length(ss_num_var_choice) == 0) {
    warning("No numeric variables have been selected. The original input data will be returned.")
    return(orig_data)
  }

  # Function to apply secondary suppression
  apply_suppression <- function(x, sup_cond, char_supp, zero) {
    if (DistributionUtils::is.wholenumber(x)) {
      replace(x, if (zero) x <= sup_cond & x > 0 else x <= sup_cond, char_supp)
    } else {
      x
    }
  }

  # Apply Initial Secondary Suppression
  ss_data[, ss_num_var_choice] <- lapply(ss_data[, ss_num_var_choice], apply_suppression, sup_cond, char_supp, zero)

  # Count number of suppressions in each row
  ss_data <- ss_data |>
    dplyr::mutate(SDC_count = rowSums(ss_data[, ss_num_var_choice] == char_supp))

  # Function to replace zeros and high NA numbers with identifiers to avoid suppression
  replace_identifiers <- function(x) {
    if (is.character(x)) {
      x <- replace(x, x == "0", "zero_rep")
      x <- replace(x, x == "999999999", "missing_value")
    }
    x
  }

  # Replace zeros and high NA numbers with identifiers
  ss_data[, ss_num_var_choice] <- lapply(ss_data[, ss_num_var_choice], replace_identifiers)

  # Extract number to be suppressed - this occurs if there is only one suppressed secondary value
  ss_data <- ss_data |>
    dplyr::rowwise() |>
    dplyr::mutate(min_value_sec = dplyr::if_else(SDC_count == 1, min(as.numeric(dplyr::c_across(dplyr::all_of(ss_num_var_choice))), na.rm = TRUE), NA_real_)) |>
    dplyr::ungroup()

  # Apply secondary suppression
  ss_data <- ss_data |>
    dplyr::mutate(across(all_of(ss_num_var_choice), ~ dplyr::if_else(is.na(min_value_sec) | . != min_value_sec, ., char_supp)))

  # Function to replace identifiers with original values
  replace_original_values <- function(x) {
    if (is.character(x)) {
      x <- replace(x, x == "missing_value", NA)
      x <- replace(x, x == "zero_rep", "0")
    }
    x
  }

  # Replace identifiers with original value
  ss_data[, ss_num_var_choice] <- lapply(ss_data[, ss_num_var_choice], replace_original_values)

  # Processed Data - removed variables added for the purpose of secondary suppression
  ss_data <- ss_data |>
    dplyr::select(-SDC_count, -min_value_sec)

  # Secondary Suppressed Data
  return(ss_data)

}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
