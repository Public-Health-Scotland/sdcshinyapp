### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 1-03_contact_details.R
#Purpose: To set up UI for Sub Tab containing important contact details
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Stores Text for Contact Details Page ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Contact Details",

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                  ## 1. Main panel for displaying outputs ----
                  # Stores Text for Help Page
                  ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                  shiny::mainPanel(

                    ### ### ### ### ### ### ### ###
                    ### 1. Main Page Title ----
                    ### ### ### ### ### ### ### ###

                    shiny::h1("Contacts"),

                    ### ### ### ### ### ### ### ###
                    ### 2. Statistical Governance Contact Details  ----
                    ### ### ### ### ### ### ### ###

                    shiny::h2("Statistical Governance"),

                    shiny::p("If you have any questions or issues in relation to statistical disclosure control, please contact Statistical Governance at phs.statsgov@phs.scot"),

                    ### ### ### ### ### ### ### ###
                    ### 3. CHI Linkage (CHILI Team) Contact Details  ----
                    ### ### ### ### ### ### ### ###

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
