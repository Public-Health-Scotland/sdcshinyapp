# ------------------------------------------------------------------------------
# Script Name : 4-02_swapping.R
# Purpose     : Perform record swapping for disclosure
# Last Update : 22 Aug 2024
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Update Variable Select Input ----
shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "Disc_Variables_Swap",
    label = "Choose Variables to Swap:",
    choices = cb_options,
    selected = ""
  )
})

# 2. Swapping Logic ----
shiny::observeEvent(input$swapping, {
  if (is.null(input$Disc_Variables_Swap)) {
    shinyalert::shinyalert(
      "No Input Variables Selected",
      "Please select input variables.",
      type = "error"
    )
    shiny::validate(shiny::need(
      input$Disc_Variables_Swap,
      "No input variables selected"
    ))
  }

  if (
    !is.numeric(input$Swap_Cond) ||
      input$Swap_Cond < 1 ||
      input$Swap_Cond %% 1 != 0
  ) {
    shinyalert::shinyalert(
      "Invalid Swapping Condition",
      "Please enter a whole, positive integer for the swapping condition.",
      type = "error"
    )
    shiny::validate(shiny::need(FALSE, "Invalid swapping condition"))
  }

  App_data$values <- sdcshinyapp::Stat_Swap(
    App_data$values,
    input$Disc_Variables_Swap,
    input$Swap_Cond
  )

  shinyalert::shinyalert("Data Successfully Swapped", type = "success")
})

# 3. Data Visualisation ----
output$Swapped_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# END OF SCRIPT ----
