### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 2-03_var_convert.R
#Purpose: To allow for variable conversion of data
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Updates Check Boxes with variable names ----
shiny::observe({

  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values) # Stores all variable names from App data apart from Serial

  # Update Selectbox input with variable names
  shiny::updateSelectInput(session, inputId = "Variable_Convert", label = "Choose Variables to Convert:", choices = cb_options, selected = "")

  })

# 2. Character to Numeric Variable Conversion ----

# Convert with button press
shiny::observeEvent(input$char_to_num, {

  # Ensure input data is available
  shiny::validate(shiny::need(App_data$values, "There is no Input Data"))

  # Ensure input variable is selected
  if (input$Variable_Convert == "") {

    # Notification error
    shinyalert::shinyalert(
      title = "There is no input variable selected",
      text = "Please select input variable.",
      type = "error"
    )

    # Variable Validation
    shiny::validate(shiny::need(input$Variable_Convert, "No Variables are selected"))

  } else {

    # Notification success
    shinyalert::shinyalert(
      title = "Variable converted to a numeric format",
      type = "success"
    )

    # Temp Storage of Unprocessed data
    isolate({temp_char <- App_data$values})

    # Attempt to convert variable to numeric
    converted_value <- suppressWarnings(as.numeric(temp_char[[input$Variable_Convert]]))

    # Check if conversion was successful
    if (is.na(converted_value)) {

      # Notification error
      shinyalert::shinyalert(
        title = "Conversion Error",
        text = "The selected variable could not be converted to numeric.",
        type = "error"
      )

    } else {

      # Update the value in App_data
      App_data$values[[input$Variable_Convert]] <- converted_value
      temp_char <- NULL
    }
  }
})

# 3. Numeric to Character Variable Conversion ----

# Convert with button press
observeEvent(

  input$num_to_char, {

    # Ensures input data is available
    shiny::validate(
      shiny::need(App_data$values, "There is no Input Data")
    )

    # Ensures input variable is selected
    if (input$Variable_Convert == ""){

      # Notification error
      shinyalert::shinyalert(title = "There is no input variable selected", text = "Please select input variable.", type = "error")

      # Variable Validation
      shiny::validate(
        shiny::need(input$Variable_Convert, "No Variables are selected")
        )

      } else {

        # Notification success
        shinyalert::shinyalert("Variable converted to a character format", type = "success")

        }

    # Temp Storage of Unprocessed data
    shiny::isolate({temp_num <- App_data$values})

    # Convert variable and clear temp data
    App_data$values[[input$Variable_Convert]] <- as.character(temp_num[[input$Variable_Convert]])
    temp_num <- NULL

    }
  )


# 4. Data Visualisation ----

output$convert_data <- DT::renderDataTable({

  # Trigger debugger and render static widgets
  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')

  # Visualise Data
  convert_data <- sdcshinyapp::Table_Render(App_data$values,cb)

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
