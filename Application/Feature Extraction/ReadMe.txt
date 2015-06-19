
SQL Queries.sql contains SQL Queries to Extract the required features from database for the purpose of feeding them to the learning algorithm.

SQL Queries.sql contains queries for 7 features in order. The 7 features and their purpose have been described here:


1. Feature 1 -> Fraction of People who did not attempt the given question.
   
   Output is in following format in table NewFeature1:
       
       question_id    feature1
       

2. Feature 2 -> Fraction of People who solved the given question correctly
   
   Output is in following format:
   
       question_id    feature2
          

3. Feature 3 -> Fraction of People who solved the given question incorrectly
   
   Output is in following format:
   
       question_id    feature3
              

4. Feature 4 -> Average Marks of People who solved the given question correctly
   
   Output is in following format:
   
       question_id    feature4
              

5. Feature 5 -> Average Marks of People who solved the given question incorrectly
   
   Output is in following format:
   
       question_id    feature5
              

6. Feature 6 -> Average Marks of People who did not attempt the given question
   
   Output is in following format:
   
       question_id    feature6
              

7. Feature 7 -> Fraction of People in top 10 percentile who solved the given question correctly
   
   Output is in following format:
   
       question_id    feature7



Rest of the details can be found in SQL Queries.sql


Other Proposed Features:

1. Fraction of people in the top 10 percentile who solved the question incorrectly
2. Fraction of people in the top 10 percentile who did not attempt the question.
3. Mean performance of students given the set id and question id.
