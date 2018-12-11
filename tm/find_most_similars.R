#' @author Amin Rigi
#' @method find_most_similars
#'
#' Returns the n most similar docuements that are similar to the query
#' @param query is a string (chars)
#' @param txt_array is a vector. Each element in the vector signifies a document
#' is the the term document matrix in TFIDF forms (in TFIDF, terms which 
#' identify a document are signified for that document)
#' @param n the number of the most similar documents.
#' 
#' Loosely based on https://www.r-bloggers.com/information-retrieval-document-search-using-vector-space-model-in-r/



find_most_similars <- function(query, txt_array, n = 5){
  
  library(lsa)
  library(dplyr)
  number_of_docs <-  length(txt_array)
  #adding the query at the end of documents.
  txt_array[(number_of_docs)+1] <-  query
  
  source("tm/get_dtm.R")
  dtm <-  get_dtm(txt_array, TRUE) # True is for TFIDF weight
  dtm_mat <-  as.matrix(dtm)
  
  #normalizing the dtm
  tfidf_mat <- scale(dtm_mat, center = FALSE,scale = sqrt(colSums(dtm_mat^2)))
  
  
  
  #seperating query tdm matrix and content tdm matrix
  query_vector <- tfidf_mat[number_of_docs+1,]
  tfidf_mat <- tfidf_mat[1:number_of_docs,]
  
  
  
  #initiating a df for reporting similarities
  similarity_df <-  rep(0, number_of_docs) %>%
    as.data.frame()
  
  colnames(similarity_df) = "score"
  similarity_df$id  <-  c(1:number_of_docs)
  
  
  
  for (i in 1:number_of_docs) {
    similarity_df$score[i] = cosine(tfidf_mat[i,], query_vector)
  }
  
  
  similarity_df <-  similarity_df %>%
    arrange(desc(score))
  
  
  
  return(similarity_df[1:n,])
  
  
  #if we're interested in inner product distance -- faster, but less accurate
  #calculating the similarity scores
  #doc.scores <- t(query.vectors) %*% tfidf_mat
  #results.df <- data.+frame(querylist = queries_list,doc.scores)
  
  
}






  