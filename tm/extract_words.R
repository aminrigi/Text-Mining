#' @author Amin Rigi
#' @method 
#' 
#' 
#' 
#' @param source is a plain text
#' 
#' @param keywords these are the keywords that we want to pick from source in the format plain text
#' 
#' @param stopWords user's stop words in form of plain text (vector char with one element)
#' 
#' @param n the number of most frequent keywords to be returned
#' 
#' @extracted is a dataframe that contains keywords and their repitition


extract_words = function(source, keywords, stopWords="", number=10){
  
  source_tidy = data_frame(line = 1, document=source)   %>%
    unnest_tokens(word, document)
  
  
  keywords_tidy = data_frame(line = 1, document=keywords)   %>%
    unnest_tokens(word, document)
  
  stopWords_tidy = data_frame(line = 1, document=stopWords)   %>%
    unnest_tokens(word, document)
  
  extracted = source_tidy %>%
    inner_join(keywords_tidy) %>%
    anti_join(stopWords_tidy) %>%
    group_by(word) %>%
    mutate(freq = n()) %>%
    unique() %>%
    arrange(desc(freq)) %>%
    head(n=number)
  
  return(extracted)
  
}