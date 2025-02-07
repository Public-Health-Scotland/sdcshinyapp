### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 3-02_formatting.R
#Purpose: To set up UI for the Data Formatting Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Data Format Transform Section ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Transform Format",

                ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                ## 1. Input and output Definitions ----
                ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ###
                  ### 1. Sidebar panel for inputs ----
                  ### ### ### ### ### ### ### ###

                  shiny::sidebarPanel(

                    shiny::h4(shiny::strong("Long to Wide Data Transformation")),

                    #Button to remove serial number
                    shiny::h5(shiny::strong("Remove Serial Number")),
                    shiny::actionButton('rem_ser', 'Remove'),

                    shiny::br(),

                    #Button to put Serial number back
                    shiny::h5(shiny::strong("Re-add Serial Number")),
                    shiny::actionButton('re_add_ser', 'Serial'),

                    shiny::br(),

                    # Key Variable for long to wide transform
                    shiny::selectInput("keyvariableId", label = "Choose Key Variable", choices = ""),

                    # Value Variable for long to wide transform
                    shiny::selectInput("valuevariableId", label = "Choose Value Variable", choices = ""),

                    #Button to transform long data into wide data
                    shiny::h5(shiny::strong("Transform Long Data into Wide Data")),
                    shiny::actionButton('long_wide_trans', 'Transform'),

                    shiny::h4(shiny::strong("Wide to Long Data Transformation")),

                    #Button to transform wide data back into long data
                    shiny::h5(shiny::strong("Transform Wide Data into Long Data")),
                    shiny::actionButton('wide_long_trans', 'Transform'),

                    shiny::br(),
                    shiny::br(),
                    shiny::br(),

                    # Help Text
                    shiny::h4("Transform Information"),
                    shiny::p("For the long to wide data transform, if the wrong variables are entered in the data transform stage, go to ", shiny::strong("Tab 5"),
                             "and click the Reset data button. Also, for this stage, the serial number must be removed.")

                    ),

                  ### ### ### ### ### ### ### ###
                  ### 2. Output Display ----
                  ### ### ### ### ### ### ### ###

                  shiny::mainPanel(DT::dataTableOutput("format_data"))

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
