### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 3-02_formatting.R
#Purpose: To set up UI for the Data Formatting Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Transform Format Sub-Tab for 2. Input Data Filtering/Formatting Tab
shiny::tabPanel("Transform Format",

                #Input and output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::sidebarPanel(
                    shiny::h4(shiny::strong("Long to Wide Data Transformation")), # Header for long to wide data transformation section
                    shiny::h5(shiny::strong("Remove Serial Number")), # Header to indicate Button for serial number removal
                    shiny::actionButton('rem_ser', 'Remove'), #Button to remove serial number
                    shiny::br(), # New Line
                    shiny::h5(shiny::strong("Re-add Serial Number")), # Header to indicate Button for serial number being re-added
                    shiny::actionButton('re_add_ser', 'Serial'), # Button to put Serial number back
                    shiny::br(), # New Line
                    shiny::selectInput("keyvariableId", label = "Choose Key Variable", choices = ""), # Key Variable for long to wide transform
                    shiny::selectInput("valuevariableId", label = "Choose Value Variable", choices = ""), # Value Variable for long to wide transform
                    shiny::h5(shiny::strong("Transform Long Data into Wide Data")), # Header to indicate Button for data transformation
                    shiny::actionButton('long_wide_trans', 'Transform'), #Button to transform long long into wide data
                    shiny::h4(shiny::strong("Wide to Long Data Transformation")), # Header for wide to wide data transformation section
                    shiny::h5(shiny::strong("Transform Wide Data into Long Data")), # Header to indicate Button for data transformation
                    shiny::actionButton('wide_long_trans', 'Transform'), #Button to transform wide data back into long data
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::h4("Transform Information"), # Header to indicate help text
                    shiny::p("For the long to wide data transform, if the wrong variables are entered in the data transform stage, go to ", shiny::strong("Tab 5"),
                             "and click the Reset data button. Also, for this stage, the serial number must be removed.") # Help Text
                    ),

                  # Output Definitions
                  shiny::mainPanel(DT::dataTableOutput("format_data")) # Visualisation of Formatted Data in App
                  )
                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
