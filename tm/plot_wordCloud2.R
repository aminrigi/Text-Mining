#' @author Amin Rigi
#' @method plotting wordcloud2 of a text
#' 
#' A simple function that plots the wordcloud for a given text
#' @param text the target text 
#' @param n number of terms in wordcloud

plot_wordCloud2 = function(text, n, ...){
  library(wordcloud2)
  library(tidytext)
  library(dplyr)
  
  
  tidyText = data_frame(line = 1, document=text)   %>%
    unnest_tokens(word, document)
  
  words = tidyText %>% 
    group_by(word) %>% 
    summarise(freq = n()) %>% 
    arrange(desc(freq)) %>%
    as.data.frame()
  
  
  # Displaying wordCloud
  wordcloud2(words[1:n,], color = "random-dark", 
             backgroundColor = 'white',  minRotation = pi/5, 
             maxRotation = pi/5, rotateRatio = 3)
  
}