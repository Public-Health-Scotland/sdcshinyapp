### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 2_data_input.R
#Purpose: Set up UI for the Main Tab used for uploading/processing input data
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create 1. Input Data Main Tab
shiny::tabPanel("1. Input Data", shiny::navlistPanel(
  id = "tabset",
  widths = sb_width,

  # 1. Data Input Choice Section ----
  source("2_UI_Scripts/2-01_dummy_data_choice.R",  local = TRUE)$value,

  # 2. File Upload Section ----
  source("2_UI_Scripts/2-02_file_upload.R",  local = TRUE)$value,

  # 3. Data Process Section ----
  source("2_UI_Scripts/2-03_var_convert.R",  local = TRUE)$value,

  # 4. App Data Summary Section ----
  source("2_UI_Scripts/2-04_post_proc_summary.R",  local = TRUE)$value
  )
  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
