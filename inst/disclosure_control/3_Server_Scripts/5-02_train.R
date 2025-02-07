### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 5-02_train.R
#Purpose: To download live data from app
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Data Reset ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Reset with button press
shiny::observeEvent(

  input$training_dat_reset, {

    # Ensures that this only works when data is provided
    shiny::validate(
      need(trainingdata(), "There is no input data")
      )

    shinyalert::shinyalert(title = "Input data reset to initial state.",
                           type = "success")


    #Data Reset
    shiny::isolate({

      App_data$values <- trainingdata() |>
        dplyr::mutate(Serial = dplyr::row_number()) |>
        dplyr::select(Serial, dplyr::everything())

      })

    # Clear Prior Settings
    unprocessed$data <- NULL
    removed_values$removed_data <- NULL
    Serial_Removed$data <- NULL
    key_value_header$header <- NULL
    variable_value_header$header <- NULL
    key_value_options$data <- NULL

    }

  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
