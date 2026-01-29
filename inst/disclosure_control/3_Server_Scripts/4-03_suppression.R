# ------------------------------------------------------------------------------
# Script Name : 4-03_suppression.R
# Purpose     : Perform suppression on data for disclosure
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Update Variable Select Inputs ----
shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "Disc_Variables_Pri_Supp",
    "Choose Variables for Primary Suppression:",
    cb_options,
    ""
  )
})

shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "Disc_Variables_Secondary_Supp",
    "Choose Variables for Secondary Suppression:",
    cb_options,
    ""
  )
})

# 2. Suppression Logic ----

## Primary Suppression
shiny::observeEvent(input$pri_sup, {
  if (is.null(input$Disc_Variables_Pri_Supp)) {
    shinyalert::shinyalert(
      "No input variables selected",
      "Please select input variables.",
      type = "error"
    )
    shiny::validate(shiny::need(
      input$Disc_Variables_Pri_Supp,
      "No variables selected for primary suppression"
    ))
  }

  # Validate Pri_Supp_Cond is a positive whole integer
  if (
    is.null(input$Pri_Supp_Cond) ||
      !is.numeric(input$Pri_Supp_Cond) ||
      input$Pri_Supp_Cond <= 0 ||
      input$Pri_Supp_Cond %% 1 != 0
  ) {
    shinyalert::shinyalert(
      "Invalid suppression condition",
      "Primary suppression condition must be a positive whole number.",
      type = "error"
    )
    shiny::validate(shiny::need(FALSE, "Invalid primary suppression condition"))
  }

  App_data$values <- sdcshinyapp::Stat_Primary_Supress(
    App_data$values,
    input$Disc_Variables_Pri_Supp,
    input$Supp_Chars,
    input$Pri_Supp_Cond,
    input$zero_sup
  )

  shinyalert::shinyalert("Primary Suppression successful.", type = "success")
})


## Primary & Secondary Suppression
shiny::observeEvent(input$pri_sec_sup, {
  if (
    is.null(input$Disc_Variables_Pri_Supp) ||
      is.null(input$Disc_Variables_Secondary_Supp) ||
      length(input$Disc_Variables_Pri_Supp) != 1 ||
      length(input$Disc_Variables_Secondary_Supp) < 2
  ) {
    shinyalert::shinyalert(
      "Invalid selection for suppression",
      "Select exactly one variable for primary and at least two for secondary suppression.",
      type = "error"
    )
    shiny::validate(
      shiny::need(
        input$Disc_Variables_Pri_Supp,
        "No primary suppression variable selected"
      ),
      shiny::need(
        length(input$Disc_Variables_Pri_Supp) == 1,
        "Select exactly one primary suppression variable"
      ),
      shiny::need(
        input$Disc_Variables_Secondary_Supp,
        "No secondary suppression variables selected"
      ),
      shiny::need(
        length(input$Disc_Variables_Secondary_Supp) >= 2,
        "Select at least two secondary suppression variables"
      )
    )
  }

  # Validate Pri_Supp_Cond is a positive whole integer
  if (
    is.null(input$Pri_Supp_Cond) ||
      !is.numeric(input$Pri_Supp_Cond) ||
      input$Pri_Supp_Cond <= 0 ||
      input$Pri_Supp_Cond %% 1 != 0
  ) {
    shinyalert::shinyalert(
      "Invalid suppression condition",
      "Primary suppression condition must be a positive whole number.",
      type = "error"
    )
    shiny::validate(shiny::need(FALSE, "Invalid primary suppression condition"))
  }

  # Ensure primary suppression variable is not in secondary suppression variables
  if (input$Disc_Variables_Pri_Supp %in% input$Disc_Variables_Secondary_Supp) {
    shinyalert::shinyalert(
      "Variable overlap detected",
      "Primary suppression variable must not be included in secondary suppression variables.",
      type = "error"
    )
    shiny::validate(shiny::need(
      FALSE,
      "Primary suppression variable is also selected for secondary suppression"
    ))
  }

  App_data$values <- sdcshinyapp::Stat_Secondary_Supress(
    App_data$values,
    input$Disc_Variables_Pri_Supp,
    input$Disc_Variables_Secondary_Supp,
    input$Supp_Chars,
    input$Pri_Supp_Cond,
    input$zero_sup
  )

  shinyalert::shinyalert(
    "Primary & secondary suppression successful.",
    type = "success"
  )
})


# 3. Data Visualisation ----
output$Suppress_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# END OF SCRIPT ----
