### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 4-01_rounding.R
#Purpose: To set up UI for the Rounding Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Rounding Sub-Tab for 3. SDC Methods Tab
shiny::tabPanel("Rounding",

                #Input and output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::sidebarPanel(
                    shiny::selectInput("Disc_Variables_Round", label = "Choose Variables to Round:", choices = "", multiple = TRUE), # Choose Variables to Round
                    shiny::numericInput("Round_Cond","Condition for Rounding", value = 10, min = 2, max = 1000), # Select Rounding Condition
                    shiny::br(), # New Line
                    shiny::h5(shiny::strong("Rounding")), # Heading indicating Rounding Button
                    shiny::actionButton("rounding", "Round"), # Button to round data
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::h4("Rounding Information"), # Help Text Heading
                    shiny::p("For rounding, all selected variables are rounded to the base set in the Condition for Rounding box.") # Help Text
                    ),

                  # Output Definitions
                  shiny::mainPanel(
                    DT::dataTableOutput("Rounded_data") # Visualisation of Rounded Data in App
                    )
                  )
                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
