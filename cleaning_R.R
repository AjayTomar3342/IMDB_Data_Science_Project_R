# #Installing and loading required packages
# install.packages("dplyr")
# library(dplyr)
# install.packages("tidyr")
# library(tidyr)
# install.packages("splitstackshape")
# library(splitstackshape)
# install.packages("plyr")
# library(plyr)

cleaning <-function(){

  #Read the web scraped file 
  data<-read.csv("Data_Files/Pre-cleaned-file.csv")
  
  data<-data.frame(data)
  #Remove ')', '(', 'I'from Release Year column
  data$Release.Year = as.character(gsub("\\(","",data$Release.Year))
  data$Release.Year = as.character(gsub("\\)","",data$Release.Year))
  data$Release.Year = as.character(gsub("\\I","",data$Release.Year))
  
  #Remove 'min' from Duration column
  data$Duration.Min.. = as.character(gsub("\\min","",data$Duration.Min..))
  
  #Remove ',' from Votes column
  data$Votes = as.integer(gsub("\\,","",data$Votes))
  
  #Split Sub Genres column into three columns
  data<-cSplit(data,"Sub.Genres",",")
  
  #Rename Primary and Sub Genre Column names
  data<-rename(data, c("Genre"="Primary Genre","Sub.Genres_1"="Sub Genre 1", "Sub.Genres_2"="Sub Genre 2","Sub.Genres_3"="Sub Genre 3"))
  
  #Split Directors & Actors Column into Directors and Actors
  data<-cSplit(data,"Directors...Actors","|")
  
  
  #Remove Directors from Directors Column
  data$Directors...Actors_1 = as.character(gsub("\\Directors:","",data$Directors...Actors_1))
  
  #Remove Director from Directors Column
  data$Directors...Actors_1 = as.character(gsub("\\Director:","",data$Directors...Actors_1))
  
  #Remove Stars from Actors Column 
  data$Directors...Actors_2 = as.character(gsub("\\Stars:","",data$Directors...Actors_2))
  
  #Split Actors Column into four columns
  data<-cSplit(data,"Directors...Actors_2",",")
  
  #Rename four actor columns
  data<-rename(data, c("Directors...Actors_1"="Director","Directors...Actors_2_1"="Actor #1","Directors...Actors_2_2"="Actor #2","Directors...Actors_2_3"="Actor #3","Directors...Actors_2_4"="Actor #4"))
  
  #Copy the main dataframe to a temporary one
  data2<-data
  
  #Remove whitespaces from Director Column
  data2$Director <-trimws(data2$Director,which=c("both"))
  
  #Delete Sub Genre 3 column as 25% rows had NA and the column itself isn't very important
  data2<-subset(data2,select=-c(`Sub Genre 3`))
  
  #Convert Data Types of all required columns
  data2$Title <-as.character(data2$Title)
  data2$Release.Year <- as.integer(data2$Release.Year)
  data2$Duration.Min.. <- as.integer(data2$Duration.Min..)
  data2$User.Rating <-as.double(data2$User.Rating)
  data2$Director <- as.character(data2$Director)
  data2$`Actor #1` <-as.character(data2$`Actor #1`)
  data2$`Actor #2` <-as.character(data2$`Actor #2`)
  data2$`Actor #3` <-as.character(data2$`Actor #3`)
  data2$`Actor #4` <-as.character(data2$`Actor #4`)
  
  #Save file 
  write.csv(data2,"Data_Files/R-Cleaned-File.csv")
}