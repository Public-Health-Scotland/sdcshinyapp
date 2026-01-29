# ------------------------------------------------------------------------------
# Script Name : 2-02_file_upload.R
# Purpose     : Set up UI for the Sub-Tab used for File Upload of Live Data
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# File Upload Sub-Tab for Input Data Main Tab
shiny::tabPanel(
  "File Upload",
  shiny::fluidRow(
    # Input Panel
    shiny::column(
      width = 3,
      shiny::h4(shiny::strong("File Upload")),
      shiny::p("This accepts .csv and .xlsx/.xls files."),
      shiny::fileInput(
        inputId = "upload",
        label = NULL,
        accept = c(".csv", ".tsv", ".xlsx", ".xls")
      )
    ),

    # Output Panel
    shiny::mainPanel(
      shiny::h1(shiny::strong("Data Information")),
      shiny::br(),
      shiny::h2(shiny::strong("Data Summary")),
      shiny::verbatimTextOutput("upload_summary_dist")
    )
  )
)

# END OF SCRIPT ----
