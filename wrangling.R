#I would like to thank Jason Tanuwijaya for his input and suggestions in the writing of this code
#Credits also go to DataCamp, whose machine learning and R data science lessons have served as great sources of inspiration and influence for my code for this problem

#Install the packages we require
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

#Importing the decoded data set
x <- read.csv("training_translated_gh.csv", stringsAsFactors = FALSE)

#Converting days into days of the week (Credits to Jason Tanuwijaya for his suggestion)
x$dayoftheweek <- x$day %% 7
x$dayoftheweek <- as.factor(x$dayoftheweek)

#Converting timestamps into three-hour intervals
x <- separate(x,timestamp,into = c("hour","minute"),sep = ":")
x$hour <- as.integer(x$hour)
x$q1 <- ifelse(x$hour %in% c(0:2),1,0)
x$q2 <- ifelse(x$hour %in% c(3:5),1,0)
x$q3 <- ifelse(x$hour %in% c(6:8),1,0)
x$q4 <- ifelse(x$hour %in% c(9:11),1,0)
x$q5 <- ifelse(x$hour %in% c(12:14),1,0)
x$q6 <- ifelse(x$hour %in% c(15:17),1,0)
x$q7 <- ifelse(x$hour %in% c(18:20),1,0)
x$q8 <- ifelse(x$hour %in% c(21:23),1,0)

#Splitting decoded coordinates into two columns and cleaning columns
x <- separate(x,location,into = c("lat","long"),sep = ", ")

x$lat <- as.numeric(gsub("\\(", "", x$lat))
x$long <- as.numeric(gsub("\\)", "", x$long))

#Performing cluster analysis on coordinates to better group them
##Isolating coordinates columns
coordinates <- cbind(x$lat,x$long)
##Scaling and centering
coordinates <- as.data.frame(scale(coordinates, center = TRUE, scale = TRUE))

#Generating scree plot to determine optimal number of clusters
a <- 0

#For 1 to 15 cluster centers
for (i in 1:15) {
  kmeanstesting <- kmeans(coordinates, centers = i, nstart = 20)
  a[i] <- kmeanstesting$tot.withinss
}

# Plot a scree plot to show the relationship between total within sum of squares and clusters
plot(1:15, a, type = "b", 
     xlab = "Cluster number", 
     ylab = "Total within group sum of squares")

#From the scree plot, it appears that k = 4 is ideal

#Generating 4 clusters
kmeans <- kmeans(coordinates, 4, nstart = 20)
xwithcluster <- cbind(x,kmeans$cluster)
xwithcluster <- cbind(xwithcluster,dummy(xwithcluster$`kmeans$cluster`))

#Selecting only the columns that we are interested in
wrangled <- xwithcluster[,c(5,6,7,9:16,18:ncol(xwithcluster))]

#Exporting dataframe as wrangled CSV file
write.csv(wrangled, "wrangled.csv")
