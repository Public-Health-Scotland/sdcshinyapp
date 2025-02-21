### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 21 Feb 2025
#By: Robert Mitchell
#Script: 2-02_file_upload.R
#Purpose: Set up UI for the Sub-Tab used for File Upload of Live Data
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create File Upload Sub Tab for 1. Input Data Main Tab
shiny::tabPanel("File Upload",

                # Input and Output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::column(3,
                                shiny::h4(shiny::strong("File Upload (This accepts .csv and .xlsx/.xls files)")), # Header to indicate File Upload
                                shiny::fileInput("upload", NULL, accept = c(".csv", ".tsv", ".xlsx", ".xls")) # File Upload Button
                  ),

                  # Output Definitions
                  shiny::mainPanel(
                    shiny::h1(shiny::strong("Data Information")), # Main Heading for Live Data Information
                    shiny::br(), # New Line
                    shiny::h2(shiny::strong("Data Summary")), # Sub Heading for Training Data Missingness
                    shiny::verbatimTextOutput("upload_summary_dist"), # Summary of Live Data
                  )
                )
)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
