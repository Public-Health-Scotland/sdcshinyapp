# ------------------------------------------------------------------------------
# Script Name : 4-01_rounding.R
# Purpose     : UI for Rounding Sub-Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Rounding Sub-Tab for 3. SDC Methods Tab
shiny::tabPanel(
  "Rounding",
  shiny::fluidRow(
    # Input Definitions
    shiny::sidebarPanel(
      shiny::selectInput(
        "Disc_Variables_Round",
        label = "Choose Variables to Round:",
        choices = "",
        multiple = TRUE
      ),
      shiny::numericInput(
        "Round_Cond",
        "Condition for Rounding",
        value = 10,
        min = 2,
        max = 1000
      ),
      shiny::br(),
      shiny::h5(shiny::strong("Rounding")),
      shiny::actionButton("rounding", "Round"),
      shiny::br(),
      shiny::br(),
      shiny::br(),
      shiny::h4("Rounding Information"),
      shiny::p(
        "For rounding, all selected variables are rounded to the base set in the Condition for Rounding box."
      )
    ),

    # Output Definitions
    shiny::mainPanel(
      DT::dataTableOutput("Rounded_data")
    )
  )
)

# END OF SCRIPT ----
