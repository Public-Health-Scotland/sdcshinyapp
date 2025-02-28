### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 3-01_filtering.R
#Purpose: To set up UI for the Filtering Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Filtering Sub-Tab for 2. Input Data Filtering/Formatting Tab
shiny::tabPanel("Filtering",

         #Input and output Definitions
         shiny::fluidRow(

           # Input Definitions
           shiny::sidebarPanel(
             shiny::h5(shiny::strong("Store Unprocessed Data")), # Header to indicate Button for data storage
             shiny::actionButton('Unprocess_Store', 'Store'), # Button to store data prior to filtering
             shiny::br(), # New Line
             shiny::h5(shiny::strong("Filter Data")), # Header to indicate Filter Button
             shiny::actionButton('addFilter', 'Add filter'), # Button to filter Data
             shiny::div(id = 'placeholderAddRemFilt'),
             shiny::div(id = 'placeholderFilter'), # Used to insert UI for Add Filter options
             shiny::br(), # New Line
             shiny::h5(shiny::strong("Store Filtered Data")),
             shiny::actionButton('store_data', 'Store'), #Button to store filtered data
             shiny::br(), # New Line
             shiny::h5(strong("Re-add Filtered Data Back In")),
             shiny::actionButton('re_add_data', 'Re-add') #Button to re-add filtered data back into data frame
             ),

           # Output Definitions
           shiny::mainPanel(DT::dataTableOutput("filtered_data")) # Visualisation of Filtered Data in App
           )
         )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
