### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 21 Feb 2025
#By: Robert Mitchell
#Script: 2-01_dummy_data_choice.R
#Purpose: Set up UI for the Sub-Tab used for the selection of Dummy Data
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Training Data Sub Tab for 1. Input Data Main Tab
shiny::tabPanel("Training Data",

                # Input and Output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::column(3,
                                shiny::h4("Use Training Data"), # Header to indicate use training data
                                shiny::actionButton("use_train", label = "Use Training Data"), # Button to select training data
                                shiny::br(), # New Line
                                shiny::selectInput("train_data_select", label = "Choose Dataset",
                                                   choices = c("Wide Data","Long Data")) # Select Training Data
                  ),

                  # Output Definitions
                  shiny::mainPanel(
                    shiny::h1(shiny::strong("Data Information")), # Main Heading for Training Data Information
                    shiny::br(), # New Line
                    shiny::h2(shiny::strong("Data Summary")), # Sub Heading for Training Data Summary
                    shiny::verbatimTextOutput("Train_summary_dist"), # Summary of Training Data
                    shiny::br(), # New Line
                    shiny::h2(strong("Percentage of Missing Values for each Variable")), # Sub Heading for Training Data Missingness
                    shiny::verbatimTextOutput("Train_summary_missing") # Percentage of missing values by column
                  )
                )
)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
