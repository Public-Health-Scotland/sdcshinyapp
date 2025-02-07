### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 3-01_filtering.R
#Purpose: To set up UI for the Filtering Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Filtering Section ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Filtering",

         ### ### ### ### ### ### ### ### ### ### ### ### ### ###
         ## 1. Input and output Definitions ----
         ### ### ### ### ### ### ### ### ### ### ### ### ### ###
         shiny::fluidRow(

           ### ### ### ### ### ### ### ###
           ### 1. Sidebar panel for inputs ----
           ### ### ### ### ### ### ### ###
           shiny::sidebarPanel(

             # Button to store data prior to filtering
             shiny::h5(shiny::strong("Store Unprocessed Data")),
             shiny::actionButton('Unprocess_Store', 'Store'),

             shiny::br(),


             # Button to filter Data
             shiny::h5(shiny::strong("Filter Data")),
             shiny::actionButton('addFilter', 'Add filter'),

             shiny::div(id = 'placeholderAddRemFilt'),

             shiny::div(id = 'placeholderFilter'),

             shiny::br(),

             #Button to store filtered data
             shiny::h5(shiny::strong("Store Filtered Data")),
             shiny::actionButton('store_data', 'Store'),

             shiny::br(),


             #Button to re-add filtered data back into data frame
             shiny::h5(strong("Re-add Filtered Data Back In")),
             shiny::actionButton('re_add_data', 'Re-add')

           ),

           ### ### ### ### ### ### ### ###
           ### 2. Output Display ----
           ### ### ### ### ### ### ### ###

           shiny::mainPanel(DT::dataTableOutput("filtered_data"))

           )

         )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
