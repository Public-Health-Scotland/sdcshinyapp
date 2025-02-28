### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 5_download.R
#Purpose: To set up UI for the Download Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create 4. Download Data Tab
shiny::tabPanel("4. Download Data", fluid = TRUE,

                #Input and output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::sidebarPanel(
                    shiny::h4(shiny::strong("File Download/Data Reset")),shiny::h5(shiny::strong("Reset Uploaded Data")), # Heading indicating data reset button
                    shiny::actionButton("upload_dat_reset", "Reset"), # Button to reset Uploaded data back to original state
                    shiny::br(), # New Line
                    shiny::h5(shiny::strong("Reset Training Data")), # Heading indicating data reset button
                    shiny::actionButton("training_dat_reset", "Reset"), # Button to reset Training data back to original state
                    shiny::br(), # New Line
                    shiny::h5(shiny::strong("Download Data")), # Download Button Heading
                    shiny::downloadButton("downloadData", label = "Download") # Download Processed Data
                    ),

                  # Output Definitions
                  shiny::mainPanel(
                    DT::dataTableOutput("Final_data") # Visualisation of Final Data in App
                    )
                  )
                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
