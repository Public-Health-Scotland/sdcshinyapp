### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 3-01_filtering.R
#Purpose: To filter data
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 1. Data Storage ----
## This is for storing data prior to filtering
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Allows unfiltered data to be stored
unprocessed <- shiny::reactiveValues(data=NULL)

# Store unfiltered data with button press
shiny::observeEvent(

  input$Unprocess_Store, {

    # Ensures input data is provided
    shiny::validate(
      need(App_data$values, "There is no input data")

    )

    # Message if no Serial variable is Provided
    if ("Serial" %notin% colnames(App_data$values)){

      # Error Notification
      shinyalert::shinyalert(title = "No serial number provided.", text = "Please re-add serial number for storage.", type = "error")

      # Validation to ensure that data has Serial Number
      shiny::validate(
        shiny::need(App_data$values$Serial, "There is no Serial Number")
      )

    } else {

      # Notification to indicate that data is successfully stored prior to filtering
      shinyalert::shinyalert("Unprocessed data stored successfully.", "Filtering can now occur.", type = "success")

    }

    # Data stored prior to filtering
    unprocessed$data <- App_data$values

  })


### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 2. Filtering Process ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Initial Empty Filter
filter <- character(0)

# Sets up filter
shiny::makeReactiveBinding("aggregFilterObserver")
aggregFilterObserver <- list() # Initial empty list for filtered variables

# Allows a filter to be added to data due to button press
shiny::observeEvent(input$addFilter, {

  # Ensures that this only works when data is provided
  shiny::validate(
    shiny::need(App_data$values, "There is no input data")
  )

  # Checks if no Unprocessed data is stored and serial number is removed
  if (is.null(unprocessed$data) & ("Serial" %notin% colnames(App_data$values))){

    # Error Notification to re-add serial and to store unprocessed data
    shinyalert::shinyalert(title = "No Unprocessed data stored & Serial number removed from dataset.",
                           text = "Please re-add serial number first and then press the Store Unprocessed Data button.",
                           type = "error")

    # Ensures that the unprocessed data is stored and Serial number is given.
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number"),
      shiny::need(unprocessed$data, "There is no input data")
    )

    # Checks if data isn't stored prior to filtering
  } else if (is.null(unprocessed$data) & ("Serial" %in% colnames(App_data$values))) {

    # Error Notification to store data prior to filtering
    shinyalert::shinyalert(title = "No Unprocessed data stored.",
                           text = "Press the Store Unprocessed Data button.",
                           type = "error")

    # Ensures that the unfiltered data is stored.
    shiny::validate(
      shiny::need(unprocessed$data, "There is no input data")
    )

    # Check if serial number has been removed
  } else if (!is.null(unprocessed$data) & ("Serial" %notin% colnames(App_data$values))) {

    # Error Notification to re-add Serial number
    shinyalert::shinyalert(title = "Serial number removed from dataset.",
                           text = "Please re-add serial number.",
                           type = "error")

    # Ensures that the unfiltered data is stored.
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number")
    )

    # Filtering can occur
  } else {}

  # Set up id for filtering, variable to be filtered, values to be removed and a clear filter option
  add <- input$addFilter

  filterId <- paste0('Filter_', add)

  colfilterId <- paste0('Col_Filter_', add) # Columns to filter
  rowfilterId <- paste0('Row_Filter_', add) # Variable values to remove
  clearFilterId <- paste0('Clear_Filter_', add) #Clear Filter after it has been done

  # Extract all column names apart from Serial number
  headers <- names(App_data$values)
  headers <- headers[2:length(headers)]

  # Sets up ui for variable filtering
  shiny::insertUI(
    selector = '#placeholderFilter',
    ui = shiny::tags$div(id = filterId,
                         shiny::actionButton(clearFilterId, label = "Clear filter", style = "float: right;"),
                         shiny::selectInput(colfilterId, label = "Choose Variable", choices = as.list(headers)),
                         shiny::selectInput(rowfilterId, label = "Select variable values to remove",
                                            choices = NULL, selected = NULL, multiple = TRUE)
    )
  )

  # Updates values to be removed based on variable chosen
  shiny::observeEvent(input[[colfilterId]], {

    col <- input[[colfilterId]]
    values <- as.list(unique(App_data$values[col]))[[1]]

    shiny::updateSelectInput(session, rowfilterId , label = "Select variable values to remove",
                             choices = values, selected = NULL)

    aggregFilterObserver[[filterId]]$col <<- col
    aggregFilterObserver[[filterId]]$rows <<- NULL
  })

  # Filters Rows
  shiny::observeEvent(input[[rowfilterId]], {

    rows <- input[[rowfilterId]]
    aggregFilterObserver[[filterId]]$rows <<- rows

  })

  # Remove UI added by Add Filter Button - press clear filter button to do so.
  shiny::observeEvent(input[[clearFilterId]], {

    shiny::removeUI(selector = paste0('#', filterId))
    aggregFilterObserver[[filterId]] <<- NULL

  })

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 3. Data Visualisation ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

