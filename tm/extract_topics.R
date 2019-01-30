#' @author Amin Rigi
#' @method extract_topics
#'
#' Finding topics of documents using LDA
#' with Gibbs random sampling. Main reference for this code 
#' is https://eight2late.wordpress.com/2015/09/29/a-gentle-introduction-to-topic-modeling-using-r/
#' 
#' @param dtm is the document term matrix
#' 
#' @param k number of topics
#' 
#' 
#' Different things that can be done with ldaOut
#'   docs to topics
#'   ldaOut.topics <- as.matrix(topics(ldaOut))
#'   write.csv(ldaOut.topics,file=paste("lda/LDAGibbs",                                k,"DocsToTopics.csv"))
#'   
#'   top 10 terms in each topic
#'   ldaOut.terms <- as.matrix(terms(ldaOut,10))
#'   
#'   write.csv(ldaOut.terms,file=paste("lda/LDAGibbs",                                  k,"TopicsToTerms.csv"))
#'   
#'   probabilities associated with each topic assignment
#'   topicProbabilities <- as.data.frame(ldaOut@gamma)
#'   write.csv(topicProbabilities,file=paste("lda/LDAGibbs",                                        k,"TopicProbabilities.csv"))
#'   
#'   Find relative importance of top 2 topics
#'   topic1ToTopic2 <- lapply(1:nrow(dtm),function(x)  
#'   sort(topicProbabilities[x,])[k]/sort(topicProbabilities[x,])[k-1])
#'   
#'   Find relative importance of second and third most important topics
#'   topic2ToTopic3 <- lapply(1:nrow(dtm),function(x)
#'   sort(topicProbabilities[x,])[k-1]/sort(topicProbabilities[x,])[k-2])
#'   
#'   write to file
#'   write.csv(topic1ToTopic,2
#'             file=paste("lda/LDAGibbs",k,"Topic1ToTopic2.csv"))
#'             
#'  write.csv(topic2ToTopic3,
#'            file=paste("LDAGibbs",k,"Topic2ToTopic3.csv"))
#'            
#'            

 
extract_topics <-function(dtm, k)
{


  #load topic models library
  library(topicmodels)
  
  # #Set parameters for Gibbs sampling
  # burnin <- 4000
  # iter <- 200
  # thin <- 500
  # seed <-list(2003,5,63,100001,765)
  # nstart <- 5
  # best <- TRUE
  

  #For measuring execution time
  #library(tictoc)
  #tic()
  
  
  #Run LDA using Gibbs sampling
  
  ldaOut <- LDA(dtm,k, method="Gibbs", 
               control=list(seed = 777))
  
  #toc()
  
  
  return(ldaOut)
  
  #write out results
}



# Finding the optimal number of topics...


# 
# FindTopicsNumber_plot(result)
# 
# which.max(result$Griffiths2004)+1
# 
# ldaOut = extract_topics(dtm, 15) 
# 
# ldaOut.terms <- as.matrix(terms(ldaOut,4)) 


