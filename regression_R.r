# install.packages("corrplot")
# install.packages("caret")
# install.packages("randomForest")
# install.packages("ridge")
# 
# library(dplyr)
# library(ggplot2)
# library(gridExtra)
# library(tidyverse)
# library(grid)
# library(corrplot)
# library(caret)
# library(randomForest)
# library(ridge)

regression<-function(){
  set.seed(123)
  #Read the dataset
  data<-read.csv("Data_Files/Label-Encoded-data.csv",stringsAsFactors = FALSE,row.names =NULL)
  
  
  #Remove index column
  data<-subset(data,select=-c(X))
  
  
  #Filter out movies above 5000 votes
  data<-subset(data,data$Votes>5000)
  
  #Remove all duplicate rows
  data<-data[!duplicated(data$Title),]
  
  #Remove title column
  data<-subset(data,select=-c(Title))
  
  #Convert type to data frame, if not already a data frame
  data<-data.frame(data)
  
  #Create Correlation Matrix
  correlation_matrix<-cor(data, method=c("pearson"),use="complete.obs")
  
  #Remove those columns which do not have a significant correlation with User Rating
  data<-subset(data,select=-c(Director,Genre,Sub.Genre.1,Sub.Genre.2,Actor..1,Actor..2,Actor..3,Actor..4))
  
  #Create train and test index dataset
  train_index<-sample(1:nrow(data),0.8*nrow(data))
  test_index<-setdiff(1:nrow(data),train_index)
  
  #Divide into train and test datasets
  X_train <- data[train_index, -4]
  y_train <- data[train_index, "User.Rating"]
  
  X_test <- data[test_index, -4]
  y_test <- data[test_index, "User.Rating"]
  
  
  ###K Nearest Neighbor Regression###
  
  #Fit training data
  fit_knn<-knnreg(X_train,y_train,k=12)
  
  #Predict values of test data
  y_pred_knn<-predict(fit_knn,X_test)
  
  #Find R2 score
  r2_knn<-R2(y_pred_knn,y_test)
  print(r2_knn)
  
  #Finding RMSE, 0.78/Mean(y_test)=> 0.78/6.5 gives 12.5 error rate which is low and good
  rmse_knn<-RMSE(y_pred_knn,y_test)
  print(rmse_knn)
  
  #Get mean absolute error
  mae_knn<-MAE(y_pred_knn,y_test)
  print(mae_knn)
  
  
  
  
  
  ###Simple Linear Modelling###
  linearMod <- lm(User.Rating~ Duration.Min.. +Ranking +Release.Year + Votes, data=data) 
  
  #Calculated Adjusted R2 score of linear model
  adjusted_r2_lm<-0.4483
  
  #Calculated P-value of linear model
  p_value_lm<-2.2e-16
  
  
  
  
  
  #Random Forest Regression###
  
  #Create the model
  # model_rfr <- randomForest(User.Rating ~ ., data = data, mtry = 4, importance = TRUE, na.action = na.omit) 
  # 
  # #Store variance explained by model
  # var_explained<-71.21
}




