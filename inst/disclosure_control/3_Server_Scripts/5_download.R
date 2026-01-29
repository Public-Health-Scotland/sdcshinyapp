# ------------------------------------------------------------------------------
# Script Name : 5_download.R
# Purpose     : Download data from app
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Data Visualisation ----
output$Final_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS("function(){debugger;HTMLWidgets.staticRender();}")
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# 2. Data Reset and Download ----

# Download and reset of uploaded data
source("3_Server_Scripts/5-01_live.R", local = TRUE)$value

# Download and reset of training data
source("3_Server_Scripts/5-02_train.R", local = TRUE)$value

# END OF SCRIPT ----
