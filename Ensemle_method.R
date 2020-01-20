getwd()
file.data <- read.csv("InsuranceLosses.csv")
install.packages('dplyr')
library(dplyr)
glimpse(file.data)
file.data <- file.data[,-1]
file.data <- file.data %>% na.omit()
set.seed(2)
train <- sample(1:nrow(file.data),0.6*nrow(file.data))
file.data.train <- file.data[train,]
file.data.test <- file.data[-train,]
install.packages("randomForest")
library(randomForest)
class_rf <- randomForest(Losses~., data = file.data.train)
class_rf
Train.RMSE = sum((file.data.train$Losses-predict(class_rf, newdata = file.data.train))**2) %>% sqrt()
Train.RMSE
Test.RMSE = sum((file.data.test$Losses - predict(class_rf, newdata = file.data.test))**2) %>% sqrt()
Test.RMSE
importance(class_rf)
varImpPlot(class_rf)
