#I would like to thank Jason Tanuwijaya for his input and suggestions in the writing of this code
#For this script in particular, credits go to Jason Tanuwijaya for his Python help in debugging version problems in this Python code and for his assistance with Python.

import pandas as pd
import pygeohash as pgh

x = pd.read_csv("training.csv")

location = x.geohash6.apply(lambda x: pgh.decode(x))
x['location'] = location

x.to_csv('training_translated_gh.csv', index=False)
