### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 2-01_dummy_data_choice.R
#Purpose: To set up UI for the Dummy Data Selection Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Dummy Data Choice Page ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Training Data",

         ### ### ### ### ### ### ### ### ### ### ### ### ### ###
         ## 1. Input and output Definitions ----
         ### ### ### ### ### ### ### ### ### ### ### ### ### ###

         shiny::fluidRow(

           ### ### ### ### ### ### ### ###
           ### 1. Sidebar panel for inputs ----
           ### ### ### ### ### ### ### ###

           shiny::column(3,

                         shiny::h4("Use Training Data"),

                         # Input - Disable Training Data Section
                         shiny::actionButton("use_train", label = "Use Training Data"),

                         shiny::br(),

                         # Input: Select a file
                         shiny::selectInput("train_data_select", label = "Choose Dataset", choices = c("Wide Data","Long Data"))

                         ),

           ### ### ### ### ### ### ### ###
           ### 2. Output Display ----
           ### ### ### ### ### ### ### ###

           shiny::mainPanel(

             # Section Title
             shiny::h1(shiny::strong("Data Information")),

             shiny::br(),

             # Output: Summary of distribution for File Input
             shiny::h2(shiny::strong("Data Summary")),
             verbatimTextOutput("Train_summary_dist"),

             shiny::br(),

             # Output: Summary of Missing Values for File Input
             shiny::h2(strong("Percentage of Missing Values for each Variable")),
             verbatimTextOutput("Train_summary_missing") # Shows percentage of missing values by column

             )

           )

         )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
