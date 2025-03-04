### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 5-01_live.R
#Purpose: To download live data from app
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Data Reset ----

# Data Reset
shiny::observeEvent(input$upload_dat_reset, {

  # Validation - Data must be provided
  shiny::validate(shiny::need(data(), "There is no input data"))

  # Success Notification
  shinyalert::shinyalert(title = "Input data reset to initial state.", type = "success")

  # Data Reset
  shiny::isolate({
    App_data$values <- data() |>
      dplyr::mutate(Serial = row_number()) |>
      dplyr::select(Serial, dplyr::everything())
    })

  # Clear Prior Settings
  unprocessed$data <- NULL
  removed_values$removed_data <- NULL
  Serial_Removed$data <- NULL
  key_value_header$header <- NULL
  variable_value_header$header <- NULL
  key_value_options$data <- NULL

  })

# 2. Data Download ----
output$downloadData <- shiny::downloadHandler(

  ## 1. Store Filename ----
  filename = function(){

    # Validation - Data must be provided
    shiny::validate(shiny::need(App_data$values, "There is no input data"))

    # File Name
    paste0("SDC_", input$upload$name)

    },

  ## 2. Allow Download of different file types ----
  content = function(fname){

    # Validation - Data must be provided
    shiny::validate(shiny::need(App_data$values, "There is no input data"))

    # Final Data
    Final <- App_data$values

    ### 1. .csv files ----
    if (input$upload$type == "text/csv") {

      utils::write.csv(Final, fname, row.names = FALSE)

      ### 2. .xlsx files ----
      } else if (input$upload$type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {

        Final <- as.data.frame(Final) # For this file type, data must be stored in dataframe
        openxlsx::write.xlsx(Final, fname, row.names = FALSE)

        ### 3. .xls files ----
        } else if (input$upload$type == "application/vnd.ms-excel") {

          Final <- as.data.frame(Final) # For this file type, data must be stored in dataframe
          openxlsx::write.xlsx(Final, fname, row.names = FALSE)

          ### 4. All other files (write as .csv) ----
          } else {

            utils::write.csv(Final, fname, row.names = FALSE)

            }})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