output$filtered_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')
  dataSet <- App_data$values

  # Filtering applied to App data
  invisible(lapply(aggregFilterObserver, function(filter){

    dataSet <- dataSet[which(!(dataSet[[filter$col]] %in% filter$rows)), ]

  }))

  App_data$values <- dataSet

  # Data visualisation is achieved via a function inside a external script.
  Filter_Data <- sdcshinyapp::Table_Render(App_data$values,cb)

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 4. Storage of removed data ----
## This is due to filtering
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Allows removed data to be stored
removed_values <- reactiveValues(removed_data=NULL)

# Store removed values with button press
shiny::observeEvent(

  input$store_data, {

    # Checks that App data has Serial number
    if ("Serial" %notin% colnames(App_data$values)){

      # Error Notification to re-add Serial number
      shinyalert::shinyalert(title = "No serial number attached to data.",
                             text = "Please re-add serial number for storage.",
                             type = "error")

      # Ensures data has Serial Number
      shiny::validate(
        shiny::need(App_data$values$Serial, "There is no Serial Number")
      )

      # App Data has Serial Number
    } else{}

    # Check if data is stored prior to filtering
    if (is.null(unprocessed$data)){

      # Error Notification to check if data is stored
      shinyalert::shinyalert(title = "No Unprocessed data stored.",
                             text = "Please press the Store Unprocessed Data button.",
                             type = "error")

      # Ensures that data is stored prior to filtering.
      shiny::validate(
        shiny::need(unprocessed$data, "There is no input data")
      )

    } else {

      # Notification indicates that data is successfully stored prior to filtering
      shinyalert::shinyalert(title = "Filtered data successfully stored",
                             type = "success")

    }

    # Stored data removed via filtering
    removed_values$removed_data <- unprocessed$data |>
      dplyr::anti_join(App_data$values, by = "Serial")

    # Clears data stored prior to filtering
    unprocessed$data <- NULL

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 5. Re-add Removed Data ----
## This re-adds removed data due to filtering with a button press.
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Add removed values with button press
shiny::observeEvent(

  input$re_add_data, {

    # Ensure that removed data is there and serial number is there
    if (is.null(removed_values$removed_data) & ("Serial" %notin% colnames(App_data$values))){

      # Error Notification to filter data and re-add serial number
      shinyalert::shinyalert(title = "There is no filtered values stored and no serial number attached to data",
                             text = "Please re-add serial number and press the store filtered values button",
                             type = "error")

      # Ensure that removed data is there and Serial number is given
      shiny::validate(
        shiny::need(App_data$values$Serial, "There is no Serial Number"),
        shiny::need(removed_values$removed_data, "There is no filtered values removed"
        ))

      # Ensure that removed data is there
    } else if (is.null(removed_values$removed_data) & ("Serial" %in% colnames(App_data$values))) {

      # Error Notification to store removed data via filtering
      shinyalert::shinyalert(title = "There is no filtered values stored.",
                             text = "Press the store filtered values button.",
                             type = "error")

      # Ensure that removed data is there
      shiny::validate(
        shiny::need(removed_values$removed_data, "There is no filtered values removed")
      )

      # Ensure that Serial number is there
    } else if(!is.null(removed_values$removed_data) & ("Serial" %notin% colnames(App_data$values))){

      # Error Notification to re-add Serial number
      shinyalert::shinyalert(title = "There is no serial number attached to the data.",
                             text = "Please re-add serial number",
                             type = "error")

      # Ensure that Serial number is given
      shiny::validate(
        shiny::need(App_data$values$Serial, "There is no Serial Number")
      )

    } else {

      shinyalert::shinyalert(title = "Filtered data successfully re-added.",
                             type = "success")

    }

    # Store Data prior to re-adding removed filtering data
    isolate({

      temp <- App_data$values

    })

    # Read Filtered Data
    App_data$values <- rbind(temp, removed_values$removed_data)|>
      dplyr::arrange(Serial)

    # Clear Stored data after re-added to dataset.
    removed_values$removed_data <- NULL
    temp <- NULL

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
