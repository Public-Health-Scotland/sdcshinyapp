# ------------------------------------------------------------------------------
# Script Name : 5-02_train.R
# Purpose     : Reset training data in the app
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Data Reset ----
shiny::observeEvent(input$training_dat_reset, {
  if (is.null(trainingdata())) {
    shinyalert::shinyalert(
      "Error: No input data available to reset.",
      type = "error"
    )
    return(NULL)
  }

  shinyalert::shinyalert("Input data reset to initial state.", type = "success")

  shiny::isolate({
    App_data$values <- trainingdata() |>
      dplyr::mutate(Serial = dplyr::row_number()) |>
      dplyr::select(Serial, dplyr::everything())
  })

  # Clear prior settings
  unprocessed$data <- NULL
  removed_values$removed_data <- NULL
  Serial_Removed$data <- NULL
  key_value_header$header <- NULL
  variable_value_header$header <- NULL
  key_value_options$data <- NULL
})

# END OF SCRIPT ----
