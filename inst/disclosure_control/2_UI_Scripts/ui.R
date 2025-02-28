### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 01 Oct 2024
#By: Robert Mitchell
#Script: ui.R
#Purpose: To set up the UI for the Shiny App
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Set Up App UI
ui <- shiny::fluidPage(
  # Navigation Bar
  shiny::navbarPage(title = shiny::div(shiny::tags$a(shiny::img(src=b64, width=120, alt = "Public Health Scotland logo"),
                                                     href= "https://www.publichealthscotland.scot/",
                                                     target = "_blank"),
                                       style = "position: relative; top: -10px;"),

                    # Window Title for Stand-alone website
                    windowTitle = "Statistical Disclosure",

                    # css file for App theme
                    header = shiny::tags$head(shiny::includeCSS(glue::glue("{fp_script}/styles.css"))),

                    # 1. SDC Home Page ----
                    source("2_UI_Scripts/1_home_page.R",  local = TRUE)$value,

                    #2. Data Input Tab ----
                    source("2_UI_Scripts/2_data_input.R",  local = TRUE)$value,

                    # 3. Input Data Filtering/Formatting Tab ----
                    source("2_UI_Scripts/3_filtering_formatting.R",  local = TRUE)$value,

                    # 4. Disclosure Methods Tab ----
                    source("2_UI_Scripts/4_disclosure_methods.R",  local = TRUE)$value,

                    # 5. Download Tab ----
                    source("2_UI_Scripts/5_download.R",  local = TRUE)$value
                    )
  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
