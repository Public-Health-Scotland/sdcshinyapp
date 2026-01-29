# ------------------------------------------------------------------------------
# Script Name : 2-03_var_convert.R
# Purpose     : Variable conversion (character ↔ numeric)
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Update Select Input with Variable Names ----
shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "Variable_Convert",
    "Choose Variables to Convert:",
    choices = cb_options,
    selected = ""
  )
})

# 2. Character to Numeric Conversion ----
shiny::observeEvent(input$char_to_num, {
  shiny::validate(shiny::need(App_data$values, "There is no Input Data"))

  if (input$Variable_Convert == "") {
    shinyalert::shinyalert(
      "There is no input variable selected",
      "Please select input variable.",
      type = "error"
    )
    shiny::validate(shiny::need(
      input$Variable_Convert,
      "No Variables are selected"
    ))
  }

  temp_char <- shiny::isolate(App_data$values)
  converted_value <- suppressWarnings(as.numeric(temp_char[[
    input$Variable_Convert
  ]]))

  if (all(is.na(converted_value))) {
    shinyalert::shinyalert(
      "Conversion Error",
      "The selected variable could not be converted to numeric.",
      type = "error"
    )
    shiny::validate(shiny::need(converted_value, "No Variables converted"))
  }

  App_data$values[[input$Variable_Convert]] <- converted_value
  shinyalert::shinyalert(
    "Variable converted to a numeric format",
    type = "success"
  )
})

# 3. Numeric to Character Conversion ----
shiny::observeEvent(input$num_to_char, {
  shiny::validate(shiny::need(App_data$values, "There is no Input Data"))

  if (input$Variable_Convert == "") {
    shinyalert::shinyalert(
      "There is no input variable selected",
      "Please select input variable.",
      type = "error"
    )
    shiny::validate(shiny::need(
      input$Variable_Convert,
      "No Variables are selected"
    ))
  }

  temp_num <- shiny::isolate(App_data$values)
  converted_value <- suppressWarnings(as.character(temp_num[[
    input$Variable_Convert
  ]]))

  if (all(is.na(converted_value))) {
    shinyalert::shinyalert(
      "Conversion Error",
      "The selected variable could not be converted to character.",
      type = "error"
    )
    shiny::validate(shiny::need(converted_value, "No Variables converted"))
  }

  App_data$values[[input$Variable_Convert]] <- converted_value
  shinyalert::shinyalert(
    "Variable converted to a character format",
    type = "success"
  )
})

# 4. Data Visualisation ----
output$convert_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# END OF SCRIPT ----
