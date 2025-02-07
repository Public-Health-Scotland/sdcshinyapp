### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 2-04_post_proc_summary.R
#Purpose: To set up UI for the Pre-Processed Data Summary Sub Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. App Data Summary Section
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::tabPanel("Data Summary after processing",

         ### ### ### ### ### ### ### ### ### ### ### ### ### ###
         ## 1. Input and output Definitions ----
         ### ### ### ### ### ### ### ### ### ### ### ### ### ###

         shiny::fluidRow(

           ### ### ### ### ### ### ### ###
           ### 1. Sidebar panel for inputs ----
           ### ### ### ### ### ### ### ###

           shiny::mainPanel(

             # Section Title
             shiny::h1(shiny::strong("Data Information")),

             shiny::br(),

             ### ### ### ### ### ### ### ###
             ### 2. Output Display ----
             ### ### ### ### ### ### ### ###

             shiny::h2(shiny::strong("Data Summary")),
             shiny::verbatimTextOutput("process_summary_dist"),

             shiny::br(),

             # Output: Summary of Missing Values for App data
             shiny::h2(shiny::strong("Percentage of Missing Values for each Variable")),
             shiny::verbatimTextOutput("process_missing") # Shows percentage of missing values by column

           )

         )

)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
