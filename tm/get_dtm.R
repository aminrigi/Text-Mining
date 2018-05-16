#' @author Amin Rigi
#' @method get_dtm
#'
#' Returns the document_term_matrix for a vector of characters 
#' @param txt is a vector of characters. It is assumed the vector
#' is already pre-processed and cleaned. See pre_process.R
#' 
#' @param TFIDF is boolean. Default value is false. If true, the dtm will contain
#' the TFIDF weight
#' 
#' @dtm document-term matrix


get_dtm <- function(txt, TFIDF = FALSE){
  library(tm)
  docs = Corpus( VectorSource(txt) ) #locading docs
  
  #Create document-term matrix
  if(TFIDF = FALSE){
    dtm = DocumentTermMatrix(docs)  
  }
  else{
    dtm <- DocumentTermMatrix(docs, control = list(weighting = weightTfIdf))
  }
  
  
  
  # In topic modeling dtm shouldn't have rows with zero elements.
  #Following rows fix this.
  #from: https://stackoverflow.com/questions/13944252/remove-empty-documents-from-documenttermmatrix-in-r-topicmodels
  
  ui = unique(dtm$i)
  dtm = dtm[ui,]
  
  # This makes a matrix that is 50% empty space, maximum
	#dtm = removeSparseTerms(dtm, 0.50)


  return(dtm)
}