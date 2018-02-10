#Libraries required
library(syuzhet)
library(tm)
library(caret)
library(SnowballC)

#Importing Files
train<-read.csv2('train.tsv',sep='\t')

#Cleaning of item_description feature
corp<-VectorSource(train$item_description[10])
corp<-VCorpus(corp)
corp<-tm_map(corp,removePunctuation)
corp<-tm_map(corp,stemDocument)
corp<-tm_map(corp,removeWords,stopwords()[stopwords()!='not'])
corp<-tm_map(corp,stripWhitespace)
text<-corp[[1]]$content

#Extracting Positive and Negative sentiments based on Words
senti<-get_nrc_sentiment(text)
if (grepl(c('not good','not bad','not great','not poor'),text)==TRUE){
  temp<-senti$positive
  senti$positive<-senti$negative
  senti$negative<-temp
}
barplot(as.matrix(senti[9:10]))
text
