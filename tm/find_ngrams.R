library(tidytext)

find_ngrams <- function(docA, docB, numOfgrams = 5, ngrams = 2)
{
  #' Returns the common ngrams between docA and docB with their repitition
  #' 
  #' Args:
  #'   docA: a character (plain text) of the first document
  #'   docB: see above
  #'   numOfGrams: the number of grams to be returned
  #'   ngrams: shows the length of tokens; if 2, its a bigram;
  #'   
  #'   
  #' Returns:
  #'   Returns the ngrams that docA and docB share with their frequency
  #'   
  
  
  
  # Error handling -- check for empty documents
  if( length(docA) != 1 || length(docB) != 1){
    stop("Invalid argument(s)")
  } 
  
  
  source_tidy <-  data_frame(document=docA)   %>%
    unnest_tokens(bigram , document, token = "ngrams", n = ngrams)
  
  
  keywords_tidy <-  data_frame( document=docB)   %>%
    unnest_tokens(bigram , document, token = "ngrams", n = ngrams)
  
  
  extracted <-  source_tidy %>%
    inner_join(keywords_tidy) %>%
    group_by(bigram) %>%
    mutate(freq = n()) %>%
    unique() %>%
    arrange(desc(freq)) %>%
    head(n=numOfgrams)
  
  return(extracted)
}