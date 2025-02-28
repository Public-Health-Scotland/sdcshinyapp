### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 4-03_suppression.R
#Purpose: To set up UI for the Suppression Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Suppression Sub-Tab for 3. SDC Methods Tab
shiny::tabPanel("Suppression", fluid = TRUE,

                #Input and output Definitions
                shiny::fluidRow(

                  # Input Definitions
                  shiny::sidebarPanel(
                    shiny::selectInput("Disc_Variables_Pri_Supp", label = "Choose Variables for Primary Suppression:", choices = "", multiple = TRUE), # Primary Suppression Variables
                    shiny::selectInput("Disc_Variables_Secondary_Supp", label = "Choose Variables for Secondary Suppression:", choices = "", multiple = TRUE), # Secondary Suppression Variables
                    shiny::numericInput("Pri_Supp_Cond","Condition for Suppression",value = 10, min = 1, max = 1000), # Select Suppression Condition
                    shiny::br(), # New Line
                    shiny::selectInput("Supp_Chars", label = "Choose Character for suppression:", choices = c("c","*"), multiple = FALSE), # Choose Suppression Character
                    shiny::h5(shiny::strong("Choose if zeros should not be suppressed")),
                    shiny::checkboxInput("zero_sup", label = "No zero suppression"), # Checkbox to choose if zero should be suppressed
                    shiny::br(), # New Line
                    shiny::h5(strong("Primary Suppression")),
                    shiny::actionButton("pri_sup", "Suppression"), # Primary Suppression Button
                    shiny::br(), # New Line
                    shiny::h5(shiny::strong("Primary & Secondary Suppression")),
                    shiny::actionButton("pri_sec_sup", "Suppression"), # Primary & Secondary Suppression Button
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::br(), # New Line
                    shiny::h4("Suppression Information"), # Help Text Heading
                    shiny::p("For suppression, all numbers in the selected variables less than or equal to the suppression condition are suppressed. If the checkbox is ticked,
                              then zeros remain unsuppressed. This checkbox works for both types of suppression. For the suppression character, a * is the most
                              commonly used character. For any open data, please use c") # Help Text
                    ),

                  # Output Definitions
                  shiny::mainPanel(
                    DT::dataTableOutput("Suppress_data") # Visualisation of Suppressed Data in App
                    )
                  )
                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
