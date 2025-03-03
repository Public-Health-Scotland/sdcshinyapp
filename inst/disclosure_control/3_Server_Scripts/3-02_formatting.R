### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 3-02_formatting.R
#Purpose: To transform data format
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Serial Number Removal ----

# Dataframe for removed Serials
Serial_Removed <- shiny::reactiveValues(data=NULL)

## 1. Remove with button press ----
shiny::observeEvent(input$rem_ser, {

  # Stop if Serial variable in Data
  if ("Serial" %notin% colnames(App_data$values)){

    # Error Notification
    shinyalert::shinyalert(title = "No serial number attached to data.",
                           text = "No serial number to remove.",
                           type = "error")

    # Validation
    shiny::validate(shiny::need(App_data$values$Serial, "There is no Serial Number"))

    }

  # Notification saying that Serial Number has been removed
  shinyalert::shinyalert(title = "Serial number removed", type = "success")

  #Temp Storage of data prior to Serial Removal
  shiny::isolate({temp <- App_data$values})

  # Store Serial Numbers
  Serial_Removed$data <- temp |>
    dplyr::select(Serial)

  # Remove Serial Number
  App_data$values <- temp |>
    dplyr::select(-Serial)

  #Clear Temp Storage
  temp <- NULL

  })

# 2. Re-add Serial ----

## 1. Re-add Serial ----
shiny::observeEvent(input$re_add_ser, {

  # Stop if Serial is present
  if (is.null(Serial_Removed$data)){

    # Error Notification
    shinyalert::shinyalert(title = "Serial number has not been removed.",
                           type = "error")

    # Validation
    shiny::validate(shiny::need(Serial_Removed$data, "There is no Serial Number that has been removed"))

    }

  # Stop if no. of rows for data doen't match no. of Serials
  if (nrow(App_data$values) != nrow(Serial_Removed$data)){

    # Error Notification
    shinyalert::shinyalert(title = "Number of observations in datasets different to the number of removed serial numbers.",
                           text = "Please ensure that numbers of observation in dataset is the same as number of serial numbers.",
                           type = "error")

    # Validation
      shiny::validate(shiny::need(nrow(App_data$values) == nrow(Serial_Removed$data),
                                  "The stored serial numbers have a different number of rows to data frame"))

      }

  #Notification indicating that Serial number has been re-added
  shinyalert::shinyalert(title = "Serial number successfully re-added.",
                         type = "success")

  # Re-add Serial number
  App_data$values <- App_data$values|>
    cbind(Serial_Removed$data) |>
    dplyr::select(Serial,dplyr::everything())

  # Clear Stored Serial Number
  Serial_Removed$data <- NULL

  })

# 3. Update Selectboxes ----
# Updates key and value variable select boxes prior to data transformation

## 1. Update select input box with variable names for key variable ----
shiny::observe({

  # Update options
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "keyvariableId",
                           label = "Choose Key Variable",
                           choices = cb_options,
                           selected = "")
  })


## 2. Update select input box with variable names for value variable ----
shiny::observe({

  # Update options
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "valuevariableId",
                           label = "Choose Value Variable",
                           choices = cb_options,
                           selected = "")

  })


# 4. Store Variables ----
# This stores variables prior to data transformation

## 1. Key Variable Details ----

key_value_options <- shiny::reactiveValues(data=NULL) # Options
key_value_header <- shiny::reactiveValues(header=NULL) # Variable Name

## 2. Value Variable Details ----

variable_value_header <- shiny::reactiveValues(header=NULL) # Variable Name

## 3. Column Names in original order ----

column_values <- shiny::reactiveValues(order=NULL)


# 5. Long to Wide Transformation ----

## 1. Data Transformation ----
shiny::observeEvent(input$long_wide_trans, {

  # Stop if key & value variable not given
    if (input$keyvariableId == "" & input$valuevariableId == ""){

      # Error Notification
      shinyalert::shinyalert(title = "There is no key or value variable selected",
                             text = "Please select key variable and value variable.",
                             type = "error")

      # Validation
      shiny::validate(shiny::need(input$keyvariableId , "There is no key variable"),
                      shiny::need(input$valuevariableId , "There is no value variable"))

      # Stop if value variable not given
    } else if (input$keyvariableId != "" & input$valuevariableId == ""){

      # Error Notification
      shinyalert::shinyalert(title = "There is no value variable selected",
                             text = "Please select value variable.",
                             type = "error")

      # Validation
      shiny::validate(shiny::need(input$valuevariableId , "There is no value variable"))

      # Stop if key variable not given
      } else if (input$keyvariableId == "" & input$valuevariableId != "") {

        # Error Notification
        shinyalert::shinyalert(title = "There is no key variable selected",
                               text = "Please select key variable.",
                               type = "error")

        # Validation
        shiny::validate(shiny::need(input$keyvariableId , "There is no key variable"))

      }

  #Un-formatted Data Storage
  shiny::isolate({temp_format <- App_data$values})

  # Key Variable
  key_value_header$header <- input$keyvariableId

  # Value Variable
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

    # Success Notification
    shinyalert::shinyalert(title = "Long to wide transformation successful",
                           type = "success")},

    # Error Notification
    error = function(e)
      shinyalert::shinyalert(title = "Transformation Unsuccessful. Please reset data.",
                             type = "error")
    )

  # Clear Unformatted data
  temp_format <- NULL

})

# 6. Wide to Long Transform ----
# Only used when Long to Wide Transformation has occured

## 1. Transform data ----
shiny::observeEvent(input$wide_long_trans, {

  # Stop if long data hasn't been transformed to wide data via the App
    if (is.null(key_value_header$header) & is.null(variable_value_header$header)){

      # Error notification
      shinyalert::shinyalert(title = "Long data has not been transformed to wide data",
                             text = "To transform back to wide data, please transform the long data to wide data first",
                             type = "error")

      # Validation
      shiny::validate(shiny::need(key_value_header$header, "There is no key variable"),
                      shiny::need(variable_value_header$header, "There is no value variable"))

      }

  # Un-formatted Data Storage
  shiny::isolate({temp_wide_format <- App_data$values})

  # Convert to character so that these values become options under the key value column header
  key_value_options$data <- as.character(key_value_options$data)

  # Convert wide data back to long data - generates error notification if transformation is unsuccessful
  # For data transform back to long, column headers are re-ordered to the same order as before.
  tryCatch(

    # Checks for error - if no error, this then performs the transformation
    expr = {App_data$values <- temp_wide_format |>
      tidyr::gather_(key_value_header$header,variable_value_header$header,key_value_options$data) |>
      dplyr::select(all_of(column_values$order))

    # Success Notification
    shinyalert::shinyalert(title = "Wide to long transform successful",
                           type = "success")},

    # Error Notification
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

# 7. Data Visualisation ----

output$format_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')
  Format_Data <- sdcshinyapp::Table_Render(App_data$values,cb)

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
