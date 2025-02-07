### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 2-03_var_convert.R
#Purpose: To allow for variable conversion of data
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###


### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 1. Updates Check Boxes with variable names ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

shiny::observe({

  # Stores all variable names in App data apart from Serial - this function is in a external script
  cb_options <- SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Variable_Convert",
                          label = "Choose Variables to Convert:",
                          choices = cb_options,
                          selected = "")
  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 2. Character to Numeric Variable Conversion ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Convert with button press
shiny::observeEvent(

  input$char_to_num, {

    # Ensures that the input data is available
    shiny::validate(
      need(App_data$values, "There is no Input Data")
    )

    # Ensures that input variable is selected
    if (input$Variable_Convert == ""){

      # Variable Selection Notification error
      shinyalert::shinyalert(title = "There is no input variable selected", text = "Please select input variable.", type = "error")

      # Variable Validation
      shiny::validate(
        shiny::need(input$Variable_Convert, "No Variables are selected")
        )

      } else {

        # Variable Convertion Notification success
        shinyalert::shinyalert(title = "Variable converted to a numeric format", type = "success")

        }

    # Temp Storage of Unprocessed data
    isolate({

      temp_char <- App_data$values

      })

    # Convert variable and clear Unprocessed Data
    App_data$values[[input$Variable_Convert]] <- as.numeric(temp_char[[input$Variable_Convert]])
    temp_char <- NULL

    }

  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 3. Numeric to Character Variable Conversion ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Convert with button press
observeEvent(

  input$num_to_char, {

    # Ensure that the input data is available
    shiny::validate(
      shiny::need(App_data$values, "There is no Input Data")
    )

    # Ensure that input variable is selected
    if (input$Variable_Convert == ""){

      # Variable Selection Notification error
      shinyalert::shinyalert(title = "There is no input variable selected", text = "Please select input variable.", type = "error")

      # Variable Validation
      shiny::validate(
        shiny::need(input$Variable_Convert, "No Variables are selected")
        )

      } else {

        # Variable Convertion Notification success
        shinyalert::shinyalert("Variable converted to a character format", type = "success")

        }

    # Temp Storage of Unprocessed data
    shiny::isolate({

      temp_num <- App_data$values

      })

    # Convert variable and clear temp data
    App_data$values[[input$Variable_Convert]] <- as.character(temp_num[[input$Variable_Convert]])
    temp_num <- NULL

    }

  )


### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
## 4. Data Visualisation ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

output$convert_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')

  # Data visualisation is achieved via a function inside a external script.
  convert_data <- Table_Render(App_data$values,cb)

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
