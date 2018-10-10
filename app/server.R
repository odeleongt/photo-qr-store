#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    output$file_image <- renderImage({
        
        # input$file1 will be NULL initially. After the user selects
        # and uploads a file, head of that data file by default,
        # or all rows if selected, will be shown.
        
        req(input$file1)
        
        # show the image
        list(
            src = input$file1$datapath,
            width = "100%"
        )
        
    }, deleteFile = FALSE)
    
    
    output$file_qr <- renderImage({
        
        req(input$file1)
        
        md5 <- tools::md5sum(files = input$file1$datapath)
        
        # Read plot2's width and height. These are reactive values, so this
        # expression will re-run whenever these values change.
        width  <- session$clientData$output_file_qr_width
        height <- session$clientData$output_file_qr_height
        
        # A temp file to save the output.
        outfile <- tempfile(fileext='.png')
        
        
        # Save picture to the store
        file.copy(
            from = input$file1$datapath,
            to = paste0("../store/", md5, ".jpg"),
            overwrite = TRUE
        )
        
        png(outfile, width=width, height=height)
        
        raster::image(
            qrencoder::qrencode_raster(md5), 
            asp=1, col=c("white", "black"), axes=FALSE, 
            xlab="", ylab=""
        )
        
        dev.off()
        
        # Return a list containing the filename
        list(src = outfile,
             width = width,
             height = height,
             alt = md5)
    }, deleteFile = TRUE)
    
})
