### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 21 Feb 2025
#By: Robert Mitchell
#Script: 2-03_var_convert.R
#Purpose: Set up UI for the Sub-Tab used to convert variable types
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Variable Conversion Sub Tab for 1. Input Data Main Tab
shiny::tabPanel("Variable Conversion",

                # Input and Output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::column(3,
                                shiny::selectInput("Variable_Convert", label = "Choose Variable to Convert:", choices = "", multiple = FALSE), # Variable Conversion Options
                                shiny::br(), # New Line
                                shiny::h5(shiny::strong("Convert Character Variable to Numeric Variable")), # Sub Heading for Character to Numeric Variable Conversion
                                shiny::actionButton('char_to_num', 'Convert'), # Button for convert character variables to numeric variables
                                shiny::br(), # New Line
                                shiny::h5(shiny::strong("Convert Numeric Variable to Character Variable")), # Sub Heading for Numeric to Character Variable Conversion
                                shiny::actionButton('num_to_char', 'Convert') # Button for convert numeric variables to character variables
                  ),

                  # Output Definitions
                  shiny::mainPanel(DT::dataTableOutput("convert_data")) # Visualisation of Processed Data in App
                )
)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
