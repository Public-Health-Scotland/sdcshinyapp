# ------------------------------------------------------------------------------
# Script Name : ui.R
# Purpose     : UI setup for the Shiny App
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Set Up App UI
ui <- shiny::fluidPage(
  shiny::navbarPage(
    title = shiny::div(
      shiny::tags$a(
        shiny::img(src = b64, width = 120, alt = "Public Health Scotland logo"),
        href = "https://www.publichealthscotland.scot/",
        target = "_blank"
      ),
      style = "position: relative; top: -10px;"
    ),
    windowTitle = "Statistical Disclosure",

    # Include CSS for App theme
    header = shiny::tags$head(
      shiny::includeCSS(glue::glue("{fp_script}/styles.css"))
    ),

    # Tabs
    source("2_UI_Scripts/1_home_page.R", local = TRUE)$value, # SDC Home Page
    source("2_UI_Scripts/2_data_input.R", local = TRUE)$value, # Data Input Tab
    source("2_UI_Scripts/3_filtering_formatting.R", local = TRUE)$value, # Filtering/Formatting Tab
    source("2_UI_Scripts/4_disclosure_methods.R", local = TRUE)$value, # Disclosure Methods Tab
    source("2_UI_Scripts/5_download.R", local = TRUE)$value # Download Tab
  )
)

# END OF SCRIPT ----
