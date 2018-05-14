#' @author Amin Rigi
#' @method plot_sentiments
#' 
#' This function gets a text and plots its sentiment using tm package
#' There are three types of sentiment in tm: nrc', 'loughran', or 'bing'
#' 
#' @param txt the input text
#' 
#' @param type can be one of 'nrc', 'loughran', or 'bing' 


plot_sentiments = function(txt, type, ...){
  library(tidytext)
  library(tm)
  library(dplyr)
  library(ggplot2)
  
  tidyText = data_frame(line = 1, document=txt) %>%
    unnest_tokens(word, document)
  
  tidyText %>%
    inner_join(get_sentiments(type), by = "word") %>%
    group_by(sentiment) %>%
    summarise(n = n()) %>%
    ggplot(aes(x=factor(sentiment), y=n))+
    geom_bar(stat = "identity", fill="green4", alpha=.6) +
    labs(x= "Sentiments", y="Word Count",
         title="",
         fill = "Sentiment")+
    theme_bw()
  
}