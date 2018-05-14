#' @author Amin Rigi
#' @method plot_feelingCloud2
#' 
#' This function finds the feeling cloud of a text based on 'nrc' and 
#' wordcloud2
#' see https://github.com/aminrigi/Feeling-Cloud for more
#' 
#' @param text input text
#' 
#' @param n numbers of terms to be shown in the feeling cloud2


plot_feelingCloud2 =  function(text, n, ...){
  library(wordcloud2)
  library(tidytext)
  library(dplyr)
  library(tm)
  
  text_tidy =  data_frame(line = 1, document=text)   %>%
    unnest_tokens(word, document)
  
  
  text_freq = text_tidy %>%
    inner_join(get_sentiments("nrc"), by = "word") %>%
    count(word, sort = TRUE) %>%
    head(n=50) 
  
  wordcloud2(text_freq[1:n,], color = "random-dark", 
             backgroundColor = 'white',  minRotation = -pi/5, 
             maxRotation = -pi/5, rotateRatio = 3)
}