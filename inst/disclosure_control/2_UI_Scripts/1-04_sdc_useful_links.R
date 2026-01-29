# ------------------------------------------------------------------------------
# Script Name : 1-04_sdc_useful_links.R
# Purpose     : Set up UI for Useful Links Sub-Tab
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Useful Links Sub-Tab for Home Tab
shiny::tabPanel(
  "Useful Links for SDC",
  shiny::fluidRow(
    shiny::mainPanel(
      shiny::h2("Useful Public Health Scotland Links"),
      shiny::p(
        "For further information, please see the ",
        shiny::a(
          href = "http://spark.publichealthscotland.org/corporate-guidance/statistical-governance/statistical-disclosure-control/",
          "Statistical Disclosure Control - Statistical Governance - Corporate Guidance"
        ),
        " page on The Spark."
      ),
      shiny::p(
        "Always complete your ",
        shiny::a(
          href = "http://spark.publichealthscotland.org/downloads/disclosure-risk-assessment-form/",
          "Disclosure Risk Assessment Form"
        ),
        " when considering disclosure control."
      )
    )
  )
)

# END OF SCRIPT ----
