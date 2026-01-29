# ------------------------------------------------------------------------------
# Script Name : 5_download.R
# Purpose     : UI for Download Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Download Data Tab
shiny::tabPanel(
  "4. Download Data",
  fluid = TRUE,
  shiny::fluidRow(
    # Input Definitions
    shiny::sidebarPanel(
      shiny::h4(shiny::strong("File Download / Data Reset")),
      shiny::h5(shiny::strong("Reset Uploaded Data")),
      shiny::actionButton("upload_dat_reset", "Reset"),
      shiny::br(),
      shiny::h5(shiny::strong("Reset Training Data")),
      shiny::actionButton("training_dat_reset", "Reset"),
      shiny::br(),
      shiny::h5(shiny::strong("Download Data")),
      shiny::downloadButton("downloadData", label = "Download")
    ),

    # Output Definitions
    shiny::mainPanel(
      DT::dataTableOutput("Final_data")
    )
  )
)

# END OF SCRIPT ----
