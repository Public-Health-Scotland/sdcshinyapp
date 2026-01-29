# ------------------------------------------------------------------------------
# Script Name : 1-01_app_instruction_text.R
# Purpose     : To set up UI for App Instruction Sub Tab
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# R Version   : 4.4.2
# ------------------------------------------------------------------------------

# App Instructions Sub-Tab for Home Tab
shiny::tabPanel(
  "App Instructions",
  shiny::fluidRow(
    shiny::mainPanel(
      shiny::h1("Statistical Disclosure Control App Instructions"),

      # Initial Information
      shiny::p(
        "To perform statistical disclosure, the variable must be numeric and contain only whole numbers."
      ),
      shiny::p(
        "This app includes training data to help users understand SDC and its features."
      ),
      shiny::br(),

      # Step 1 - File Upload/Data Processing
      shiny::h2("Step 1 - File Upload/Data Processing"),
      shiny::h3("Step 1a - Training Data Choice"),
      shiny::p(
        "This step is for first-time users. In Tab 1, choose training data and click the ",
        shiny::strong("Use Training Data"),
        " button. If not using training data, skip to Step 1b."
      ),
      shiny::h3("Step 1b - File Upload"),
      shiny::p(
        "In Tab 1, click the browse button to upload a file. A data summary and missing data table will appear after upload."
      ),
      shiny::h3("Step 1c - Data Processing"),
      shiny::p(
        "To convert variables, use the ",
        shiny::strong("Choose Variable to Convert"),
        " select box and click a convert button to transform variables to numeric or character."
      ),

      # Step 2 - Data Filtering/Formatting
      shiny::h2("Step 2 - Data Filtering/Formatting"),
      shiny::p(
        "In Tab 2, filtering/formatting is optional. If filtering is needed on multiple variables, repeat Step 2 after Step 4."
      ),
      shiny::h3("Step 2a - Filtering"),
      shiny::p(
        "Click ",
        shiny::strong("Store Unprocessed Data"),
        ", then ",
        shiny::strong("Add Filter"),
        ". Choose variables and values to remove. Use ",
        shiny::strong("Clear Filter"),
        " to reset. Click ",
        shiny::strong("Store Filtered Data"),
        " to save filtered data."
      ),
      shiny::h3("Step 2b - Formatting"),
      shiny::p(
        "To convert long to wide format, remove serial number using ",
        shiny::strong("Remove Serial Number"),
        ". Select key and value variables, then click ",
        shiny::strong("Transform long data into wide data"),
        "."
      ),

      # Step 3 - Disclosure Control
      shiny::h2("Step 3 - Disclosure Control"),
      shiny::p("All disclosure methods are in ", shiny::strong("Tab 3"), "."),
      shiny::h3("Step 3a - Rounding"),
      shiny::p(
        "Select variables to round, enter value in ",
        shiny::strong("Condition for Rounding"),
        ", and click ",
        shiny::strong("Round"),
        "."
      ),
      shiny::h3("Step 3b - Record Swapping"),
      shiny::p(
        "Select variables to swap, enter value in ",
        shiny::strong("Condition for Swapping"),
        ", and click ",
        shiny::strong("Swap"),
        "."
      ),
      shiny::h3("Step 3c - Suppression"),
      shiny::p("If no suppression is needed, move to Tab 2 for Step 4."),
      shiny::p(
        "To skip zero suppression, tick ",
        shiny::strong("No zero suppression"),
        ". Choose suppression character in ",
        shiny::strong("Choose Character for Suppression"),
        "."
      ),
      shiny::h4("1. Primary Suppression"),
      shiny::p(
        "Select variables, enter value in ",
        shiny::strong("Condition for Suppression"),
        ", and click ",
        shiny::strong("Suppress"),
        "."
      ),
      shiny::h4("2. Primary & Secondary Suppression"),
      shiny::p(
        "Select variables for both primary and secondary suppression, enter value, and click ",
        shiny::strong("Suppress"),
        "."
      ),

      # Step 4 - Re-add Filtered/Reformatted Data
      shiny::h3("Step 4 - Re-add Filtered/Reformatted Data"),
      shiny::p(
        "To revert wide to long format, click ",
        shiny::strong("Transform wide data into long data"),
        " in Tab 2. To re-add filtered data, click ",
        shiny::strong("Re-add Serial Number"),
        " and then ",
        shiny::strong("Re-add Filtered Data"),
        ". Finally, click ",
        shiny::strong("Remove Serial Number"),
        " to clean the final file."
      ),

      # Step 5 - Download Data
      shiny::h3("Step 5 - Download Data"),
      shiny::p(
        "In Tab 1, use the data summary tab to verify formatting. If errors occurred, click ",
        shiny::strong("Reset Uploaded Data"),
        " or ",
        shiny::strong("Reset Training Data"),
        " and restart from Step 2."
      ),
      shiny::p(
        "If everything looks correct, click the download button and save the file."
      )
    )
  )
)

# END OF SCRIPT ----
