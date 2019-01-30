optimal_topics_number <- function(dtm, from, to, by = 1, method = 'Griffiths2004'){
  #' This function find the optimal number of topics for LDA
  #' 
  #' Args:
  #'  dtm: the document term matrix
  #'  
  #'  from: minumum number of toics
  #'  to: maximum number of topics
  #'  by: deafult jump size between number of topics
  #'  method: the evaluation metric. Currently there are 4 metrics available:
  #'  c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014")
  #'  the default method is Griffiths2004
  #'  
  #'  
  #' Returns:
  #'  a list which contains:
  #'    1- the optimal number of topics
  #'    2- the plot of the topics
  #'   
  
  library(ldatuning)
  
  
   lda.tuning.result <- FindTopicsNumber(
     dtm,
     topics = seq(from, to , by),
     metrics = "Griffiths2004",
     method = method,
     control = list(seed = 77),
     mc.cores = 2L,
     verbose = TRUE
   )
   
   
   plot <- FindTopicsNumber_plot(lda.tuning.result)
   optimal.k <- which.max(lda.tuning.result[,method])+1
   
   return(list(plot, optimal.k))
}







