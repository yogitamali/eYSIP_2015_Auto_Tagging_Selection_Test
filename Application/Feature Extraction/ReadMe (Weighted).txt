
Weighted SQL Queries.sql contains SQL Queries to Extract the required features from database for the purpose of feeding them to the learning algorithm.

Weights SQL Queries.sql contains queries for two weighted features in order. The two features and their purpose have been described here:


1. Feature 1 -> Fraction of People who solved the given question correctly adjusted by weights.
   
   Output is in following format in table WeightedFeature1:
       
       question_id    feature1
       

2. Feature 2 -> Average marks of people who solved the given question incorrectly or who did not solve the given question at all.
   
   Output is in following format:
   
       question_id    feature2


Rest of the details can be found in Weighted SQL Queries.sql
