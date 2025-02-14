### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 3-02_formatting.R
#Purpose: To transform data format
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Serial Number Removal ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Dataframe to contain removed Serials
Serial_Removed <- shiny::reactiveValues(data=NULL)

# Remove with button press
shiny::observeEvent(

  input$rem_ser, {

    # Ensure that Serial number is in data
    if ("Serial" %notin% colnames(App_data$values)){

      # Error Notification saying that no Serial Number needs to be removed
      shinyalert::shinyalert(title = "No serial number attached to data.",
                             text = "No serial number to remove.",
                             type = "error")

      # Ensures data has Serial Number
      shiny::validate(
        shiny::need(App_data$values$Serial, "There is no Serial Number")
        )

      } else {

        # Notification saying that Serial Number has been removed
        shinyalert::shinyalert(title = "Serial number removed",
                               type = "success")

        }

    #Temp Storage of data prior to Serial Removal
    shiny::isolate({

      temp <- App_data$values

      })

    # Store Serial Numbers
    Serial_Removed$data <- temp |>
      dplyr::select(Serial)

    # Remove Serial Number
    App_data$values <- temp |>
      dplyr::select(-Serial)

    #Clear Temp Storage
    temp <- NULL

    })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 2. Re-add Serial ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Re-add with button press
shiny::observeEvent(

  # Re-add Serial Number with button press
  input$re_add_ser, {

    # Ensure that Serial number has been removed
    if (is.null(Serial_Removed$data)){

      #Error Notification indicate that Serial Number has not been removed
      shinyalert::shinyalert(title = "Serial number has not been removed.",
                             type = "error")

      # Ensures that Serial number has been removed
      shiny::validate(
        shiny::need(Serial_Removed$data, "There is no Serial Number that has been removed")
        )

      # Serial Number has been removed
      } else {}

    # Ensure that the data has the same number of rows as Serial Numbers
    if (nrow(App_data$values) != nrow(Serial_Removed$data)){

      # Error Notification indicating that rows in App data doesn't match number of Serial numbers.
      shinyalert::shinyalert(title = "Number of observations in datasets different to the number of removed serial numbers.",
                             text = "Please ensure that numbers of observation in dataset is the same as number of serial numbers.",
                             type = "error")

      # Checks that number of rows in datasets equals the number of serial numbers
      shiny::validate(
        shiny::need(nrow(App_data$values) == nrow(Serial_Removed$data),
                    "The stored serial numbers have a different number of rows to data frame"
                    ))

      } else {

        #Notification indicating that Serial number has been re-added
        shinyalert::shinyalert(title = "Serial number successfully re-added.",
                               type = "success")
        }

    # Re-add Serial number
    App_data$values <- App_data$values|>
      cbind(Serial_Removed$data) |>
      dplyr::select(Serial,dplyr::everything())

    # Clear Stored Serial Number
    Serial_Removed$data <- NULL

    })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 3. Updates Selectboxes ----
# Updates key and value variable select boxes prior to data transformation
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Allows select input Box to be updated with variable names for key variable
shiny::observe({

  # Stores all variable names in App data apart from Serial - this function is in a external script
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "keyvariableId",
                    label = "Choose Key Variable",
                    choices = cb_options,
                    selected = "")

  })


