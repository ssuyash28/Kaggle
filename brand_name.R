#Libraries
library(data.table)

#Reading train data
train<-fread('train_cat.csv')

#Identify indices with brand name as NA
df<-train[train$brand_name=='',]

#Identifying brand name using name
brands<-unique(train$brand_name)
brands<-brands[brands!='M']

for (i in 1:length(brands)){
  places<-grep(brands[i],df$name)
  df$brand_name[places]<-brands[i]
  print(i)
}
