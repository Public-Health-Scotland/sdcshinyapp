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
  cb_options <- sdcshinyapp::SelectBox_Update(App_data$values)

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
    shinyalert::shinyalert(title = "There is no input variables selected",
                           text = "Please select input variables.",
                           type = "error")

    # Validation
    shiny::validate(shiny::need(!is.null(input$Disc_Variables_Pri_Supp), "There is no variables selected for primary suppression"))

    }

  # Success Notification
  shinyalert::shinyalert(title = "Primary Suppression successful.",
                         type = "success")

  # Primary Suppression
  App_data$values <- sdcshinyapp::Stat_Primary_Supress(App_data$values, input$Disc_Variables_Pri_Supp,input$Supp_Chars, input$Pri_Supp_Cond, input$zero_sup)

  })


## 2. Primary & Secondary Suppression ----
shiny::observeEvent(input$pri_sec_sup, {

  # Stop if variables are not selected or if more than one variable is selected for primary suppression or only one secondary suppression variable is selected
  if (is.null(input$Disc_Variables_Pri_Supp) || is.null(input$Disc_Variables_Secondary_Supp) || length(input$Disc_Variables_Pri_Supp) != 1 || length(input$Disc_Variables_Secondary_Supp) < 2) {

    # Error Notification
    shinyalert::shinyalert(
      title = "Invalid selection for primary and/or secondary suppression.",
      text = "Please select exactly one variable for primary suppression and at least two variables for secondary suppression.",
      type = "error"
    )

    # Validation
    shiny::validate(
      shiny::need(!is.null(input$Disc_Variables_Pri_Supp), "There are no variables selected for primary suppression"),
      shiny::need(length(input$Disc_Variables_Pri_Supp) == 1, "Please select exactly one variable for primary suppression"),
      shiny::need(!is.null(input$Disc_Variables_Secondary_Supp), "There are no variables selected for secondary suppression"),
      shiny::need(length(input$Disc_Variables_Secondary_Supp) >= 2, "Please select at least two variables for secondary suppression")
    )
  }

  # Success Notification
  shinyalert::shinyalert(title = "Primary & secondary suppression successful.", type = "success")

  # Primary & Secondary Suppression
  App_data$values <- sdcshinyapp::Stat_Secondary_Supress(App_data$values, input$Disc_Variables_Pri_Supp, input$Disc_Variables_Secondary_Supp, input$Supp_Chars, input$Pri_Supp_Cond, input$zero_sup)

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
