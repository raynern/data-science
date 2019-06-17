#I would like to thank Jason Tanuwijaya for his input and suggestions in the writing of this code
#Credits also go to DataCamp, whose machine learning and R data science lessons have served as great sources of inspiration and influence for my code for this problem

install.packages("tidyverse")
install.packages("caret")
install.packages("dummies")
install.packages("rsample")
install.packages("Metrics")
library(tidyverse)
library(caret)
library(dummies)
library(rsample)
library(Metrics)

#Import the wrangled CSV file

wrangled <- read.csv("wrangled.csv", stringsAsFactors = FALSE)

#Finding outliers and removing them
hist(wrangled$demand)
wrangled <- wrangled[wrangled$demand <0.8,]

#Choosing the variables we are interested in
wrangled <- wrangled[,-c(1,3,4)]

#Modelling the first time, all predictors, by testing a randomised half of the training set on the other randomised half

subset <- sample(nrow(wrangled),(nrow(wrangled)/2))
wrangled1 <- wrangled[subset,]
wrangled2 <- wrangled[-subset,]
allpredictormodel <- glm(demand~., data=wrangled1)
summary(allpredictormodel)
bestmodel <- step(glm(demand~., data=wrangled1),direction = "both")
summary(bestmodel)

#Based on stepwise regression, we obtained an optimal model that used predictors q1-5 and q7-8, and clusters 1-3. We will split our training data into random halves and use one half to train a model to test on the other half based on these selected predictors

stepwiseregressionpredicted <- predict(bestmodel,wrangled2)
actual <- wrangled2$demand
error <- actual - stepwiseregressionpredicted
mean(abs(error))/mean(actual)

#Unfortunately, the accuracy rate of my multiple linear regression model is poor. Nevertheless, this was an interesting experience in applying what I have learnt in online courses to a real situation, and motivates me to improve my data science skills further.
