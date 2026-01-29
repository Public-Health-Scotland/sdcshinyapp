# ------------------------------------------------------------------------------
# Script Name : 2-01_dummy_data.R
# Purpose     : Select and manage dummy data for the App
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Dummy Data Setup ----

# Reactive expression to select training data
trainingdata <- shiny::reactive({
  switch(input$train_data_select,
    "Wide Data" = sdcshinyapp::dummy_wide,
    "Long Data" = sdcshinyapp::dummy_long
  )
})


# Store data as reactive values for processing
App_data <- shiny::reactiveValues(values = NULL)

# 2. Data Checks ----

# Dataset summary
output$Train_summary_dist <- shiny::renderPrint({
  summary(trainingdata())
})

# Missing data percentage per variable
output$Train_summary_missing <- shiny::renderPrint({
  (colSums(is.na(trainingdata())) / nrow(trainingdata())) * 100
})

# 3. Dummy Data Selection ----

# Load training data on button press
shiny::observeEvent(input$use_train, {
  App_data$values <- trainingdata() |>
    dplyr::mutate(Serial = dplyr::row_number()) |>
    dplyr::select(Serial, dplyr::everything())
})

# END OF SCRIPT ----
