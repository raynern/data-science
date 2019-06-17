# grab-ai-for-sea

This is my submission for the Traffic Management Challenge of Grab AI for SEA 2019.

Credits and acknowledgements:
#I would like to thank Jason Tanuwijaya for his input and suggestions in the writing of this code.
#For the Python script in particular, credits go to Jason Tanuwijaya for his Python help in debugging version problems in the Python code and for his assistance with Python in general.
#Credits also go to DataCamp, whose machine learning and R data science lessons have served as great sources of inspiration and influence for my code for this problem.

There are three files in the repository, and should be run in the following order:

1. decoding.py
- This code helps decode the geohashes in the dataset to their respective coordinates, and produces a translated dataset to be imported by 2.

2. wrangling.R
- This code helps us transform the variables via string manipulation, dummifying methods and cluster analysis, and produces a wrangled dataset to be imported by 3.

3. modelling.R
- This code first checks for extreme outliers in demand, processes them, before applying stepwise regression to the wrangled dataset to identify which variables are the strongest predictors. These predictors are then used to fit a 'best model' to train a randomised half of the training set, and then tested on the other randomised half of the same training set.

Note:
#Unfortunately, the accuracy rate of my multiple linear regression model is poor. Nevertheless, this was an interesting experience in applying what I have learnt in online courses to a real situation for the first time, and motivates me to improve my data science skills further.
