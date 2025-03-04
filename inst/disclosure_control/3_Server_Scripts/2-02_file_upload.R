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

## 1. File Upload ----

# Reactive Statement to store input data
data <- shiny::reactive({
  inFile <- input$upload  # Get uploaded file
  req(inFile)  # Ensures file is uploaded
  ext <- tools::file_ext(inFile$name)  # Extract the file extension

  # Read the file based on its extension
  switch(ext,
         csv = dplyr::as_tibble(readr::read_csv(inFile$datapath)),  # Read CSV file and convert to tibble
         xlsx = readxl::read_excel(inFile$datapath),  # Read XLSX file
         xls = readxl::read_xls(inFile$datapath),  # Read XLS file
         shiny::validate("Invalid file; Please upload a .csv or .xlsx/.xls file")  # Validate file type
  )
})

## 2. Add Serial Number to Input ----

# Allows data to be stored as reactive values for processing
App_data <- shiny::reactiveValues(values=NULL)

# Add Serial number to 1st column in dataframe
shiny::observe({

  App_data$values <- data() |>
    dplyr::mutate(Serial = dplyr::row_number()) |>
    dplyr::select(Serial,
                  dplyr::everything())

  })

## 3. Summary Tables Render ----

# Dataset Summary
output$upload_summary_dist <- shiny::renderPrint({

  summary(data())

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
