### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 21 Feb 2025
#By: Robert Mitchell
#Script: 2-04_post_proc_summary.R
#Purpose: Set up UI for the Sub-Tab used to visualise Data Summary after processing
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Data Summary after processing Sub Tab for 1. Input Data Main Tab
shiny::tabPanel("Data Summary after processing",

                # Input and Output Definitions
                shiny::fluidRow(

                  # Output Definitions
                  shiny::mainPanel(
                    shiny::h1(shiny::strong("Data Information")), # Main Section Title
                    shiny::br(), # New Line
                    shiny::h2(shiny::strong("Data Summary")), # Sub Heading for Data Summary
                    shiny::verbatimTextOutput("process_summary_dist"), # Visualisation of Processed Data in App
                    shiny::br(),  # New Line
                    shiny::h2(shiny::strong("Percentage of Missing Values for each Variable")), # Sub Heading for Missing Data Summary
                    shiny::verbatimTextOutput("process_missing") # Visualisation of Missing Data in App
                  )
                )
)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
