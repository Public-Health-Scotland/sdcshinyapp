# ------------------------------------------------------------------------------
# Script Name : 4-02_swapping.R
# Purpose     : UI for Swapping Sub-Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Record Swapping Sub-Tab for 3. SDC Methods Tab
shiny::tabPanel(
  "Record Swapping",
  fluid = TRUE,
  shiny::fluidRow(
    # Input Definitions
    shiny::sidebarPanel(
      shiny::selectInput(
        "Disc_Variables_Swap",
        label = "Choose Variables to Swap:",
        choices = "",
        multiple = TRUE
      ),
      shiny::numericInput(
        "Swap_Cond",
        "Condition for Swapping",
        value = 10,
        min = 1,
        max = 1000
      ),
      shiny::br(),
      shiny::h5(shiny::strong("Record Swapping")),
      shiny::actionButton("swapping", "Swap"),
      shiny::br(),
      shiny::br(),
      shiny::br(),
      shiny::h4("Swapping Information"),
      shiny::p(
        "For record swapping, all numbers in the selected variables less than or equal to the swapping condition are swapped."
      )
    ),

    # Output Definitions
    shiny::mainPanel(
      DT::dataTableOutput("Swapped_data")
    )
  )
)

# END OF SCRIPT ----
