### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 4-03_suppression.R
#Purpose: To set up UI for the Suppression Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Suppression ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Suppression", fluid = TRUE,

                ### ### ### ### ### ### ### ### ### ### ### ### ### ###
                ## 1. Input and output Definitions ----
                ### ### ### ### ### ### ### ### ### ### ### ### ### ###

                shiny::fluidRow(

                  ### ### ### ### ### ### ### ###
                  ### 1. Sidebar panel for inputs ----
                  ### ### ### ### ### ### ### ###
                  shiny::sidebarPanel(

                    # Primary Suppression Variables
                    shiny::selectInput("Disc_Variables_Pri_Supp", label = "Choose Variables for Primary Suppression:", choices = "", multiple = TRUE),

                    # Secondary Suppression Variables
                    shiny::selectInput("Disc_Variables_Secondary_Supp", label = "Choose Variables for Secondary Suppression:", choices = "", multiple = TRUE),

                    # Sidebar Panel for Suppresion Conditions
                    shiny::numericInput("Pri_Supp_Cond","Condition for Suppression",value = 10, min = 1, max = 1000),

                    shiny::br(),

                    # Choose Suppression Characters
                    shiny::selectInput("Supp_Chars", label = "Choose Character for suppression:", choices = c("c","*"), multiple = FALSE),

                    # Checkbox to ensure that zeros are not suppressed
                    shiny::h5(shiny::strong("Choose if zeros should not be suppressed")),
                    shiny::checkboxInput("zero_sup", label = "No zero suppression"),

                    shiny::br(),

                    #Action Button for Primary Suppression
                    shiny::h5(strong("Primary Suppression")),
                    shiny::actionButton("pri_sup", "Suppression"),

                    shiny::br(),

                    #Action Button for Primary & Secondary Suppression
                    shiny::h5(shiny::strong("Primary & Secondary Suppression")),
                    shiny::actionButton("pri_sec_sup", "Suppression"),

                    shiny::br(),
                    shiny::br(),
                    shiny::br(),

                    shiny::h4("Suppression Information"),
                    shiny::p("For suppression, all numbers in the selected variables less than or equal to the suppression condition are suppressed. If the checkbox is ticked,
                              then zeros remain unsuppressed. This checkbox works for both types of suppression. For the suppression character, a * is the most
                              commonly used character. For any open data, please use c")

                    ),

                  ### ### ### ### ### ### ### ###
                  ### 2. Output Display ----
                  ### ### ### ### ### ### ### ###
                  shiny::mainPanel(

                    # Data Output for processed or unprocessed data
                    DT::dataTableOutput("Suppress_data")

                    )

                  )

                )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
