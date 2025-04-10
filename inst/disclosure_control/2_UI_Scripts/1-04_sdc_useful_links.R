### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 1-04_sdc_useful_links.R
#Purpose: To set up UI for Sub-Tab Containing Useful Web Links
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Stores Text for Useful Links Page ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Useful Links for SDC Sub-Tab for Home Tab
shiny::tabPanel("Useful Links for SDC",

                shiny::fluidRow(

                  # Displaying all text
                  shiny::mainPanel(

                    shiny::h2("Useful Public Health Scotland Links"), # Main Title

             # 1. Useful Web Links ----
             shiny::p("For further information please see",
                      shiny::a(href = "http://spark.publichealthscotland.org/corporate-guidance/statistical-governance/statistical-disclosure-control/",
                               "Statistical Disclosure Control - Statistical Governance - Corporate guidance - The Spark (publichealthscotland.org)"),
                      "and always complete your ", shiny::a(href = "http://spark.publichealthscotland.org/downloads/disclosure-risk-assessment-form/",
                      "Disclosure risk assessment form - Downloads - The Spark (publichealthscotland.org)"), "when considering disclosure control.")
             )
             )
             )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
