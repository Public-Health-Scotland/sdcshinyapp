# ------------------------------------------------------------------------------
# Script Name : 3-01_filtering.R
# Purpose     : Filter data in Shiny app
# Last Update : 01 Sep 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Setup and Initialisation ----

# Allows unfiltered data to be stored
unprocessed <- shiny::reactiveValues(data = NULL)

# 2. Store Unprocessed Data ----

shiny::observeEvent(input$Unprocess_Store, {
  shiny::validate(
    shiny::need(App_data$values, "There is no input data")
  )

  if (!"Serial" %in% colnames(App_data$values)) {
    shinyalert::shinyalert(
      title = "No serial number attached to data.",
      text = "Please re-add serial number for storage.",
      type = "error"
    )
    return()
  }

  shinyalert::shinyalert(
    title = "Unprocessed data stored successfully.",
    text = "Filtering can now occur.",
    type = "success"
  )

  unprocessed$data <- App_data$values
})

# 3. Add Filter UI Dynamically ----

# Initial Empty Filter
filter <- character(0)

# Sets up reactive filter observer
shiny::makeReactiveBinding("aggregFilterObserver")
aggregFilterObserver <- list()

# Observe Add Filter button
shiny::observeEvent(input$addFilter, {
  # Validate input data
  shiny::validate(
    shiny::need(App_data$values, "There is no input data")
  )

  serial_exists <- "Serial" %in% colnames(App_data$values)
  unprocessed_exists <- !is.null(unprocessed$data)

  # Error handling logic
  if (!unprocessed_exists && !serial_exists) {
    shinyalert::shinyalert(
      "No Unprocessed data stored. Serial number removed from dataset.",
      "Please re-add serial number first and then press the Store Unprocessed Data button.",
      type = "error"
    )
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number"),
      shiny::need(unprocessed$data, "There is no input data")
    )
    return()
  }

  if (!unprocessed_exists && serial_exists) {
    shinyalert::shinyalert(
      "No Unprocessed data stored.",
      "Press the Store Unprocessed Data button.",
      type = "error"
    )
    shiny::validate(
      shiny::need(unprocessed$data, "There is no input data")
    )
    return()
  }

  if (unprocessed_exists && !serial_exists) {
    shinyalert::shinyalert(
      "Serial number removed from dataset.",
      "Please re-add serial number.",
      type = "error"
    )
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number")
    )
    return()
  }

  # Setup filter UI IDs
  add <- input$addFilter
  filterId <- paste0("Filter_", add)
  colfilterId <- paste0("Col_Filter_", add)
  rowfilterId <- paste0("Row_Filter_", add)
  clearFilterId <- paste0("Clear_Filter_", add)

  # Extract column headers excluding Serial
  headers <- setdiff(names(App_data$values), "Serial")

  # Insert filter UI
  shiny::insertUI(
    selector = "#placeholderFilter",
    ui = tags$div(
      id = filterId,
      shiny::actionButton(
        clearFilterId,
        label = "Clear filter",
        style = "float: right;"
      ),
      shiny::selectInput(
        colfilterId,
        label = "Choose Variable",
        choices = headers
      ),
      shiny::selectInput(
        rowfilterId,
        label = "Select variable values to remove",
        choices = NULL,
        selected = NULL,
        multiple = TRUE
      )
    )
  )

  # Update variable values based on selected column
  shiny::observeEvent(input[[colfilterId]], {
    col <- input[[colfilterId]]
    values <- unique(App_data$values[[col]])

    shiny::updateSelectInput(
      session,
      rowfilterId,
      label = "Select variable values to remove",
      choices = values,
      selected = NULL
    )

    aggregFilterObserver[[filterId]]$col <<- col
    aggregFilterObserver[[filterId]]$rows <<- NULL
  })

  # Store selected rows to remove
  shiny::observeEvent(input[[rowfilterId]], {
    aggregFilterObserver[[filterId]]$rows <<- input[[rowfilterId]]
  })

  # Clear filter UI and observer
  shiny::observeEvent(input[[clearFilterId]], {
    shiny::removeUI(selector = paste0("#", filterId))
    aggregFilterObserver[[filterId]] <<- NULL
  })
})


# 4. Render Filtered Data Table ----

output$filtered_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  original_data <- App_data$values
  filtered_data <- Reduce(
    function(data, filter) {
      if (!is.null(filter$col) && !is.null(filter$rows)) {
        data <- data[!(data[[filter$col]] %in% filter$rows), ]
      }
      data
    },
    aggregFilterObserver,
    init = original_data
  )

  App_data$values <- filtered_data
  sdcshinyapp::Table_Render(filtered_data, cb)
})


# 5. Storage of removed data via Filtering ----

# Reactive storage for removed data
removed_values <- reactiveValues(removed_data = NULL)

# Store removed values with button press
shiny::observeEvent(input$store_data, {
  serial_exists <- "Serial" %in% colnames(App_data$values)
  unprocessed_exists <- !is.null(unprocessed$data)

  # Error handling
  if (!serial_exists || !unprocessed_exists) {
    shinyalert::shinyalert(
      title = if (!serial_exists) {
        "No serial number attached to data."
      } else {
        "No Unprocessed data stored."
      },
      text = if (!serial_exists) {
        "Please re-add serial number for storage."
      } else {
        "Please press the Store Unprocessed Data button."
      },
      type = "error"
    )
    return()
  }

  # Success notification
  shinyalert::shinyalert(
    title = "Filtered data successfully stored",
    type = "success"
  )

  # Store removed data by comparing with filtered dataset
  removed_values$removed_data <- dplyr::anti_join(
    unprocessed$data,
    App_data$values,
    by = "Serial"
  )

  # Clear unprocessed data after storing removed values
  unprocessed$data <- NULL
})

# 6. Re-add Filtered Data ----

shiny::observeEvent(input$re_add_data, {
  serial_exists <- "Serial" %in% colnames(App_data$values)
  removed_exists <- !is.null(removed_values$removed_data)

  # Error handling
  if (!removed_exists && !serial_exists) {
    shinyalert::shinyalert(
      "There is no filtered values stored and no serial number attached to data",
      "Please re-add serial number and press the store filtered values button",
      type = "error"
    )
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number"),
      shiny::need(
        removed_values$removed_data,
        "There is no filtered values removed"
      )
    )
    return()
  }

  if (!removed_exists && serial_exists) {
    shinyalert::shinyalert(
      "There is no filtered values stored.",
      "Press the store filtered values button.",
      type = "error"
    )
    shiny::validate(
      shiny::need(
        removed_values$removed_data,
        "There is no filtered values removed"
      )
    )
    return()
  }

  if (removed_exists && !serial_exists) {
    shinyalert::shinyalert(
      "There is no serial number attached to the data.",
      "Please re-add serial number",
      type = "error"
    )
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number")
    )
    return()
  }

  # Success message
  shinyalert::shinyalert(
    "Filtered data successfully re-added.",
    type = "success"
  )

  # Re-add filtered data
  shiny::isolate({
    temp <- App_data$values

    # Identify character columns in temp
    char_cols <- names(temp)[sapply(temp, is.character)]

    # Coerce matching columns in removed_values$removed_data to character
    removed_values$removed_data[char_cols] <- lapply(
      removed_values$removed_data[char_cols],
      as.character
    )

    # Bind and arrange
    App_data$values <- dplyr::bind_rows(temp, removed_values$removed_data) |>
      dplyr::arrange(Serial)

    # Clear stored removed data
    removed_values$removed_data <- NULL
  })
})

# END OF SCRIPT ----
