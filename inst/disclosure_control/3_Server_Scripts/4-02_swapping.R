### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 4-02_swapping.R
#Purpose: To perform rounding on data for disclosure
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Updates variable select option ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Updates variable options for swapping
shiny::observe({

  # Stores all variable names in App data apart from Serial - this function is in a external script
  cb_options <- SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Disc_Variables_Swap",
                    label = "Choose Variables to Swap:",
                    choices = cb_options,
                    selected = "")

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 2. Swap Variables ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Swap Selected Variables with button press
shiny::observeEvent(

  input$swapping, {

    # Ensure that variables are selected for swapping
    if (is.null(input$Disc_Variables_Swap)){

      # Error Notification indicating that variables should be selected
      shinyalert::shinyalert(title = "There is no input variables selected",
                             text = "Please select input variables.",
                             type = "error")

      # Ensures that values are selected for swapping
      shiny::validate(
        shiny::need(!is.null(input$Disc_Variables_Swap), "There is no variables selected for record swapping")

        )

      } else {

      # Notification indicating successful swapping
        shinyalert::shinyalert(title = "Record Swapping successful.",
                               type = "success")

        }

    # Store Non-Swapped Data
    shiny::isolate({

      temp_swap <- App_data$values

      })

    #Swap Data
    App_data$values <- Stat_Swap(temp_swap, input$Disc_Variables_Swap, input$Swap_Cond)

    # Clear Non-Swapped Data
    temp_swap <- NULL

    }

  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 3. Data Visualisation ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

output$Swapped_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')

  # Data visualisation is achieved via a function inside a external script.
  Swapped_Data <- Table_Render(App_data$values,cb)

})

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
