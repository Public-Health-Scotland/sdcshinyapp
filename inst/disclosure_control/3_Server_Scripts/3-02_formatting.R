# ------------------------------------------------------------------------------
# Script Name : 3-02_formatting.R
# Purpose     : Transform data format (long ↔ wide)
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Serial Number Removal ----
Serial_Removed <- shiny::reactiveValues(data = NULL)

shiny::observeEvent(input$rem_ser, {
  if (!"Serial" %in% colnames(App_data$values)) {
    shinyalert::shinyalert(
      "No serial number attached to data.",
      "No serial number to remove.",
      type = "error"
    )
    shiny::validate(shiny::need(
      App_data$values$Serial,
      "There is no Serial Number"
    ))
  }

  shinyalert::shinyalert("Serial number removed", type = "success")
  temp <- shiny::isolate(App_data$values)
  Serial_Removed$data <- temp |> dplyr::select(Serial)
  App_data$values <- temp |> dplyr::select(-Serial)
})

# 2. Re-add Serial Number ----
shiny::observeEvent(input$re_add_ser, {
  if (is.null(Serial_Removed$data)) {
    shinyalert::shinyalert(
      "Serial number has not been removed.",
      type = "error"
    )
    shiny::validate(shiny::need(
      Serial_Removed$data,
      "No Serial Number to re-add"
    ))
  }

  if (nrow(App_data$values) != nrow(Serial_Removed$data)) {
    shinyalert::shinyalert(
      "Mismatch in row counts",
      "Ensure row counts match before re-adding Serial.",
      type = "error"
    )
    shiny::validate(shiny::need(
      nrow(App_data$values) == nrow(Serial_Removed$data),
      "Row count mismatch"
    ))
  }

  shinyalert::shinyalert(
    "Serial number successfully re-added.",
    type = "success"
  )
  App_data$values <- cbind(Serial_Removed$data, App_data$values) |>
    dplyr::select(Serial, dplyr::everything())
  Serial_Removed$data <- NULL
})

# 3. Update Select Inputs ----
shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "keyvariableId",
    "Choose Key Variable",
    choices = cb_options,
    selected = ""
  )
})

shiny::observe({
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)
  shiny::updateSelectInput(
    session,
    "valuevariableId",
    "Choose Value Variable",
    choices = cb_options,
    selected = ""
  )
})

# 4. Store Variables ----
key_value_options <- shiny::reactiveValues(data = NULL)
key_value_header <- shiny::reactiveValues(header = NULL)
variable_value_header <- shiny::reactiveValues(header = NULL)
column_values <- shiny::reactiveValues(order = NULL)

# 5. Long to Wide Transformation ----
shiny::observeEvent(input$long_wide_trans, {
  if (input$keyvariableId == "" || input$valuevariableId == "") {
    shinyalert::shinyalert(
      "Missing selection",
      "Please select both key and value variables.",
      type = "error"
    )
    shiny::validate(
      shiny::need(input$keyvariableId, "No key variable"),
      shiny::need(input$valuevariableId, "No value variable")
    )
  }

  temp_format <- shiny::isolate(App_data$values)
  key_value_header$header <- input$keyvariableId
  variable_value_header$header <- input$valuevariableId

  key_value_options$data <- unique(temp_format[[input$keyvariableId]]) |>
    as.character()
  column_values$order <- colnames(temp_format)

  tryCatch(
    {
      App_data$values <- temp_format |>
        tidyr::spread(input$keyvariableId, input$valuevariableId)
      shinyalert::shinyalert(
        "Long to wide transformation successful",
        type = "success"
      )
    },
    error = function(e) {
      shinyalert::shinyalert(
        "Transformation Unsuccessful. Please reset data.",
        type = "error"
      )
    }
  )
})

# 6. Wide to Long Transformation ----
shiny::observeEvent(input$wide_long_trans, {
  if (
    is.null(key_value_header$header) || is.null(variable_value_header$header)
  ) {
    shinyalert::shinyalert(
      "Transformation Error",
      "Please perform long to wide transformation first.",
      type = "error"
    )
    shiny::validate(
      shiny::need(key_value_header$header, "No key variable"),
      shiny::need(variable_value_header$header, "No value variable")
    )
  }

  temp_wide_format <- shiny::isolate(App_data$values)

  tryCatch(
    {
      App_data$values <- temp_wide_format |>
        tidyr::gather_(
          key_value_header$header,
          variable_value_header$header,
          key_value_options$data
        ) |>
        dplyr::select(all_of(column_values$order))

      shinyalert::shinyalert(
        "Wide to long transform successful",
        type = "success"
      )
    },
    error = function(e) {
      shinyalert::shinyalert(
        "Transformation Unsuccessful. Please reset data.",
        type = "error"
      )
    }
  )

  key_value_header$header <- NULL
  variable_value_header$header <- NULL
  key_value_options$data <- NULL
  column_values$order <- NULL
})

# 7. Data Visualisation ----
output$format_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# END OF SCRIPT ----
