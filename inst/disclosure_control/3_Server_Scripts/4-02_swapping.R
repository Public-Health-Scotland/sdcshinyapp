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

## 1. Variable updates of select input box ----
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


## 1. Swap Selected Variables ----
shiny::observeEvent(input$swapping, {

  # Stop if variables not selected
  if (is.null(input$Disc_Variables_Swap)){

    # Error Notification
    shinyalert::shinyalert(title = "There is no input variables selected",
                           text = "Please select input variables.",
                           type = "error")

    # Validation
    shiny::validate(shiny::need(!is.null(input$Disc_Variables_Swap), "There is no variables selected for record swapping"))

    }

  # Success Notification
  shinyalert::shinyalert(title = "Record Swapping successful.",
                         type = "success")

  # Store Non-Swapped Data
  shiny::isolate({temp_swap <- App_data$values})

  # Swap Data
  App_data$values <- sdcshinyapp::Stat_Swap(temp_swap, input$Disc_Variables_Swap, input$Swap_Cond)

  # Clear Non-Swapped Data
  temp_swap <- NULL

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
