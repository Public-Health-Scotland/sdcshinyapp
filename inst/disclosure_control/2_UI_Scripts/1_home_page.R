# ------------------------------------------------------------------------------
# Script Name : 1_home_page.R
# Purpose     : Set up UI for Home Page Main Tab
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# R Version   : 4.4.2
# ------------------------------------------------------------------------------

# Home Tab UI ----
shiny::tabPanel(
  title = "Home",
  shiny::navlistPanel(
    id = "tabset",
    widths = sb_width,

    # Sub-tabs
    source("2_UI_Scripts/1-01_app_instruction_text.R", local = TRUE)$value,
    source("2_UI_Scripts/1-02_sdc_theory_text.R", local = TRUE)$value,
    source("2_UI_Scripts/1-03_contact_details.R", local = TRUE)$value,
    source("2_UI_Scripts/1-04_sdc_useful_links.R", local = TRUE)$value
  )
)

# END OF SCRIPT ----
