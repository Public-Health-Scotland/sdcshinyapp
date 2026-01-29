# ------------------------------------------------------------------------------
# Script Name : 2-03_var_convert.R
# Purpose     : Set up UI for the Sub-Tab used to convert variable types
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Variable Conversion Sub-Tab for Input Data Main Tab
shiny::tabPanel(
  "Variable Conversion",
  shiny::fluidRow(
    # Input Panel
    shiny::column(
      width = 3,
      shiny::selectInput(
        inputId = "Variable_Convert",
        label = "Choose Variable to Convert:",
        choices = "",
        multiple = FALSE
      ),
      shiny::br(),
      shiny::h5(shiny::strong("Convert Character Variable to Numeric")),
      shiny::actionButton("char_to_num", "Convert"),
      shiny::br(),
      shiny::h5(shiny::strong("Convert Numeric Variable to Character")),
      shiny::actionButton("num_to_char", "Convert")
    ),

    # Output Panel
    shiny::mainPanel(
      DT::dataTableOutput("convert_data")
    )
  )
)

# END OF SCRIPT ----
