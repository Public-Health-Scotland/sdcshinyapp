# ------------------------------------------------------------------------------
# Script Name : 2-01_dummy_data_choice.R
# Purpose     : Set up UI for the Sub-Tab used for the selection of Dummy Data
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Training Data Sub-Tab for Input Data Main Tab
shiny::tabPanel(
  "Training Data",
  shiny::fluidRow(
    # Input Panel
    shiny::column(
      width = 3,
      shiny::h4("Use Training Data"),
      shiny::actionButton("use_train", label = "Use Training Data"),
      shiny::br(),
      shiny::selectInput(
        inputId = "train_data_select",
        label = "Choose Dataset",
        choices = c("Wide Data", "Long Data")
      )
    ),

    # Output Panel
    shiny::mainPanel(
      shiny::h1(shiny::strong("Data Information")),
      shiny::br(),
      shiny::h2(shiny::strong("Data Summary")),
      shiny::verbatimTextOutput("Train_summary_dist"),
      shiny::br(),
      shiny::h2(shiny::strong(
        "Percentage of Missing Values for each Variable"
      )),
      shiny::verbatimTextOutput("Train_summary_missing")
    )
  )
)

# END OF SCRIPT ----
