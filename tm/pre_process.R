#' @author Amin Rigi
#' @method pre-process
#' Pre-Processing a vector of raw text
#' 
#' 
#' This function is used to clean text. 
#' 
#' @param txt is a vector of characters. Each element in txt 
#' can be separate document. For example, txt can be column of a dataframe
#' that contains text
#' 
#' @param myStopwords is a vector of custom and user-specified stopwords
#' For example:
#' 
#'   myStopwords <- c("can", "say", "please","pleas","thank","thanks",
#'   "just","only", "tag", "link","done",
#'   "anyone","anyon","everyone","everyon","page","user","reply")
#' 
#' @param docs$content the cleaned text
#' 


pre_process <- function(txt, myStopwords){
  library(tm)
  docs =Corpus( VectorSource(txt) ) #locading docs
  docs = tm_map(docs, content_transformer(tolower) )
  
  #This comes handy when we have a weird char and we don't want to fix encoding
  removeWeirdChars = content_transformer(function(x, pattern) 
  {
    return (gsub(" ", " ", x))
  })
  
  toSpace = content_transformer(function(x, pattern) 
  {return (gsub(pattern, " ", x))})



  #removing words with length one or two
  removeSingleLetters = content_transformer(function(x, pattern)
  {return (gsub('\\b\\w{1,2}\\b','',x))  })
  
  #removing unknown symbols
  docs <- tm_map(docs, toSpace,"[^[:alnum:] ]")
  
  #remove Weird chars
  docs <- tm_map(docs, removeWeirdChars)
  
  #remove punctioation
  docs <- tm_map(docs, removePunctuation)
  #Strip digits
  docs <- tm_map(docs, removeNumbers)
  #remove stopwords
  docs <- tm_map(docs, removeWords, stopwords("english"))
  #remove whitespace
  docs <- tm_map(docs, stripWhitespace)

  #Stem document -- for clustering and topic modeling
  #docs <- tm_map(docs,stemDocument)
  
  
  
  #Removing stopWords
  docs <- tm_map(docs, removeWords, myStopwords)
  
  #Removing all words with length one or two
  docs <- tm_map(docs, removeSingleLetters)
  

  return(docs$content) 
}