#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # App title ----
    titlePanel("Upload file to store"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Select a file ----
            fileInput(
                "file1", "Choose picture file",
                multiple = FALSE,
                accept = c("image/jpeg", ".jpeg", ".jpg")
            ),
            
            # Horizontal line ----
            tags$hr(),
            
            # Output: Picture id QR ----
            imageOutput("file_qr")
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Original picture ----
            imageOutput("file_image")
            
        )
        
    )
))
