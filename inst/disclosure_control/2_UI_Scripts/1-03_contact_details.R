# ------------------------------------------------------------------------------
# Script Name : 1-03_contact_details.R
# Purpose     : Set up UI for Contact Details Sub-Tab
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Contact Details Sub-Tab for Home Tab
shiny::tabPanel(
  "Contact Details",
  shiny::fluidRow(
    shiny::mainPanel(
      shiny::h1("Contacts"),

      # Statistical Governance
      shiny::h2("Statistical Governance"),
      shiny::p(
        "For questions or issues related to statistical disclosure control, contact Statistical Governance at:"
      ),
      shiny::p("phs.statsgov@phs.scot"),

      # CHI Linkage (CHILI Team)
      shiny::h2("CHI Linkage"),
      shiny::p(
        "For technical queries or questions about this app, contact CHI Linkage at:"
      ),
      shiny::p("phs.chi-recordlinkage@phs.scot")
    )
  )
)

# END OF SCRIPT ----
