### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# Run on Posit version: 4.1.2
# Last updated: 02 Oct 2024
# By: Robert Mitchell
# Script: app_functions.R
# Purpose: Contains all functions created specifically for a Shiny App
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Table Rendering ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

#' Table_Render
#' @description Used for rendering tables within the SDC App. Can only be used inside Shiny App
#' @param dataset Dataset to be rendered into table
#' @param cb Allows for interactive visualisation from Table
#'
#' @return output_data Visualised Table
#' @export
#'
#' @examples
Table_Render <- function(dataset, cb) {
  output_data <- DT::datatable(
    data = dataset,
    escape = FALSE,
    rownames = FALSE,
    class = "compact stripe hover",
    selection = "none",
    options = list(
      rowsGroup = list(0),
      drawCallback = cb,
      columnDefs = list(
        list(className = "dt-center", targets = "_all")
      ),
      pageLength = 10,
      dom = "Bfrtip"
    )
  ) |>
    sparkline::spk_add_deps()

  return(output_data)
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 2. SelectBox Update ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###


#' SelectBox_Update
#' @description Used for generate variable names in selectboxes. Can only be used inside Shiny App
#' @param SDC_data input data containing variable names
#'
#' @return cb_options Variables names given in select box
#' @export
#'
#' @examples
SelectBox_Update <- function(SDC_data) {
  # Check if data is given
  shiny::req(SDC_data)

  dsnames <- names(SDC_data) # Extracts Column Names
  dsnames <- dsnames[!dsnames %in% c("Serial")] # Remove Serial Number Option

  # Select column names as options for checkbox
  cb_options <- list()
  cb_options[dsnames] <- dsnames

  return(cb_options)
}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
