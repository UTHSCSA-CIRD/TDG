library(shinyBS)
library(shiny)
library(shinyjs)

shinyUI(fluidPage(theme = "bootstrap.min.css", 
                  tags$head(tags$script(src = "popOver.js")),
                  shinyjs::useShinyjs(),

  # Application title
  titlePanel("TDG"),
  HTML(titleString),
  div(id ="UploadScreen",
      #This will be the screen that handles uploading the data set. 
      sidebarLayout(
        sidebarPanel(
          fileInput("dynamicFile", "Select the file you wish to upload:", accept = "AsCII file one record per row. Select delimination."),
          checkboxInput("fileHeader", "Header?", value = TRUE),
          radioButtons("deliminationRadio","Delimination", choices = c("\\t (tab)", ", (comma)", "; (semi-colon", "| (vertical bar)") , selected = "\\t (tab)"),
          actionButton("submitFile", "Submit")
        ),#end sidebarLayout
        #end sidebar
        mainPanel(
          div( id = "UploadFileStatement",
            HTML(uploadString)
          ),
          shinyjs::hidden(div(id= "ConfirmFile",
                          HTML("<p> Below is the header of the file, please confirm that the file information is correct, or make corrections and submit again.</p>"),
                          tableOutput('fileHead'),
                          actionButton("confirmUpload", "Correct")
          )),
          bsAlert("alert")  
          )#end main panel
      )#end sidebar layout
  ), ##END UPLOAD DIVS
  shinyjs::hidden(div(id="WorkingScreen",
                      sidebarLayout(
      sidebarPanel(HTML("<p>Congrats, We made it this far.</p>")),
      mainPanel(
        tableOutput("dataDicTable")
      ))
  ))##END WORKING SCREEN 
))
