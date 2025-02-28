### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 1-03_contact_details.R
#Purpose: To set up UI for Sub Tab containing important contact details
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Contact Details Sub-Tab for Home Tab
shiny::tabPanel("Contact Details",

                shiny::fluidRow(

                  # Displaying all text
                  shiny::mainPanel(

                    shiny::h1("Contacts"), # Main Title

                    # 1. Statistical Governance ----
                    shiny::h2("Statistical Governance"),

                    shiny::p("If you have any questions or issues in relation to statistical disclosure control, please contact Statistical Governance at phs.statsgov@phs.scot"),

                    # 2. CHI Linkage (CHILI Team) ----
                    shiny::h2("CHI Linkage"),

                    shiny::p("If you have any technical queries or questions in relation to this App, please contact CHI Linkage at phs.chi-recordlinkage@phs.scot")
                    )
                  )
                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
