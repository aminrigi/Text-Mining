#' @author Amin Rigi
#' @method get_dtm_tfidf
#'
#' Returns the document_term_matrix filled with TFIDF values
#'  
#' @param txt is a vector of characters. It is assumed the vector
#' is already pre-processed and cleaned. See pre_process.R
#' 
#' @dtm document-term matrix filled with TFIDF values


get_dtm_tfidf <- function(txt){
  library(tm)
  docs =Corpus( VectorSource(txt) ) #locading docs

  
  #Create document-term matrix
  dtm <- DocumentTermMatrix(docs, control = list(weighting = weightTfIdf))
  
  #dtm shouldn't have rows with zero elements:
  #from: https://stackoverflow.com/questions/13944252/remove-empty-documents-from-documenttermmatrix-in-r-topicmodels
  
  ui = unique(dtm$i)
  dtm = dtm[ui,]
 
  
  # This makes a matrix that is 50% empty space, maximum
  #dtm = removeSparseTerms(dtm, 0.50)
   
  return(dtm)
}