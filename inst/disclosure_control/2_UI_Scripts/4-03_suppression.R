# ------------------------------------------------------------------------------
# Script Name : 4-03_suppression.R
# Purpose     : UI for Suppression Sub-Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Suppression Sub-Tab for 3. SDC Methods Tab
shiny::tabPanel(
  "Suppression",
  fluid = TRUE,
  shiny::fluidRow(
    # Input Definitions
    shiny::sidebarPanel(
      shiny::selectInput(
        "Disc_Variables_Pri_Supp",
        label = "Choose Variables for Primary Suppression:",
        choices = "",
        multiple = TRUE
      ),
      shiny::selectInput(
        "Disc_Variables_Secondary_Supp",
        label = "Choose Variables for Secondary Suppression:",
        choices = "",
        multiple = TRUE
      ),
      shiny::numericInput(
        "Pri_Supp_Cond",
        "Condition for Suppression",
        value = 10,
        min = 1,
        max = 1000
      ),
      shiny::br(),
      shiny::selectInput(
        "Supp_Chars",
        label = "Choose Character for suppression:",
        choices = c("c", "*"),
        multiple = FALSE
      ),
      shiny::h5(shiny::strong("Choose if zeros should not be suppressed")),
      shiny::checkboxInput("zero_sup", label = "No zero suppression"),
      shiny::br(),
      shiny::h5(shiny::strong("Primary Suppression")),
      shiny::actionButton("pri_sup", "Suppression"),
      shiny::br(),
      shiny::h5(shiny::strong("Primary & Secondary Suppression")),
      shiny::actionButton("pri_sec_sup", "Suppression"),
      shiny::br(),
      shiny::br(),
      shiny::br(),
      shiny::h4("Suppression Information"),
      shiny::p(
        "For suppression, all numbers in the selected variables less than or equal to the suppression condition are suppressed. ",
        "If the checkbox is ticked, then zeros remain unsuppressed. This applies to both types of suppression. ",
        "For the suppression character, '*' is most commonly used. For open data, please use 'c'."
      )
    ),

    # Output Definitions
    shiny::mainPanel(
      DT::dataTableOutput("Suppress_data")
    )
  )
)

# END OF SCRIPT ----
