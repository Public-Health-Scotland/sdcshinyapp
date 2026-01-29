# ------------------------------------------------------------------------------
# Script Name : 5-01_live.R
# Purpose     : Download live data from the app
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Data Reset ----
shiny::observeEvent(input$upload_dat_reset, {
  shiny::validate(shiny::need(data(), "There is no input data"))

  shinyalert::shinyalert("Input data reset to initial state.", type = "success")

  shiny::isolate({
    App_data$values <- data() |>
      dplyr::mutate(Serial = dplyr::row_number()) |>
      dplyr::select(Serial, dplyr::everything())
  })

  # Clear prior settings
  unprocessed$data <- NULL
  removed_values$removed_data <- NULL
  Serial_Removed$data <- NULL
  key_value_header$header <- NULL
  variable_value_header$header <- NULL
  key_value_options$data <- NULL
})

# 2. Data Download ----
output$downloadData <- shiny::downloadHandler(
  filename = function() {
    shiny::validate(shiny::need(App_data$values, "There is no input data"))
    paste0("SDC_", input$upload$name)
  },
  content = function(fname) {
    shiny::validate(shiny::need(App_data$values, "There is no input data"))
    Final <- App_data$values

    file_type <- input$upload$type

    if (file_type == "text/csv") {
      utils::write.csv(Final, fname, row.names = FALSE)
    } else if (
      file_type %in%
        c(
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
          "application/vnd.ms-excel"
        )
    ) {
      Final <- as.data.frame(Final)
      openxlsx::write.xlsx(Final, fname, row.names = FALSE)
    } else {
      utils::write.csv(Final, fname, row.names = FALSE)
    }
  }
)

# END OF SCRIPT ----
