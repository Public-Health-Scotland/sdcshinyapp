### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: 1_home_page.R
#Purpose: To set up UI for Home Page Main Tab
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Create Home Tab ----
shiny::tabPanel(#tags$head(tags$style(HTML(".selectize-input {border: 1px solid #3F3685;}"))), #controls SelectInput boxes border color

         title = "Home",

         shiny::navlistPanel(id = "tabset", widths = sb_width,

           # 1. App Instruction Sub-Tab ----
           source("2_UI_Scripts/1-01_app_instruction_text.R",  local = TRUE)$value,

           # 2. SDC Theory Sub-Tab ----
           source("2_UI_Scripts/1-02_sdc_theory_text.R",  local = TRUE)$value,

           # 3. Contact Details Sub-Tab ----
           source("2_UI_Scripts/1-03_contact_details.R",  local = TRUE)$value,

           # 4. Useful Links Sub-Tab ----
           source("2_UI_Scripts/1-04_sdc_useful_links.R",  local = TRUE)$value
           )
         )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
