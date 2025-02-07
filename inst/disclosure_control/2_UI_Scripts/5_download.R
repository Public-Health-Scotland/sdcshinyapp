### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 5_download.R
#Purpose: To set up UI for the Download Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Data Download ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("4. Download Data", fluid = TRUE,

                ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                ## 1. Input and output Definitions ----
                ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ###
                  ### 1. Sidebar panel for inputs ----
                  ### ### ### ### ### ### ### ###

                  shiny::sidebarPanel(

                    shiny::h4(shiny::strong("File Download/Data Reset")),

                    #Action Button to ensure that data can be transferred back to it's original state
                    shiny::h5(shiny::strong("Reset Uploaded Data")),
                    shiny::actionButton("upload_dat_reset", "Reset"),

                    shiny::br(),

                    #Action Button to ensure that data can be transferred back to it's original state
                    shiny::h5(shiny::strong("Reset Training Data")),
                    shiny::actionButton("training_dat_reset", "Reset"),

                    shiny::br(),

                    # Download button to download processed data
                    shiny::h5(shiny::strong("Download Data")),
                    shiny::downloadButton("downloadData", label = "Download")

                    ),

                  ### ### ### ### ### ### ### ###
                  ### 2. Output Display ----
                  ### ### ### ### ### ### ### ###

                  shiny::mainPanel(

                    # Data Output for processed or unprocessed data

                    DT::dataTableOutput("Final_data")

                    )

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
