#Text Mining Infrastructure in R.


library(ggplot2) #For Visualization
library(readtext) 
library(quanteda) #For Eda
library(tm) #Short For Text Mining.
library(wordcloud) #For Making wordclouds
library(RWeka) #For N-gram
library(slam) #For Simple Triplet matrices.
library(ngram)


news<-"F:/Projects/Capstone-Text prediction/Text prediction/data/en_US.news.txt"
blogs<-"F:/Projects/Capstone-Text prediction/Text prediction/data/en_US.blogs.txt"
twitter<-"F:/Projects/Capstone-Text prediction/Text prediction/data/en_US.news.txt"

##Making a Connection for reading the Document.

con_news<-file(news,"r")
con_blogs<-file(blogs,"r")
con_twitter<-file(twitter,"r")

##Reading the data into R.

ReadText<-function(con){
  return(readLines(con,-1))
}

newsData<-ReadText(con_news)
blogsData<-ReadText(con_blogs)
twitterData<-ReadText(con_twitter)


##Cleaning the Data
###Converting into LowerCase.

Clean<-function(data){
  data<-gsub(pattern=";|\\.|!|\\?",x=data,replacement = "rep1")
  data<-gsub(pattern="\\'",x=data,replacement = "rep2")
  data<-gsub(pattern = "[^a-zA-Z]",x=data,replacement = " ")
  
  data<-tolower(data) #Converting to lower Case
  
  data<-gsub(pattern = "rep2",x=data,replacement = "\\'")
  data<-gsub(pattern = "\\s+",x=data,replacement = " ")
  
  sentence<-unlist(strsplit(x=data,split="rep1",fixed = T))
  
  return(sentence)
}


news_corpora<-Clean(newsData)
blogs_corpora<-Clean(blogsData)
twitter_corpora<-Clean(twitterData)

###Using the RDS function to save the R object with Corpora of different files to save as a connection/File.

saveRDS(blogs_corpora,file="F:\\Data science\\John Hopkins University\\10.Capstone\\Coursera-SwiftKey\\Clean\\blogs.txt")
saveRDS(twitter_corpora,file="F:\\Data science\\John Hopkins University\\10.Capstone\\Coursera-SwiftKey\\Clean\\twitter.txt")
saveRDS(news_corpora,file="F:\\Data science\\John Hopkins University\\10.Capstone\\Coursera-SwiftKey\\Clean\\news.txt")

##Creating a new Corpus from the cleaned documents.

#Using Corpus() and DirSource() from the tm Package.
docs<-VCorpus(DirSource("F:\\Data science\\John Hopkins University\\10.Capstone\\Coursera-SwiftKey\\Clean"))
