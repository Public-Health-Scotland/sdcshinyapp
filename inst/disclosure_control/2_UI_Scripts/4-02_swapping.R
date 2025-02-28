### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 4-02_swapping.R
#Purpose: To set up UI for the Swapping Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Record Swapping Sub-Tab for 3. SDC Methods Tab
shiny::tabPanel("Record Swapping", fluid = TRUE,

                #Input and output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::sidebarPanel(
                    shiny::selectInput("Disc_Variables_Swap", label = "Choose Variables to Swap:", choices = "", multiple = TRUE), # Choose Variables to Swap
                    shiny::numericInput("Swap_Cond","Condition for Swapping", value = 10, min = 1, max = 1000), # Select Swapping Condition
                    shiny::br(), # New Line
                    shiny::h5(shiny::strong("Record Swapping")), # Heading indicating Swapping Button
                    shiny::actionButton("swapping", "Swap"), # Button to swap data
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::h4("Swapping Information"), # Help Text Heading
                    shiny::p("For record swapping, all numbers in the selected variables less than or equal to the swapping condition are swapped.") # Help Text
                    ),

                  # Output Definitions
                  shiny::mainPanel(
                    DT::dataTableOutput("Swapped_data") # Visualisation of Swapped Data in App
                    )
                  )
                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
