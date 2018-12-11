#' @author Amin Rigi
#' @method plotting wordcloud of a text
#' 
#' A simple function that plots the wordcloud for a given text
#' @param text the target text 
#' @param n number of terms in wordcloud

plot_wordCloud <-  function(text, n, ...){
  library(wordcloud)
  library(tidytext)
  library(dplyr)
  
  
  tidyText  <-  data_frame(document=text)   %>%
    unnest_tokens(word, document)
  
  words  <-  tidyText %>% 
    group_by(word) %>% 
    summarise(freq = n()) %>% 
    arrange(desc(freq)) %>%
    as.data.frame()
  
  
  # Displaying wordCloud
  set.seed(2358)
  wordcloud(words = words$word[1:n] , freq = words$freq[1:n],
            min.freq = 1, max.words=200, random.order=FALSE,
            rot.per=0.35, colors=brewer.pal(8, "Dark2"))
  
  
}