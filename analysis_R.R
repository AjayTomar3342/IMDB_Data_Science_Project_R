# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("gridExtra")
# install.packages("tidyverse")
# install.packages("grid")
# install.packages("installr")
# install.packages("broom", type="binary")
# library(dplyr)
# library(ggplot2)
# library(gridExtra)
# library(tidyverse)
# library(grid)
# library(installr)


analysis<-function(){
  #updateR()
  source("multiplot_R.r") 
  
  #Read in Cleaned File for analysis
  data2<-read.csv("Data_Files/R-Cleaned-File.csv",stringsAsFactors = FALSE)
  
  data2<-as.data.frame(data2)
  
  
  #Get movies with more than 7500 votes and 6 user rating
  movies_with_more_than_7500_votes_and_6_user_rating<-subset(data2,data2$Votes>7500 & data2$User.Rating>6)
  
  
  # ### % of Titles starting with specific characters ###
  # #Create a list of alphabets
  alphabet_list<-c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
  
  #Empty list to keep individual frequency count of all alphabets in alphabet_list
  alphabet_count<-c()
  #
  #Get a more legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  
  #Take counts of all the resepctive starting characters and store them in the empty alphabet count list
  for (i in alphabet_list){
    selected_group=grep(paste("^",i, sep=""),ignore.case=TRUE, group$Title)
    alphabet_count<-c(alphabet_count,length(selected_group))
  }
  
  #Get count of other starting characters of movie title
  others_count=length(group$Title)-sum(alphabet_count)
  
  #Append other movie character count to the lists
  alphabet_list<-c(alphabet_list,'Numerals and Other symbols')
  alphabet_count<-c(alphabet_count,others_count)
  
  #Create a dataframe with the alphabet lists
  starting_alphabet_df=data.frame(alphabet_list,alphabet_count)
  
  #Give names to data frame columns
  names(starting_alphabet_df)<-c("Alphabets","Counts")
  #
  # #Plot the graph
  ggplot(data=starting_alphabet_df,mapping=aes(x=alphabet_list,y=alphabet_count)) +geom_bar(stat="identity",fill="steelblue") + ggtitle("Count of Starting character in movie titles") +
    xlab("Alphabets") + ylab("Counts") + theme(plot.title = element_text(hjust = 0.5))
  
  
  
  # ### Top movies count year wise ###
  #
  #Get a legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  
  #Group by release year, count year wise movies and save as data frame
  year_wise_movie_count_df =data.frame(group %>% dplyr::count(Release.Year))
  
  #Provide names for data frame
  names(year_wise_movie_count_df)<-c('Release Year','Movie Counts')
  #
  # #Plot the graph
  ggplot(data=year_wise_movie_count_df,mapping=aes(x=`Release Year`,y= `Movie Counts`)) +geom_bar(stat="identity",fill="steelblue") + ggtitle("Year Wise movie count") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  # ### Average movie runtime per year ###
  #
  #Get a legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  
  #Group by year and get yearly movie average runtime
  year_wise_movie_average_runtime = data.frame(aggregate(Duration.Min.. ~Release.Year,group, mean))
  
  #Provide names for data frame
  names(year_wise_movie_average_runtime)<-c('Release Year', 'Average Movie Run Time')
  #
  # #Plot the graph
  ggplot(data=year_wise_movie_average_runtime,mapping=aes(x=`Release Year`,y= `Average Movie Run Time`)) +geom_bar(stat="identity",fill="steelblue") + ggtitle("Year Wise movie average runtime") +xlab("Release Year") + ylab("Average Movie Runtime") + theme(plot.title = element_text(hjust = 0.5))
  
  
  # ### Genre Wise movie proprotion per year###
  
  #Get a legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  
  #Group by year and genre and get genre wise proprtion per year
  year_wise_movie_count = data.frame(group%>%group_by(Release.Year,Primary.Genre)%>%select(Release.Year,Primary.Genre)%>%dplyr::count(Primary.Genre))
  
  #Provide names for data frame
  names(year_wise_movie_count)<-c('Release Year', 'Genre','Count of Movies')
  #
  # #Plot the graph
  ggplot(data=year_wise_movie_count,mapping=aes(x=`Release Year`,y= `Count of Movies`,fill=`Genre`)) +geom_bar(stat="identity",position="stack") + ggtitle("Genre Wise Movies by year") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  
  # # ### User Votes increase/decrease per year###
  # #
  # #Get a legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  #
  # #Group by year and get total user votes
  year_wise_user_vote_count = data.frame(aggregate(Votes ~Release.Year,group, sum))
  #
  # #
  # # #Provide names for data frame
  names(year_wise_user_vote_count)<-c('Release Year', 'Total User votes')
  # #
  # # #Plot the graph
  ggplot(data=year_wise_user_vote_count,mapping=aes(x=`Release Year`,y= `Total User votes`)) +geom_bar(stat="identity",fill="red") + ggtitle("Year Wise Total User Votes") +xlab("Release Year") + ylab("Total User Votes") + theme(plot.title = element_text(hjust = 0.5))
  
  
  # # ### Top rated movie per year###
  #
  # #Get a legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  #
  # #Group by year and get maximum user vote per year
  year_wise_top_movie = group%>%group_by(`Release.Year`,`User.Rating`)%>%select(Release.Year,User.Rating,Title)
  year_wise_top_movie=year_wise_top_movie%>%group_by(`Release.Year`) %>% slice(which.max(`User.Rating`))
  
  # #Provide names for data frame
  names(year_wise_top_movie)<-c('Release Year', 'User Rating','Title')
  #
  # #Plot the graph
  ggplot(data=year_wise_top_movie,mapping=aes(x=`Release Year`,y= `User Rating`)) +geom_bar(stat="identity",fill="green") + ggtitle("Year Wise Best Movie") +xlab("Release Year") + ylab("User Rating") + theme(plot.title = element_text(hjust = 0.5))
  
  
  # # ### Genre Based Top movies###
  #
  # #Get a legible name
  group=movies_with_more_than_7500_votes_and_6_user_rating
  #
  # #Get count of movies genre wise
  genre_wise_top_movies = data.frame(group%>%group_by(`Primary.Genre`)%>%count())
  #
  # #Provide names for data frame
  names(genre_wise_top_movies)<-c('Genre', 'Movie Count')
  #
  # #Plot the graph
  ggplot(data=genre_wise_top_movies, aes(x="", y=`Movie Count`, fill=Genre)) +geom_bar(width=1, stat="identity") + coord_polar("y",start=0)
  
  
  #To be used for finding best director and actors
  movies_with_more_than_5000_votes<-subset(data2,data2$Votes>5000)
  
  # # ### Most successfull Primary Actor###
  #
  # #Get a legible name
  group=movies_with_more_than_5000_votes
  
  
  # #Get movie count respective to each primary actor
  primary_actor_movie_count = data.frame(group%>%group_by(`Actor..1`)%>%dplyr::count(Actor..1)) %>%arrange(desc(n))
  
  #Filter out actors with more than 50 movies
  primary_actor_movie_count = head(primary_actor_movie_count,75)

  # #Provide names for actor and movie count dataframe
  names(primary_actor_movie_count)<-c('Actor', 'Movie Count')
  #
  #Get rows which contains primary actors present in the above mentioned dataframe
  primary_actor_average_user_rating = data.frame(filter(group,group$Actor..1 %in% primary_actor_movie_count$Actor))
  
  #Get average user rating for the filtered out actors
  primary_actor_average_user_rating = data.frame(aggregate(User.Rating ~ Actor..1,primary_actor_average_user_rating,mean))
  
  #Give names to dataframe
  names(primary_actor_average_user_rating)<-c('Actor','Average User Rating')
  
  df = data.frame(Actor=primary_actor_average_user_rating$Actor,Average=primary_actor_average_user_rating$`Average User Rating`)
  # # #Plot the graph
  ggplot(df, aes(fct_reorder(Actor, Average),Average)) + geom_bar(stat="identity",fill="steelblue") + coord_flip() + ggtitle("Highest User rated Primary Actor with at least 50 movies") +xlab("Average User Rating") + ylab("Actor") + theme(plot.title = element_text(hjust = 0.5))
  
  #
  # # ### Most successfull Supporting Actor###
  #
  # #Get a legible name
  group=movies_with_more_than_5000_votes
  #
  # #Get movie count respective to each supporting actor
  supporting_actor_movie_count = data.frame(group%>%group_by(`Actor..2`)%>%dplyr::count(Actor..2)) %>%arrange(desc(n))
  #
  #
  # #Filter out actors with more than 30 movies
  supporting_actor_movie_count=head(supporting_actor_movie_count,70)
  # #
  # # #Provide names for actor and movie count dataframe
  names(supporting_actor_movie_count)<-c('Actor', 'Movie Count')
  #
  #Get rows which contains supporting actors present in the above mentioned dataframe
  supporting_actor_average_user_rating = data.frame(filter(group,group$Actor..2 %in% supporting_actor_movie_count$Actor))
  
  #Get average user rating for the filtered out actors
  supporting_actor_average_user_rating = data.frame(aggregate(User.Rating ~ Actor..2,supporting_actor_average_user_rating,mean))
  
  #Give names to dataframe
  names(supporting_actor_average_user_rating)<-c('Actor','Average User Rating')
  
  df = data.frame(Actor=supporting_actor_average_user_rating$Actor,Average=supporting_actor_average_user_rating$`Average User Rating`)
  # #Plot the graph
  ggplot(df, aes(fct_reorder(Actor, Average),Average)) + geom_bar(stat="identity",fill="steelblue") + coord_flip() + ggtitle("Highest User rated Supporting Actor with at least 30 movies") +xlab("Average User Rating") + ylab("Actor") + theme(plot.title = element_text(hjust = 0.5))
  
  
  
  # # ### Most successfull Secondary Supporting Actor###
  #
  # #Get a legible name
  group=movies_with_more_than_5000_votes
  #
  # #Get movie count respective to each secondary supporting actor
  secondary_supporting_actor_movie_count = data.frame(group%>%group_by(`Actor..3`)%>%dplyr::count(Actor..3)) %>%arrange(desc(n))
  
  
  #Filter out actors with more than 20 movies
  secondary_supporting_actor_movie_count=head(secondary_supporting_actor_movie_count,80)
  #
  # #Provide names for actor and movie count dataframe
  names(secondary_supporting_actor_movie_count)<-c('Actor', 'Movie Count')
  #
  #Get rows which contains secondary supporting actors present in the above mentioned dataframe
  secondary_supporting_actor_average_user_rating = data.frame(filter(group,group$Actor..3 %in% secondary_supporting_actor_movie_count$Actor))
  
  #Get average user rating for the filtered out actors
  secondary_supporting_actor_average_user_rating = data.frame(aggregate(User.Rating ~ Actor..3,secondary_supporting_actor_average_user_rating,mean))
  
  #Give names to dataframe
  names(secondary_supporting_actor_average_user_rating)<-c('Actor','Average User Rating')
  
  df = data.frame(Actor=secondary_supporting_actor_average_user_rating$Actor,Average=secondary_supporting_actor_average_user_rating$`Average User Rating`)
  # # #Plot the graph
  ggplot(df, aes(fct_reorder(Actor, Average),Average)) + geom_bar(stat="identity",fill="steelblue") + coord_flip() + ggtitle("Highest User rated Secondary Supporting Actor with at least 20 movies") +xlab("Average User Rating") + ylab("Actor") + theme(plot.title = element_text(hjust = 0.5))
  
  
  
  # # ### Most successfull Director###
  #
  # #Get a legible name
  group=movies_with_more_than_5000_votes
  #
  # #Get movie count respective to each director
  director_movie_count = data.frame(group%>%group_by(`Director`)%>%dplyr::count(Director)) %>%arrange(desc(n))
  
  #Filter out directors with more than 30 movies
  director_movie_count=head(director_movie_count,100)
  #
  # #Provide names for director and movie count dataframe
  names(director_movie_count)<-c('Director', 'Movie Count')
  #
  #Get rows which contains directors present in the above mentioned dataframe
  director_average_user_rating = data.frame(filter(group,group$Director %in% director_movie_count$Director))
  
  #Get average user rating for the filtered out directors
  director_average_user_rating = data.frame(aggregate(User.Rating ~ Director,director_average_user_rating,mean))
  
  #Give names to dataframe
  names(director_average_user_rating)<-c('Director','Average User Rating')
  
  df = data.frame(Director=director_average_user_rating$Director,Average=director_average_user_rating$`Average User Rating`)
  # # #Plot the graph
  ggplot(df, aes(fct_reorder(Director, Average),Average)) + geom_bar(stat="identity",fill="steelblue") + coord_flip() + ggtitle("Highest User rated Director with at least 30 movies") +xlab("Average User Rating") + ylab("Director") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Genres popularity over the years###
  
  #Get the data to be used in a legible named data frame
  group = data2
  
  #Group year and genre wise and get the count of each combination
  year_and_genre_wise_count = data.frame(group %>% group_by(`Release.Year`,`Primary.Genre`) %>% count())
  
  
  ###Drama Genre Popularity over the years###
  
  #Get all drama genre movies
  drama_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Drama')
  
  #Plot Drama Genre Popularity
  p1<-ggplot(data=drama_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="brown") + ggtitle("Drama Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###War Genre Popularity over the years###
  
  #Get all war genre movies
  war_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'War')
  
  #Plot war Genre Popularity
  p2<-ggplot(data=war_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#6600CC") + ggtitle("War Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Comedy Genre Popularity over the years###
  
  #Get all comedy genre movies
  comedy_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Comedy')
  
  #Plot Comedy Genre Popularity
  p3<-ggplot(data=comedy_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#FFCC00") + ggtitle("Comedy Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Action Genre Popularity over the years###
  
  #Get all action genre movies
  action_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Action')
  #
  #Plot Action Genre Popularity
  p4<-ggplot(data=action_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#CC0000") + ggtitle("Action Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Fantasy Genre Popularity over the years###
  
  #Get all fantasy genre movies
  fantasy_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Fantasy')
  
  #Plot Fantasy Genre Popularity
  p5<-ggplot(data=fantasy_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#00FF00") + ggtitle("Fantasy Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Horror Genre Popularity over the years###
  
  #Get all horror genre movies
  horror_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Horror')
  
  #Plot Horror Genre Popularity
  p6<-ggplot(data=horror_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#FF6600") + ggtitle("Horror Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Mystery Genre Popularity over the years###
  
  #Get all mystery genre movies
  mystery_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Mystery')
  
  #Plot Mystery Genre Popularity
  p7<-ggplot(data=mystery_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#CC99CC") + ggtitle("Mystery Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Thriller Genre Popularity over the years###
  
  #Get all thriller genre movies
  thriller_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Thriller')
  
  #Plot Thriller Genre Popularity
  p8<-ggplot(data=thriller_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#C0C0C0") + ggtitle("Thriller Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  
  ###Crime Genre Popularity over the years###
  
  #Get all crime genre movies
  crime_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Crime')
  
  #Plot Crime Genre Popularity
  p9<-ggplot(data=crime_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#FFFFFF") + ggtitle("Crime Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  
  ###Animation Genre Popularity over the years###
  
  #Get all Animation genre movies
  animation_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Animation')
  
  #Plot Animation Genre Popularity
  p10<-ggplot(data=animation_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#CC99CC") + ggtitle("Animation Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ###Biography Genre Popularity over the years###
  
  #Get all Biography genre movies
  biography_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Biography')
  
  #Plot Animation Genre Popularity
  p11<-ggplot(data=biography_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#E18A07") + ggtitle("Biography Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  
  ##Sci-Fi Genre Popularity over the years###
  
  #Get all Sci-Fi genre movies
  scifi_genre_year_wise_count=subset(year_and_genre_wise_count,Primary.Genre == 'Sci-fi')
  
  #Plot Sci-Fi Genre Popularity
  p12<-ggplot(data=scifi_genre_year_wise_count,mapping=aes(x=`Release.Year`,y= `freq`)) +geom_histogram(stat="identity",color="black", fill="#CC3300") + ggtitle("Sci-fi Genre Popularity over the years") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
  
  multiplot(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, cols=4)
  
  
  # ###Decade Wise Movie Count###
  #
  group<-data2
  #
  #
  # #Create a column decade on basis of movies release year
  group$Decade <-NA
  group$Decade[(group$Release.Year>1910) & (group$Release.Year<=1920)]<-"1910-1920"
  group$Decade[(group$Release.Year>1920) & (group$Release.Year<=1930)]<-"1920-1930"
  group$Decade[(group$Release.Year>1930) & (group$Release.Year<=1940)]<-"1930-1940"
  group$Decade[(group$Release.Year>1940) & (group$Release.Year<=1950)]<-"1940-1950"
  group$Decade[(group$Release.Year>1950) & (group$Release.Year<=1960)]<-"1950-1960"
  group$Decade[(group$Release.Year>1960) & (group$Release.Year<=1970)]<-"1960-1970"
  group$Decade[(group$Release.Year>1970) & (group$Release.Year<=1980)]<-"1970-1980"
  group$Decade[(group$Release.Year>1980) & (group$Release.Year<=1990)]<-"1980-1990"
  group$Decade[(group$Release.Year>1990) & (group$Release.Year<=2000)]<-"1990-2000"
  group$Decade[(group$Release.Year>2000) & (group$Release.Year<=2010)]<-"2000-2010"
  group$Decade[(group$Release.Year>2010) & (group$Release.Year<=2020)]<-"2010-2020"
  #
  # #Get decade wise movie count
  decade_wise_movie_count = group %>% group_by(`Decade`)%>%count()
  #
  # #Plot the graph
  ggplot(data=decade_wise_movie_count, mapping=aes(x=`Decade`, y=`freq`)) +geom_histogram(stat="identity",color="black",fill="white")+ ggtitle("Decade wise reviewed movies count") +xlab("Release Year") + ylab("Movie Count") + theme(plot.title = element_text(hjust = 0.5))
}
