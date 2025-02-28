### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 4-01_rounding.R
#Purpose: To perform rounding on data for disclosure
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 1. Updates variable select option ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Updates variable options for rounding
shiny::observe({

  # Stores all variable names in App data apart from Serial - this function is in a external script
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Disc_Variables_Round",
                    label = "Choose Variables to Round:",
                    choices = cb_options,
                    selected = "")

  })


### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 2. Round Variables ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# Rounding Selected Variables with button press
shiny::observeEvent(

  input$rounding, {

    # Ensure that variables are selected for rounding
    if (is.null(input$Disc_Variables_Round)){

      # Error Notification indicating that variables should be selected
      shinyalert(title = "There is no input variables selected",
                 text = "Please select input variables.",
                 type = "error")

      # Ensure that values are selected for rounding
      shiny::validate(
        shiny::need(!is.null(input$Disc_Variables_Round), "There is no variables selected for rounding")
        )

      } else {

        # Notification indicating successful rounding
        shinyalert::shinyalert(title = "Data successfully rounded.",
                               type = "success")
        }

    # Store Non-Rounded Data
    shiny::isolate({

      temp_round <- App_data$values

      })

    # Round Data
    App_data$values <- sdcshinyapp::Stat_Round(temp_round, input$Disc_Variables_Round,input$Round_Cond)

    # Clear Non-Rounded Data
    temp_round <- NULL

    }

  )

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 3. Data Visualisation ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

output$Rounded_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')

  # Data visualisation is achieved via a function inside a external script.
  Rounded_Data <- sdcshinyapp::Table_Render(App_data$values,cb)

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
