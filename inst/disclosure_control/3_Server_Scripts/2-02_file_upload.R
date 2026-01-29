# ------------------------------------------------------------------------------
# Script Name : 2-02_file_upload.R
# Purpose     : Upload input file for the App
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. File Upload ----

# Reactive expression to read uploaded file
data <- shiny::reactive({
  inFile <- input$upload
  req(inFile)

  ext <- tools::file_ext(inFile$name)

  switch(ext,
    csv = dplyr::as_tibble(readr::read_csv(inFile$datapath)),
    xlsx = readxl::read_excel(inFile$datapath),
    xls = readxl::read_xls(inFile$datapath),
    shiny::validate("Invalid file; please upload a .csv, .xlsx, or .xls file")
  )
})

# 2. Add Serial Number to Input ----

# Reactive values to store processed data
App_data <- shiny::reactiveValues(values = NULL)

# Add Serial column to uploaded data
shiny::observe({
  # Reset trainingdata() only if data() is available
  if (!is.null(data())) {
    # Assign uploaded data with Serial column
    App_data$values <- data() |>
      dplyr::mutate(Serial = dplyr::row_number()) |>
      dplyr::select(Serial, dplyr::everything())
  }
})

# 3. Summary Table ----

# Render dataset summary
output$upload_summary_dist <- shiny::renderPrint({
  summary(data())
})
