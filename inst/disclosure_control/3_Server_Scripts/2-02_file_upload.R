### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 2-02_file_upload.R
#Purpose: To upload an input file for the App.
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create empty vector to store column names
dsnames <- c()

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 1. File Upload ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Reactive Statement to store input data
data <- shiny::reactive({

  # Store Input File
  inFile <- input$upload

  # Check if data is given
  req(inFile)

  # Ensures valid file Upload
  ext <- tools::file_ext(inFile$name)

  # Upload File
  switch(ext,
         csv = dplyr::as_tibble(readr::read_csv(input$upload$datapath)),
         xlsx = readxl::read_excel(input$upload$datapath),
         xls = readxl::read_xls(input$upload$datapath),
         shiny::validate("Invalid file; Please upload a .csv or .xlsx/.xls file")
         )
  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 2. Add Serial Number to Input ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Allows data to be stored as reactive values for processing
App_data <- shiny::reactiveValues(values=NULL)

# Add Serial number as 1st column in dataframe
shiny::observe({

  App_data$values <- data() |>
    dplyr::mutate(Serial = dplyr::row_number()) |>
    dplyr::select(Serial,
                  dplyr::everything())

  })



### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 3. Summary Tables Render ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Dataset Summary
output$upload_summary_dist <- shiny::renderPrint({

  summary(data())

})

# Dataset Missingness Summary
output$upload_summary_missing <- shiny::renderPrint({

  # Calculates Percentage of data missing in each variable
  (colSums(is.na(data())) / nrow(data()))*100

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
