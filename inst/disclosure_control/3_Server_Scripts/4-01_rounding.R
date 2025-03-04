### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 4-01_rounding.R
#Purpose: To perform rounding on data for disclosure
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Updates variable select option ----

## 1. Variable updates of select input box ----
shiny::observe({

  # Variable Options
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Disc_Variables_Round",
                    label = "Choose Variables to Round:",
                    choices = cb_options,
                    selected = "")

  })


# 2. Round Variables ----

## 1. Rounding Selected Variables ----
shiny::observeEvent(input$rounding, {

    # Stop if variables are not selected
    if (is.null(input$Disc_Variables_Round)){

      # Error Notification
      shinyalert(title = "There is no input variables selected",
                 text = "Please select input variables.",
                 type = "error")

      # Validation
      shiny::validate(shiny::need(!is.null(input$Disc_Variables_Round), "There is no variables selected for rounding"))

      }

  # Success Notification
  shinyalert::shinyalert(title = "Data successfully rounded.", type = "success")

  # Store Non-Rounded Data
  shiny::isolate({temp_round <- App_data$values})

  # Round Data
  App_data$values <- sdcshinyapp::Stat_Round(temp_round, input$Disc_Variables_Round,input$Round_Cond)

  # Clear Non-Rounded Data
  temp_round <- NULL

  })

# 3. Data Visualisation ----

output$Rounded_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')
  Rounded_Data <- sdcshinyapp::Table_Render(App_data$values,cb) # Render Data Output

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
