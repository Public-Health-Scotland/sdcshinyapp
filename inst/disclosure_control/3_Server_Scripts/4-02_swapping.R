### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 4-02_swapping.R
#Purpose: To perform rounding on data for disclosure
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Update variable select option ----

## 1. Swapping
shiny::observe({

  # Variable Options
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Disc_Variables_Swap",
                           label = "Choose Variables to Swap:",
                           choices = cb_options,
                           selected = "")
  })

# 2. Swap Variables ----

## 1. Swapping Selected Variables ----
shiny::observeEvent(input$swapping, {

  # Check if any variables are selected for swapping
  if (is.null(input$Disc_Variables_Swap)) {

    # Display an error notification if no variables are selected
    shinyalert::shinyalert(title = "No Input Variables Selected",
                           text = "Please select input variables.",
                           type = "error")

    # Validate to stop further execution if no variables are selected
    shiny::validate(shiny::need(!is.null(input$Disc_Variables_Swap), "No input variables selected"))

  } else {

    # Check if swapping condition is a whole, positive integer greater than one
    if (!is.numeric(input$Swap_Cond) || input$Swap_Cond < 1 || input$Swap_Cond %% 1 != 0) {

      # Display an error notification if the swapping condition is not valid
      shinyalert::shinyalert(title = "Invalid Swapping Condition",
                             text = "Please enter a whole, positive integer for the swapping condition.",
                             type = "error")

      # Validate to stop further execution if the swapping condition is not valid
      shiny::validate(shiny::need(is.numeric(input$Swap_Cond) && input$Swap_Cond > 0 && input$Swap_Cond %% 1 == 0, "Invalid swapping condition"))

    } else {

      # Display a success notification if variables are selected and swapping condition is valid
      shinyalert::shinyalert(title = "Data Successfully Swapped", type = "success")

      # Perform the swapping operation on the selected variables
      App_data$values <- sdcshinyapp::Stat_Swap(App_data$values, input$Disc_Variables_Swap, input$Swap_Cond)

    }
  }
})

# 3. Data Visualisation ----

output$Swapped_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')
  Swapped_Data <- sdcshinyapp::Table_Render(App_data$values,cb)

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