# Allows select input Box to be updated with variable names for value variable
shiny::observe({

  # Update Selectbox
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  shiny::updateSelectInput(session, "valuevariableId",
                    label = "Choose Value Variable",
                    choices = cb_options,
                    selected = "")

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 4. Store Variables ----
# This stores variables prior to data transformation
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Store key value options
key_value_options <- shiny::reactiveValues(data=NULL)

# Store key value name
key_value_header <- shiny::reactiveValues(header=NULL)

# Store variable value name
variable_value_header <- shiny::reactiveValues(header=NULL)

# Store Column Names in original order
column_values <- shiny::reactiveValues(order=NULL)

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 5. Long to Wide Transformation ----
# This transforms long data to wide data with button press
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::observeEvent(

  # Transform with button press
  input$long_wide_trans, {

    # Ensure that key & value variable is entered
    if (input$keyvariableId == "" & input$valuevariableId == ""){

      # Error Notification indicating no key and value variable
      shinyalert::shinyalert(title = "There is no key or value variable selected",
                             text = "Please select key variable and value variable.",
                             type = "error")

      # Ensure that key & value variable is entered
      shiny::validate(
        shiny::need(input$keyvariableId , "There is no key variable"),
        shiny::need(input$valuevariableId , "There is no value variable")
        )

      # Ensure that value variable is entered
    } else if (input$keyvariableId != "" & input$valuevariableId == ""){

      # Error Notification indicating no value variable
      shinyalert::shinyalert(title = "There is no value variable selected",
                             text = "Please select value variable.",
                             type = "error")

      # Ensure that value variable is entered
      shiny::validate(
        shiny::need(input$valuevariableId , "There is no value variable")
        )

      # Ensure that key variable is entered
      } else if (input$keyvariableId == "" & input$valuevariableId != "") {

        # Error Notification indicating no key variable
        shinyalert::shinyalert(title = "There is no key variable selected",
                               text = "Please select key variable.",
                               type = "error")

        # Ensure that key variable is entered
        shiny::validate(
          shiny::need(input$keyvariableId , "There is no key variable")
          )
        # All variables entered
      } else {}

    #Unformatted Data Storage
    shiny::isolate({

      temp_format <- App_data$values

      })

    # Key Variable
    key_value_header$header <- input$keyvariableId

    #Value Variable
    variable_value_header$header <- input$valuevariableId

    # Key Value Options
    key_value_options$data <- unique(temp_format[,input$keyvariableId])
    key_value_options$data <- data.frame(key_value_options$data)
    names(key_value_options$data)[names(key_value_options$data) == "orig_var"] <- input$keyvariableId
    key_value_options$data  <- key_value_options$data |>
      dplyr::pull()

    # Column Header - Used to put data frame columns back to original order for transforming back to long data
    column_values$order <- colnames(temp_format)

    # Transforms long to wide - generates error notification if transformation is unsuccessful
    tryCatch(

      # Checks for error - if no error, this then performs the transformation
      expr = {App_data$values <- temp_format |>
        tidyr::spread(input$keyvariableId,input$valuevariableId)

      shinyalert::shinyalert(title = "Long to wide transformation successful",
                             type = "success")},

      error = function(e)
        shinyalert::shinyalert(title = "Transformation Unsuccessful. Please reset data.",
                               type = "error")
      )

    # Clear Unformatted data
    temp_format <- NULL

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 6. Wide to Long Transform ----
# Only used when Long to Wide Transformation has occured
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Transform data with button press
shiny::observeEvent(

  # Transform with button press
  input$wide_long_trans, {

    # Ensures that long data has been transformed to wide data via the App
    if (is.null(key_value_header$header) & is.null(variable_value_header$header)){

      # Error notification indicates that long data has not been transformed
      shinyalert::shinyalert(title = "Long data has not been transformed to wide data",
                             text = "To transform back to wide data, please transform the long data to wide data first",
                             type = "error")

      # Ensure that long to wide transformation has occured
      shiny::validate(
        shiny::need(key_value_header$header, "There is no key variable"),
        shiny::need(variable_value_header$header, "There is no value variable")
        )

      # Long data has been transformed to wide - re-transform to long data can occur
      } else {}


    #Unformatted Data Storage
    shiny::isolate({

      temp_wide_format <- App_data$values

    })

    # Convert to character so that these values become options under the key value column header
    key_value_options$data <- as.character(key_value_options$data)

    # Convert wide data back to long data
    # Transforms wide to long - generates error notification if transformation is unsuccessful
    # For data transform back to long, column headers are re-ordered to the same order as before.
    tryCatch(

      # Checks for error - if no error, this then performs the transformation
      expr = {App_data$values <- temp_wide_format |>
        tidyr::gather_(key_value_header$header,variable_value_header$header,key_value_options$data) |>
        dplyr::select(all_of(column_values$order))

      shinyalert::shinyalert(title = "Wide to long transform successful",
                             type = "success")},
      error = function(e)
        shinyalert::shinyalert("Transformation Unsuccessful. Please reset data.",type = "error")
      )

    # Clear options for wide to long transform
    key_value_header$header <- NULL
    variable_value_header$header <- NULL
    key_value_options$data <- NULL
    column_values$order <- NULL
    temp_wide_format <- NULL

    })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 7. Data Visualisation ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

output$format_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')

  # Data visualisation is achieved via a function inside a external script.
  Format_Data <- sdcshinyapp::Table_Render(App_data$values,cb)

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
