##Function for Counting the number of lines in each document.
numberOfLines<-function(path){
  con<-file(path,"r")
  nlines<-0
  while(TRUE){
    line<-readLines(con,n=1)
    if(length(line)==0){
      break
    }
    nlines<-nlines+1
  }
  close(con)
  return(nlines)
}

blogLines<-numberOfLines(blogs)
newsLines<-numberOfLines(news)
twitterLines<-numberOfLines(twitter)

##Printing the Details of Each file.
paste("Number of Lines in News file are",newsLines)
paste("Number of Lines in blog file are",blogLines)
paste("Number of Lines in twitter file are",twitterLines)


###Using the DocumentTermMatrix() function of tm package.
dtm<-DocumentTermMatrix(docs) #As the function takes a corpus as a parameter
print(dtm)

##Finding the most common words.
##Can be found by summing the columns in a dtm.
frequency<-colSums(as.matrix(dtm))
frequency<-sort(frequency,decreasing = T) #Sorting in decreasing order
head(frequency,50)

##Making a Dataframe for using ggplot.
freq_df<-data.frame(words=names(frequency),count=frequency)


#Using ggplot for showing Most frequent 20 words.
g<-ggplot(data=freq_df[1:20,])
g<-g+geom_bar(stat = "identity",aes(x=words,y=count,fill="blue"))+theme(legend.position = "none",axis.text.x = element_text(angle=90))
g


##Making a WordCloud For the same.
wordcloud(names(frequency),frequency,max.words = 200,colors=brewer.pal(6,"Dark2"))

#BI-gram
biTokenizer<-function(x){NGramTokenizer(x,Weka_control(min=2,max=2))}
dtmBIGRAM<-TermDocumentMatrix(docs,control=list(tokenize=biTokenizer))
print(dtmBIGRAM)

##Plotting bi-grams
freq_bi<-rowapply_simple_triplet_matrix(dtmBIGRAM,FUN=sum)
freq_bi<-sort(freq_bi,decreasing = T)
freq_df_bi<-data.frame(bigram=names(freq_bi),freq=freq_bi)
freq_df_bi[1:50,]

##Plottig the BI-Gram words.
g<-ggplot(data=freq_df_bi[1:50,])
g<-g+geom_bar(stat="identity",aes(x=bigram,y=freq,fill="blue"))+theme(axis.text.x = element_text(angle=90),legend.position = "none")
g

##Making a wordcloud for BIgram.
wordcloud(names(freq_bi),freq_bi,max.words = 200,colors = brewer.pal(6,"Dark2"))

#Tri-Gram
triGramToken<-function(x){NGramTokenizer(x,Weka_control(min=3,max=3))}
dtmTRI<-DocumentTermMatrix(docs,control = list(tokenizer=triGramToken))
print(dtmTRI)

freq_tri<-colapply_simple_triplet_matrix(dtmTRI,FUN=sum)
freq_tri<-sort(freq_tri,decreasing = T)
freq_tri_df<-data.frame(triGram=names(freq_tri),freq=freq_tri)

##Plotting bar graph for tri-gram
g<-ggplot(data=freq_tri_df[1:50,])
g<-g+geom_bar(stat="identity",aes(x=triGram,y=freq,fill="blue"))+theme(axis.text.x = element_text(angle=90),legend.position = "none")
g

##Making a wordcloud
wordcloud(names(freq_tri),freq_tri,max.words = 200,colors = brewer.pal(6,"Dark2"))

#Quad-Gram
QuadGramToken<-function(x){NGramTokenizer(x,Weka_control(min=4,max=4))}
dtmQuad<-DocumentTermMatrix(docs,control = list(tokenizer=QuadGramToken))
print(dtmQuad)

quad_freq<-colapply_simple_triplet_matrix(dtmQuad,FUN=sum)
quad_freq<-sort(quad_freq,decreasing = T)
quad_freq_df<-data.frame(QuadGram=names(quad_freq),freq=quad_freq)

##Making a bar graph
g<-ggplot(data=quad_freq_df[1:50,])
g<-g+geom_bar(stat="identity",aes(x=QuadGram,y=freq,fill="blue"))+theme(axis.text.x = element_text(angle=90),legend.position = "none")
g

##Making a wordcloud
wordcloud(names(quad_freq),quad_freq,max.words = 200,colors = brewer.pal(6,"Dark2"))
