### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 2-03_var_convert.R
#Purpose: To set up UI for the Variable Conversion Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Data Process - Variable Conversion ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
shiny::tabPanel("Variable Conversion",

                ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                ## 1. Input and output Definitions ----
                ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ###
                  ### 1. Sidebar panel for inputs ----
                  ### ### ### ### ### ### ### ###

                  shiny::column(3,

                  # Choose Variable to Convert
                  shiny::selectInput("Variable_Convert", label = "Choose Variable to Convert:", choices = "", multiple = FALSE),

                  shiny::br(),

                  #Button to convert character variable to numeric variable
                  shiny::h5(shiny::strong("Convert Character Variable to Numeric Variable")),
                  shiny::actionButton('char_to_num', 'Convert'),

                  shiny::br(),

                  #Button to convert numeric variable to character variable
                  shiny::h5(shiny::strong("Convert Numeric Variable to Character Variable")),
                  shiny::actionButton('num_to_char', 'Convert')

                  ),

                  ### ### ### ### ### ### ### ###
                  ### 2. Output Display ----
                  ### ### ### ### ### ### ### ###

                  shiny::mainPanel(DT::dataTableOutput("convert_data"))

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
