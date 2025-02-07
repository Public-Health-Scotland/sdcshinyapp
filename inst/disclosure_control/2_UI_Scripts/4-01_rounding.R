### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 4-01_rounding.R
#Purpose: To set up UI for the Rounding Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Rounding ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Rounding",

                ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                ## 1. Input and output Definitions ----
                ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ###
                  ### 1. Sidebar panel for inputs ----
                  ### ### ### ### ### ### ### ###

                  shiny::sidebarPanel(

                    # Choose Variables to Round
                    shiny::selectInput("Disc_Variables_Round", label = "Choose Variables to Round:", choices = "", multiple = TRUE),

                    # Sidebar Panel for Rounding Condition
                    shiny::numericInput("Round_Cond","Condition for Rounding",value = 10, min = 1, max = 1000),

                    shiny::br(),

                    # Action Button to round data
                    shiny::h5(shiny::strong("Rounding")),
                    shiny::actionButton("rounding", "Round"),

                    shiny::br(),
                    shiny::br(),
                    shiny::br(),

                    # Help Text
                    shiny::h4("Rounding Information"),
                    shiny::p("For rounding, all selected variables are rounded to the base set in the Condition for Rounding box.")

                    ),

                  ### ### ### ### ### ### ### ###
                  ### 2. Output Display ----
                  ### ### ### ### ### ### ### ###

                  shiny::mainPanel(

                    # Data Output for processed or unprocessed data
                    DT::dataTableOutput("Rounded_data")

                    )

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
