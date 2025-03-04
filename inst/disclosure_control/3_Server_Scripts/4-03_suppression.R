### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#Run on Posit version: 4.1.2
#Last updated: 02 Oct 2024
#By: Robert Mitchell
#Script: 4-03_suppression.R
#Purpose: To perform suppression on data for disclosure
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# 1. Updates variable select option ----

## 1. Primary Suppression ----
shiny::observe({

  # Variable Options
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Disc_Variables_Pri_Supp",
                           label = "Choose Variables for Primary Suppression:",
                           choices = cb_options,
                           selected = "")
  })

## 2. Secondary Suppression ----
shiny::observe({

  # Variable Options
  cb_options <- SelectBox_Update(App_data$values)

  # Update Selectbox
  shiny::updateSelectInput(session, "Disc_Variables_Secondary_Supp",
                           label = "Choose Variables for Secondary Suppression:",
                           choices = cb_options,
                           selected = "")
  })


# 2. Suppress Variables ----

## 1. Primary Suppression ----
shiny::observeEvent(input$pri_sup, {

  # Stop if variables are not selected
  if (is.null(input$Disc_Variables_Pri_Supp)){

      # Error Notification
      shinyalert::shinyalert(title = "There is no variables selected for primary suppression",
                             text = "Please select variables.",
                             type = "error")

      # Validation
      shiny::validate(shiny::need(!is.null(input$Disc_Variables_Pri_Supp), "There is no variables selected for primary suppression"))

      }

  # Success Notification
  shinyalert::shinyalert(title = "Primary Suppression successful.",
                         type = "success")

  # Store Non-Suppressed Data
  shiny::isolate({temp_pri_supp <- App_data$values})

  # Primary Suppression
  App_data$values <- sdcshinyapp::Stat_Primary_Supress(temp_pri_supp, input$Disc_Variables_Pri_Supp,input$Supp_Chars, input$Pri_Supp_Cond, input$zero_sup)

  # Clear Non-Suppressed Data
  temp_pri_supp <- NULL

  })


## 2. Primary & Secondary Suppression ----
shiny::observeEvent(input$pri_sec_sup, {

  # Stop if variables are not selected
  if (is.null(input$Disc_Variables_Pri_Supp) | is.null(input$Disc_Variables_Secondary_Supp)) {

    # Error Notification
    shinyalert::shinyalert(title = "There is no variables selected for primary and/or secondary suppression.",
                           text = "Please select variables.",
                           type = "error")

    # Validation
    shiny::validate(shiny::need(!is.null(input$Disc_Variables_Pri_Supp), "There is no variables selected for primary suppression"),
                    shiny::need(!is.null(input$Disc_Variables_Secondary_Supp), "There is no variables selected for secondary suppression"))

    }

  # Success Notification
  shinyalert::shinyalert(title = "Primary & secondary suppression successful.", type = "success")

  # Store Non-Suppressed Data
  shiny::isolate({temp_supp <- App_data$values})

  # Primary & Secondary Suppression
  App_data$values <- sdcshinyapp::Stat_Secondary_Supress(temp_supp, input$Disc_Variables_Pri_Supp, input$Disc_Variables_Secondary_Supp, input$Supp_Chars, input$Pri_Supp_Cond, input$zero_sup)

  # Clear Non-Suppressed Data
  temp_supp <- NULL

  })

# 3. Data Visualisation ----

output$Suppress_data <- DT::renderDataTable({

  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')
  Suppressed_data <- sdcshinyapp::Table_Render(App_data$values,cb)

  })

### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# End ----
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
