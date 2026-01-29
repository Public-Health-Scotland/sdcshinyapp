# ------------------------------------------------------------------------------
# Script Name : 4-01_rounding.R
# Purpose     : Perform rounding on data for disclosure
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Update Variable Select Input ----
shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "Disc_Variables_Round",
    label = "Choose Variables to Round:",
    choices = cb_options,
    selected = ""
  )
})

# 2. Rounding Logic ----
shiny::observeEvent(input$rounding, {
  if (is.null(input$Disc_Variables_Round)) {
    shinyalert::shinyalert(
      "No variables selected",
      "Please select input variables.",
      type = "error"
    )
    shiny::validate(shiny::need(
      input$Disc_Variables_Round,
      "No variables selected for rounding"
    ))
  }

  if (
    !is.numeric(input$Round_Cond) ||
      input$Round_Cond <= 1 ||
      input$Round_Cond %% 1 != 0
  ) {
    shinyalert::shinyalert(
      "Invalid rounding condition",
      "Please enter a whole, positive integer greater than one.",
      type = "error"
    )
    shiny::validate(shiny::need(FALSE, "Invalid rounding condition"))
  }

  App_data$values <- sdcshinyapp::Stat_Round(
    App_data$values,
    input$Disc_Variables_Round,
    input$Round_Cond
  )

  shinyalert::shinyalert("Data successfully rounded.", type = "success")
})

# 3. Data Visualisation ----
output$Rounded_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# END OF SCRIPT ----
