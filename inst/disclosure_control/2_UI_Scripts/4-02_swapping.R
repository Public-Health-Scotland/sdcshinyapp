### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 4-02_swapping.R
#Purpose: To set up UI for the Swapping Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Swapping ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Record Swapping", fluid = TRUE,

                ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                ## 1. Input and output Definitions ----
                ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ###
                  ### 1. Sidebar panel for inputs ----
                  ### ### ### ### ### ### ### ###

                  shiny::sidebarPanel(

                    # Choose Variables to Swap
                    shiny::selectInput("Disc_Variables_Swap", label = "Choose Variables to Swap:", choices = "", multiple = TRUE),

                    # Sidebar Panel for Swapping Condition
                    shiny::numericInput("Swap_Cond","Condition for Swapping",value = 10, min = 1, max = 1000),

                    shiny::br(),

                    # Action Button to swap data
                    shiny::h5(shiny::strong("Record Swapping")),
                    shiny::actionButton("swapping", "Swap"),

                    shiny::br(),
                    shiny::br(),
                    shiny::br(),

                    shiny::h4("Swapping Information"),
                    shiny::p("For record swapping, all numbers in the selected variables less than or equal to the swapping condition are swapped.")

                    ),

                  ### ### ### ### ### ### ### ###
                  ### 2. Output Display ----
                  ### ### ### ### ### ### ### ###
                  shiny::mainPanel(

                    # Data Output for processed or unprocessed data
                    DT::dataTableOutput("Swapped_data")

                    )

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
