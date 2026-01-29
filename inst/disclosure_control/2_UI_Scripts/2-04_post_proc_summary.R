# ------------------------------------------------------------------------------
# Script Name : 2-04_post_proc_summary.R
# Purpose     : UI for Sub-Tab to visualise Data Summary after processing
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

shiny::tabPanel(
  "Data Summary after processing",
  shiny::fluidRow(
    # Output Panel
    shiny::mainPanel(
      shiny::h1(shiny::strong("Data Information")),
      shiny::br(),
      shiny::h2(shiny::strong("Data Summary")),
      shiny::verbatimTextOutput("process_summary_dist"),
      shiny::br(),
      shiny::h2(shiny::strong(
        "Percentage of Missing Values for each Variable"
      )),
      shiny::verbatimTextOutput("process_missing")
    )
  )
)

# END OF SCRIPT ----
