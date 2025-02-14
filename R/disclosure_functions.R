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

#' Stat_Round Function
#' @description Performs rounding on selected variables within a dataset to a chosen base
#' @param orig_data Input Data to be disclosed
#' @param var_choice Choice of variables to be rounded
#' @param round_cond Rounding Base
#'
#' @return rounded_data Disclosed Data with Rounding Applied
#' @export
#'
#' @examples inp_data <- dummy_wide
#' @examples r_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
#' @examples r_base <- 3
#' @examples r_data <- Stat_Round(inp_data, r_vars, r_base)
#' @examples inp_data
#' @examples r_data
Stat_Round <- function(orig_data, var_choice, round_cond) {
  # Variables to be rounded
  orig_var <- orig_data[, var_choice]

  # Check if variable is given as vector (use for one pri var)
  vec_check <- is.vector(orig_var)

  # Transform vector into data frame (Used for when one pri var given)
  if (vec_check == TRUE) {
    orig_var <- data.frame(orig_var)

    names(orig_var)[names(orig_var) == "orig_var"] <- var_choice
  } else {

  }

  # Replace any NAs with a high value
  orig_var[is.na(orig_var)] <- 999999999

  # Ensures that replacement of NAs occurs
  orig_data[, var_choice] <- orig_var

  # NA value after rounding has occured - this is changed back to NA for the disclosed data
  rounding_NA_value <- plyr::round_any(999999999, round_cond, round)

  # Check if column headers are all whole numbers
  num_var_choice <- unlist(lapply(orig_data[var_choice], DistributionUtils::is.wholenumber))

  # Only select variables with whole numbers
  num_var_choice <- data.frame(num_var_choice) |>
    dplyr::filter(num_var_choice == TRUE) |>
    rownames(num_var_choice)

  # Store Variables chosen for rounding
  x <- orig_data[, num_var_choice]

  # Transform vector into data frame (Used for when one pri var given)
  if (vec_check == TRUE) {
    x <- data.frame(x)

    names(x)[names(x) == "x"] <- num_var_choice
  } else {

  }

  # Copy of original data
  rounded_data <- orig_data

  # Rounds chosen variables if provided variables are whole numbers
  rounded_data[, num_var_choice] <- lapply(
    x,
    function(x) {
      if (DistributionUtils::is.wholenumber(x)) {
        plyr::round_any(x, round_cond, round)
      } else {
        x
      }
    }
  )

  # Add NAs back to data
  rounded_data[, var_choice][rounded_data[, var_choice] == rounding_NA_value] <- NA

  # Rounded Data
  return(rounded_data)
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

#' Stat_Primary_Supress Function
#' @description Performs Primary Suppression on selected variables within a Dataset
#' @param orig_data Input Data to be disclosed
#' @param var_choice Choice of variables to be suppressed
#' @param char_supp Character used to indicate suppression
#' @param sup_cond Values equal to or below this value will be suppressed
#' @param zero Indicates if 0 should be suppressed
#'
#' @return Disclosed Data with Primary Suppression Applied
#' @export
#'
#' @examples inp_data <- dummy_wide
#' @examples ps_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "Total")
#' @examples ps_char <- "*"
#' @examples ps_cond <- "3"
#' @examples z_cond <- TRUE
#' @examples ps_data <- Stat_Primary_Supress(inp_data, ps_vars, ps_char, ps_cond, z_cond)
#' @examples inp_data
#' @examples ps_data
Stat_Primary_Supress <- function(orig_data, var_choice, char_supp, sup_cond, zero) {
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

  # Check if column headers are all whole numbers
  num_var_choice <- unlist(lapply(orig_data[var_choice], DistributionUtils::is.wholenumber))

  # Only select variables with whole numbers
  num_var_choice <- data.frame(num_var_choice) |>
    dplyr::filter(num_var_choice == TRUE) |>
    rownames(num_var_choice)

  # Store Variables choosen for Primary Suppression
  x <- orig_data[, num_var_choice]

  # Transform vector into data frame (Used for when one pri var given)
  if (vec_check == TRUE) {
    x <- data.frame(x)

    names(x)[names(x) == "x"] <- num_var_choice
  } else {

  }

  # Copy of original data
  primary_data <- orig_data

  # If Statement - Leave zero unsuppress if checkbox is ticked - otherwise suppress zeros
  if (zero == TRUE) {
    # Applies Primary Suppression on all numbers below suppression condition apart from zero
    primary_data[, num_var_choice] <- lapply(
      x,
      function(x) {
        if (DistributionUtils::is.wholenumber(x)) {
          replace(x, x <= sup_cond & x > 0, char_supp)
        } else {
          x
        }
      }
    )
  } else {
    # Applies Primary Suppression on all numbers below suppression condition
    primary_data[, num_var_choice] <- lapply(
      x,
      function(x) {
        if (DistributionUtils::is.wholenumber(x)) {
          replace(x, x <= sup_cond, char_supp)
        } else {
          x
        }
      }
    )
  }

  # Add NAs back to data
  primary_data[, var_choice][primary_data[, var_choice] == "999999999"] <- NA

  # Primary Suppressed Data
  return(primary_data)
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 4. Primary & Secondary Suppression ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

#' Stat_Secondary_Supress Function
#' @description Performs Primary & Secondary Suppression on selected variables within a Dataset
#' @param orig_data Input Data to be disclosed
#' @param pri_var_choice Choice of variables to be suppressed using Primary Suppression
#' @param sec_var_choice Choice of variables to be suppressed using Secondary Suppression
#' @param char_supp Character used to indicate suppression
#' @param sup_cond Values equal to or below this value will be suppressed
#' @param zero Indicates if 0 should be suppressed
#'
#' @return secondary_data Data with Primary & Secondary Suppression Applied
#' @export
#'
#' @examples inp_data <- dummy_wide
#' @examples ps_vars <- "Total"
#' @examples ss_vars <- c("20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59")
#' @examples s_char <- "*"
#' @examples s_cond <- 3
#' @examples z_cond <- TRUE
#' @examples s_data <- Stat_Secondary_Supress(inp_data, ps_vars, ss_vars, s_char, s_cond, z_cond)
#' @examples inp_data
#' @examples s_data
Stat_Secondary_Supress <- function(orig_data, pri_var_choice, sec_var_choice, char_supp, sup_cond, zero) {
  # Disable warning messages caused by function - ensures that the function runs smoothly
  options(warn = -1)

  # Check if Serial Number is in data - remove if it is
  if ("Serial" %notin% colnames(orig_data)) {
    # orig_data <- orig_data

    # Ensure Serial values are NULL if no Serial number provided - this is required for later in this function
    Serial_values <- NULL

    # Remove Serial Number for Primary & Secondary Suppression - this gets re-added later
  } else {
    # Store removed Serial number
    Serial_values <- orig_data |>
      dplyr::select(Serial)

    # Remove Serial number
    orig_data <- orig_data |>
      dplyr::select(-Serial)
  }

  ### ### ### ### ### ### ### ### ### ### ### ### ### ###
  ## Primary Suppresion performed first ----
  ### ### ### ### ### ### ### ### ### ### ### ### ### ###

  # Variables to be processed
  orig_var <- orig_data[, pri_var_choice]

  # Check if variable is given as vector (use for one pri var)
  vec_check <- is.vector(orig_var)

  # Transform vector into data frame (Used for when one pri var given)
  if (vec_check == TRUE) {
    orig_var <- data.frame(orig_var)

    names(orig_var)[names(orig_var) == "orig_var"] <- pri_var_choice
  } else {

  }

  # Replace any NAs with high value - this is changed back to NA for the disclosed data
  orig_var[is.na(orig_var)] <- 999999999

  # Ensures that replacement of NAs occurs
  orig_data[, pri_var_choice] <- orig_var

  # Check if column headers are all whole numbers for primary variables
  pri_var_choice <- unlist(lapply(orig_data[pri_var_choice], DistributionUtils::is.wholenumber))

  # Only select variables with whole numbers
  pri_var_choice <- data.frame(pri_var_choice) |>
    dplyr::filter(pri_var_choice == TRUE) |>
    rownames(pri_var_choice)

  # Store Variables chosen for Primary Suppression
  x <- orig_data[, pri_var_choice]

  # Transform vector into data frame (Used for when one pri var given)
  if (vec_check == TRUE) {
    x <- data.frame(x)

    names(x)[names(x) == "x"] <- pri_var_choice
  } else {

  }

  # Copy of original data
  primary_data <- orig_data

  # Primary Suppression - If Statement which leaves zero unsuppress if checkbox is ticked - otherwise suppress zeros
  if (zero == TRUE) {
    # Applies Primary Suppression on all numbers below suppression condition apart from zero
    primary_data[, pri_var_choice] <- lapply(
      x,
      function(x) {
        if (DistributionUtils::is.wholenumber(x)) {
          replace(x, x <= sup_cond & x > 0, char_supp)
        } else {
          x
        }
      }
    )
  } else {
    # Applies Primary Suppression on all numbers below suppression condition
    primary_data[, pri_var_choice] <- lapply(
      x,
      function(x) {
        if (DistributionUtils::is.wholenumber(x)) {
          replace(x, x <= sup_cond, char_supp)
        } else {
          x
        }
      }
    )
  }

  # Add NAs back to data
  primary_data[, pri_var_choice][primary_data[, pri_var_choice] == "999999999"] <- NA

  ### ### ### ### ### ### ### ### ### ### ### ### ### ###
  ## Secondary Suppression ----
  ### ### ### ### ### ### ### ### ### ### ### ### ### ###

  # Variables to be processed
  orig_var_sec <- primary_data[, sec_var_choice]

  # Replace any NAs with high value - this is changed back to NA for the disclosed data
  orig_var_sec[is.na(orig_var_sec)] <- 999999999

  # Ensures that replacement of NAs occurs
  primary_data[, sec_var_choice] <- orig_var_sec

  # Check if column headers are all whole numbers for secondary variables
  sec_var_choice <- unlist(lapply(primary_data[sec_var_choice], DistributionUtils::is.wholenumber))

  # Only select variables with whole numbers
  sec_var_choice <- data.frame(sec_var_choice) |>
    dplyr::filter(sec_var_choice == TRUE) |>
    rownames(sec_var_choice)

  # Store Variables choosen for Secondary Suppression
  x <- primary_data[, sec_var_choice]

  # Copy of primary suppressed data
  init_secondary_data <- primary_data

  # Initial Secondary Suppression - Primary Suppression is done first before the remaining values are suppressed
  # Applies Secondary Suppression on all numbers below suppression condition apart from zero
  if (zero == TRUE) {
    # Applies Initial Secondary Suppression on all numbers below suppression condition apart from zero
    init_secondary_data[, sec_var_choice] <- lapply(
      x,
      function(x) {
        if (DistributionUtils::is.wholenumber(x)) {
          replace(x, x <= sup_cond & x > 0, char_supp)
        } else {
          x
        }
      }
    )
  } else {
    # Applies Initial Secondary Suppression on all numbers below suppression condition
    init_secondary_data[, sec_var_choice] <- lapply(
      x,
      function(x) {
        if (DistributionUtils::is.wholenumber(x)) {
          replace(x, x <= sup_cond, char_supp)
        } else {
          x
        }
      }
    )
  }

  # Copy of initial secondary suppressed data
  secondary_data <- init_secondary_data

  # # Store Variables choosen for Secondary Suppression
  x <- secondary_data[, sec_var_choice]

  # Count number of suppressions in each row
  secondary_data <- secondary_data |>
    dplyr::mutate(SDC_count = apply(x, 1, function(x) length(which(x == char_supp))))

  # Replace zeros with identifier to avoid supression
  secondary_data[, sec_var_choice] <- lapply(
    x,
    function(x) {
      if (is.character(x)) {
        replace(x, x == "0", "zero_rep")
      } else {
        x
      }
    }
  )

  # Copy of initial secondary suppressed data
  x <- secondary_data[, sec_var_choice]

  # Replace high NA numbers with identifier to avoid supression
  secondary_data[, sec_var_choice] <- lapply(
    x,
    function(x) {
      if (is.character(x)) {
        replace(x, x == "999999999", "missing_value")
      } else {
        x
      }
    }
  )

  # # Store Variables choosen for Secondary Suppression
  x <- secondary_data[, sec_var_choice]


  # Extracts number to be suppressed - this occurs if there is only one suppressed secondary value
  secondary_data <- secondary_data |>
    dplyr::mutate(min_value_sec = ifelse(SDC_count == 1, apply(x, 1, function(x) min(as.numeric(x), na.rm = TRUE)),
      NA
    ))

  # If Else Loop to ensure that process is only done if secondary variables are available

  if (length(sec_var_choice) > 0) {
    # For loop which performs Secondary Suppression
    for (i in 1:length(sec_var_choice)) {
      # Suppress next lowest value in the secondary variable column for each row if only one value is suppressed
      secondary_data[[sec_var_choice[i]]] <- ifelse(is.na(secondary_data$min_value_sec), secondary_data[[sec_var_choice[i]]],
        ifelse(secondary_data[[sec_var_choice[i]]] == secondary_data$min_value_sec, char_supp, secondary_data[[sec_var_choice[i]]])
      )
    }

    # No further suppression
  } else {
    secondary_data <- secondary_data
  }

  # Store Variables choosen for Secondary Suppression
  x <- secondary_data[, sec_var_choice]

  # Add zeros back to dataset
  secondary_data[, sec_var_choice] <- lapply(
    x,
    function(x) {
      if (is.character(x)) {
        replace(x, x == "missing_value", NA)
      } else {
        x
      }
    }
  )

  # Store Variables choosen for Secondary Suppression
  x <- secondary_data[, sec_var_choice]

  # Add NAs back to dataset
  secondary_data[, sec_var_choice] <- lapply(
    x,
    function(x) {
      if (is.character(x)) {
        replace(x, x == "zero_rep", "0")
      } else {
        x
      }
    }
  )

  # Re-add Serial number if removed by function
  if (!is.null(Serial_values)) {
    # Ensures that Serial number is 1st column as previously
    secondary_data <- secondary_data |>
      cbind(Serial_values) |>
      dplyr::select(Serial, dplyr::everything())
  } else {
    # No changes to data
    secondary_data <- secondary_data
  }

  # Processed Data - removed variables added for the purpose of secondary suppression
  secondary_data <- secondary_data |>
    dplyr::select(-SDC_count, -min_value_sec)

  # Secondary Suppressed Data
  return(secondary_data)
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
