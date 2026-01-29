# ------------------------------------------------------------------------------
# Script Name : 3-01_filtering.R
# Purpose     : UI for Filtering Sub-Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Filtering Sub-Tab for 2. Input Data Filtering/Formatting Tab
shiny::tabPanel(
  "Filtering",
  shiny::fluidRow(
    # Input Definitions
    shiny::sidebarPanel(
      shiny::h5(shiny::strong("Store Unprocessed Data")),
      shiny::actionButton("Unprocess_Store", "Store"),
      shiny::br(),
      shiny::h5(shiny::strong("Filter Data")),
      shiny::actionButton("addFilter", "Add filter"),
      shiny::div(id = "placeholderAddRemFilt"),
      shiny::div(id = "placeholderFilter"),
      shiny::br(),
      shiny::h5(shiny::strong("Store Filtered Data")),
      shiny::actionButton("store_data", "Store"),
      shiny::br(),
      shiny::h5(shiny::strong("Re-add Filtered Data Back In")),
      shiny::actionButton("re_add_data", "Re-add")
    ),

    # Output Definitions
    shiny::mainPanel(
      DT::dataTableOutput("filtered_data")
    )
  )
)

# END OF SCRIPT ----
