### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 2-01_dummy_data.R
#Purpose: To select dummy data for the App.
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Dummy Data Setup ----

# Reactive expression to select training data
trainingdata <- shiny::reactive({
  switch(input$train_data_select,
         "Wide Data" = dummy_wide,
         "Long Data" = dummy_long)
  })

# Store data as reactive values for processing
App_data <- shiny::reactiveValues(values=NULL)

# 2. Data Checks ----

# Generate dataset summary
output$Train_summary_dist <- shiny::renderPrint({

  summary(trainingdata())

})

# Generate a summary of percentage of missing data in each variable
output$Train_summary_missing <- shiny::renderPrint({

  (colSums(is.na(trainingdata())) / nrow(trainingdata()))*100

})

## 3. Dummy Data Choice ----

# Select Training Data with button press
shiny::observeEvent(

  input$use_train, {

    App_data$values <- trainingdata() |>
      dplyr::mutate(Serial = row_number()) |>
      dplyr::select(Serial, everything())

  }

)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
