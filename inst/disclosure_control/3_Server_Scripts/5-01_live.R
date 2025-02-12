### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 5-01_live.R
#Purpose: To download live data from app
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###


### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Data Reset ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Reset with button press
shiny::observeEvent(

  input$upload_dat_reset, {

    # Ensures that this only works when data is provided
    shiny::validate(
      shiny::need(data(), "There is no input data")
      )

    shinyalert::shinyalert(title = "Input data reset to initial state.",
                           type = "success")


    #Data Reset
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

    }

  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 2. Data Download ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

output$downloadData <- shiny::downloadHandler(

  # Store Filename
  filename = function(){

    # Ensures that this only works when data is provided
    shiny::validate(
      shiny::need(App_data$values, "There is no input data")
      )

    paste0("SDC_", input$upload$name)

    },

  # Download of different file type
  content = function(fname){

    # Ensures that this only works when data is provided
    shiny::validate(
      shiny::need(App_data$values, "There is no input data")
      )

    # Final Data
    Final <- App_data$values

    if (input$upload$type == "text/csv") {

      readr::write_csv(Final, fname, row.names = FALSE)

      } else if (input$upload$type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {

        # For writing xlsx, data must be stored in dataframe
        Final <- as.data.frame(Final)

        openxlsx::write.xlsx(Final, fname, row.names = FALSE)

        } else if (input$upload$type == "application/vnd.ms-excel") {

          # For writeing xls, data must be stored in dataframe
          Final <- as.data.frame(Final)

          openxlsx::write.xlsx(Final, fname, row.names = FALSE)

          } else {

            readr::write_csv(Final, fname, row.names = FALSE)

          }

    }

  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
