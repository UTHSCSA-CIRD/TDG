require(shiny)
require(shinyBS)
require(ggplot2)
require(shinyjs)
require(e1071)
require(psy)
require(digest)
require(sqldf)
source("Helper.R")

shinyServer(function(session, input, output) {
  r <- reactiveValues()
  r$pData = 1
  r$dataDic = 1
  
###Buttons######################  
  submitButtonPressed <- observeEvent(input$submitFile,{
    if(is.null(input$dynamicFile)){
      createAlert(session, "alert",content="Please attach a file first.",title = "ERROR!", append = FALSE)
    }else{ 
      s = switch(input$deliminationRadio,
                 "\\t (tab)" = "\t",
                 ", (comma)" = ",",
                 "; (semi-colon" = ";",
                 "| (vertical bar)" = "|")
      ##if there is an issue with uploading the file break and post an alert. 
      tryCatch({
        m = input$dynamicFile
        r$pData <<- read.table(m$datapath, header = input$fileHeader, sep = s)
        
      },error = function(ex){
          createAlert(session, "alert",content="There was an error uploading the file.",title = "ERROR!", append = FALSE)
          return();
      })
      #after successful upload, hide the upload file statement and show the "confirm file" page. 
      shinyjs::hide(id = "UploadFileStatement", anim = TRUE)
      shinyjs::show(id = "ConfirmFile", anim = TRUE)
    }
  }) #end submit button pressed
  confirmUploadButtonPressed <- observeEvent(input$confirmUpload,{
    shinyjs::hide(id="UploadScreen", anim = TRUE)
    shinyjs::show(id = "WorkingScreen", anim = TRUE)
    ##Here we should process the data for pruning, alteration, etc. 
    dataDic = data.frame(lapply(r$pData, class))
    dataDic = data.frame(t(dataDic))
    colnames(dataDic) = c('Type')
    dataDic$nonNACount = apply(r$pData, 2, function(x) length(which(!is.na(x) & !is.null(x))))
    dataDic$numericCount = suppressWarnings(apply(r$pData,2, function(x) length(which(!is.na(as.numeric(x))))))
    x = rownames(dataDic)[dataDic$nonNACount == dataDic$numericCount & (dataDic$Type != "Numeric" |dataDic$Type != "Integer")]
    r$pData[,x] = lapply(r$pData[,x], as.numeric)
    dataDic$Type = apply(r$pData,2, class)
    dataDic$nonNACount = apply(r$pData, 2, function(x) length(which(!is.na(x) & !is.null(x))))
    
  })
  
########### UI OUTPUTS ######################
  output$fileHead <- renderTable(
    if(r$pData != 1){
      head(r$pData)
    }
  )
  output$dataDicTable <- renderTable(
    dataDic
  )

})
