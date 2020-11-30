#Libraries
library(syuzhet)
library(ggplot2)
library(pdftools)
library(ggpubr)
library(jpeg)

## Code

textfile<-get_text_as_string("Script-lion king.txt")

##  Getting sentences
tf<-get_sentences(textfile)


#  Get sentiment
sentiment<-get_sentiment(tf,method = "syuzhet")
sentiment_pct_val<-get_percentage_values(sentiment)
dct_transform<-get_transformed_values(sentiment_lion_king,low_pass_size = 3,scale_vals = F,scale_range = F)


## Visualization  
dct<-data.frame(index=1:length(sentiment_pct_val),value=sentiment_pct_val)
g<-ggplot(data=dct)+background_image(img)
g<-g+geom_line(color="grey",aes(x=dct$index,y=dct$value,colour="blue"))
g<-g+xlab("Nattative time")+ylab("Emotinal valence")+theme(legend.position = "none")
g

dct<-data.frame(index=1:length(dct_transform),value=dct_transform)
g<-ggplot(data=dct)+background_image(img)
g<-g+geom_line(color="grey",aes(x=dct$index,y=dct$value))
g<-g+xlab("Nattative time")+ylab("Emotinal valence")+theme(legend.position = "none")
g


# Aladin

## code
```{r}
aladin<-get_text_as_string("Script-Aladin.txt")
```

  Getting sentences
```{r}
al<-get_sentences(aladin)
```

  The script starts from 153 line so, ends at 6 before last
```{r}
al<-al[2:length(al)-2]
```

  Get sentiment
```{r}
sentiment_aladin<-get_sentiment(al,method = "syuzhet")
sentiment_pct_val_al<-get_percentage_values(sentiment_aladin)
dct_transform_al<-get_transformed_values(sentiment_aladin,low_pass_size = 3,scale_vals = F,scale_range = F)
```

## Visualization  
```{r}
img_al<-readJPEG("aladin.jpg")
```
 
                                   The detailed curve
```{r}
dct_al<-data.frame(index=1:length(sentiment_pct_val_al),value=sentiment_pct_val_al)
g<-ggplot(data=dct_al)+background_image(img_al)
g<-g+geom_line(color="grey",aes(x=dct_al$index,y=dct_al$value))
g<-g+xlab("Nattative time")+ylab("Emotinal valence")+theme(legend.position = "none")
g
```

                                      Smooth Curve
```{r}
dct_al<-data.frame(index=1:length(dct_transform_al),value=dct_transform_al)
g<-ggplot(data=dct_al)+background_image(img_al)
g<-g+geom_line(color="grey",aes(x=dct_al$index,y=dct_al$value,size=.5))
g<-g+xlab("Nattative time")+ylab("Emotinal valence")+theme(legend.position = "none")
g
```                
