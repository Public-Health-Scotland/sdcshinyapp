# ------------------------------------------------------------------------------
# Script Name : 3-02_formatting.R
# Purpose     : UI for Data Formatting Sub-Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Transform Format Sub-Tab for 2. Input Data Filtering/Formatting Tab
shiny::tabPanel(
  "Transform Format",
  shiny::fluidRow(
    # Input Definitions
    shiny::sidebarPanel(
      shiny::h4(shiny::strong("Long to Wide Data Transformation")),
      shiny::h5(shiny::strong("Remove Serial Number")),
      shiny::actionButton("rem_ser", "Remove"),
      shiny::br(),
      shiny::h5(shiny::strong("Re-add Serial Number")),
      shiny::actionButton("re_add_ser", "Serial"),
      shiny::br(),
      shiny::selectInput("keyvariableId", "Choose Key Variable", choices = ""),
      shiny::selectInput(
        "valuevariableId",
        "Choose Value Variable",
        choices = ""
      ),
      shiny::h5(shiny::strong("Transform Long Data into Wide Data")),
      shiny::actionButton("long_wide_trans", "Transform"),
      shiny::h4(shiny::strong("Wide to Long Data Transformation")),
      shiny::h5(shiny::strong("Transform Wide Data into Long Data")),
      shiny::actionButton("wide_long_trans", "Transform"),
      shiny::br(),
      shiny::br(),
      shiny::br(),
      shiny::h4("Transform Information"),
      shiny::p(
        "For the long to wide data transform, if the wrong variables are entered, go to ",
        shiny::strong("Tab 5"),
        " and click the Reset data button. Also, the serial number must be removed before this step."
      )
    ),

    # Output Definitions
    shiny::mainPanel(
      DT::dataTableOutput("format_data")
    )
  )
)

# END OF SCRIPT ----
