#' @author Amin Rigi
#' @method plot_feelingCloud
#' 
#' This function finds the feeling cloud of a text based on 'nrc' and 
#' wordcloud
#' see https://github.com/aminrigi/Feeling-Cloud for more
#' 
#' @param text input text
#' 
#' @param n numbers of terms to be shown in the feeling cloud

plot_feelingCloud =  function(text, n, ...){
  library(wordcloud)
  library(tidytext)
  library(dplyr)
  library(tm)
  
  text_tidy =  data_frame(line = 1, document=text)   %>%
    unnest_tokens(word, document)
  
  
  text_freq = text_tidy %>%
    inner_join(get_sentiments("nrc"), by = "word") %>%
    count(word, sort = TRUE) %>%
    head(n=50) 
  
  set.seed(2358)
  wordcloud(words = text_freq$word , freq = text_freq$n, min.freq = 1,
             max.words=200, random.order=FALSE, 
            rot.per=0.35, colors=brewer.pal(8, "Dark2"))
}