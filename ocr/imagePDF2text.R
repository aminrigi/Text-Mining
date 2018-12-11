

imagePDF2text <- function(filePath, input.dpi = 300){
  #' This function gets a scanned PDF as input and returns a data_frame which has to cols
  #' first col is 'text' and the second is 'pageNumber'. This function does NOT clean the 
  #' text. 
  #' 
  #' 
  #' Args:
  #'   filePath: is a path to a PDF file
  #'   input.dpi: the dpi for scanning
  #'            
  #' Returns:
  #'   txt.df is a tibble which represnets the document. See the function description
  
  #Error Handling 
  if( !grepl(".pdf", filePath) && !grepl(".PDF", filePath) ){
    stop("Invalid Argument(s)")
  }
  
  
  numPages <- pdf_info(filePath)[[2]]
  
  txt.df <- c(1:numPages) %>% data_frame()
  
  colnames(txt.df) = "page"
  txt.df$text = ""
  
  
  for (i in 1:numPages) {
    bitmap <- pdftools::pdf_render_page(filePath, page = i, dpi = input.dpi)
    png::writePNG(bitmap, "tmp.png")
    txt.df$text[i] <- tesseract::ocr("tmp.png")
  }
  
  file.remove("tmp.png")
  
  return(txt.df)
  
}