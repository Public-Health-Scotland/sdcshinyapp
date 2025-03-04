### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: server.R
#Purpose: To set up the Server Functionality for the Shiny App
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

server <- function(input, output, session) {

  # 1. Home ----
  # There is no scripts required as the home Section has no active functions

  # 2. File Upload/Data Input ----

  # Training Data Input Side Panel Script
  source("3_Server_Scripts/2-01_dummy_data.R",  local = TRUE)$value

  # File Upload Side Panel Script
  source("3_Server_Scripts/2-02_file_upload.R",  local = TRUE)$value

  # Data Process Side Panel Script
  source("3_Server_Scripts/2-03_var_convert.R",  local = TRUE)$value

  # Data Summary after processing Side Panel script
  source("3_Server_Scripts/2-04_post_proc_summary.R",  local = TRUE)$value

  # 3. Filtering/Formatting ----

  # Filtering Side Panel Script
  source("3_Server_Scripts/3-01_filtering.R",  local = TRUE)$value

  # Formatting Side Panel Script
  source("3_Server_Scripts/3-02_formatting.R",  local = TRUE)$value

  # 4. SDC Methods ----

  # Rounding Side Panel Script
  source("3_Server_Scripts/4-01_rounding.R",  local = TRUE)$value

  # Swapping Side Panel Script
  source("3_Server_Scripts/4-02_swapping.R",  local = TRUE)$value

  # Suppression Side Panel Script
  source("3_Server_Scripts/4-03_suppression.R",  local = TRUE)$value

  # 5. Download ----

  # Download Script
  source("3_Server_Scripts/5_download.R",  local = TRUE)$value

  # 6. Shut App ----
  # When Browser is closed

  session$onSessionEnded(stopApp)

}

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
