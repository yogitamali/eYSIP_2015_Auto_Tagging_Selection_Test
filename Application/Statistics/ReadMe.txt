

General Information:

1. This part of the project aims at displaying some interesting statistics about the data.
2. Actual queries are contained in SQL Queries.sql
3. Data description 'i' in this file corresponds to query 'i' in SQL Queries.txt
4. Query 6 may take about 25 seconds to complete, other queries normally finish execution within 5 seconds.


Data Description

1. Returns data in the format:
   team_id    Average Score within Team    Standard Deviation within Team    Number of Members who Attempted the Test
   
   Purpose:
   1.1. team_id -> Represents the id of team for which the record is being generated.
   1.2. Average Score within Team -> Represents average score of all members of the team.
   1.3. Standard Deviation within Team -> Represents a measure of difference of performance of team members within a team. Gives an idea of level of various members present in the team.
   1.4. Number of Members who Attempted the Test from the team

2. Returns data in the following format:
   team_id    Average Score within Team    Normalized Team Score across all teams
   
   Purpose:
   2.1. Same as 1.1
   2.2. Same as 1.2
   2.3. Normalized Team Score  across all Team -> Gives a measure of team performance w.r.t. the mean performance of all the teams.
   
   
3. Returns data in the following format:
   question_id    Average Score    Standard Deviation across all Questions
   
   Purpose:
   3.1. question_id -> The id of question.
   3.2. Average Score -> Average Score of students on this question.
   3.3. Standard Deviation across all Questions -> A measure of how score of students on this question compares to average performancne of students on questions.
   

4. Returns data in the following format:
   team_id    Category Name    Average Marks in Category
   
   Purpose:
   4.1. Same as 1.1
   4.2. Category Name -> Name of Category
   4.3. Average Performance on Category -> Average Marks of this Team in this Category. Shows the category wise performance of various teams.
   
   
5. Returns data in the following format:
   category_id    category_name    Average Performance on Category
   
   Purpose:
   5.1. category_id -> Id of the category being referred.
   5.2. Same as 4.2
   5.3. Averaege Performance on Category -> Average marks of all the students in this category.
   
   
6. Returns data in the following format:
   branch    category name    Average Score
   
   Purpose:
   6.1. branch -> Refers to branch of students.
   6.2. same as 4.2
   6.3. Average Score -> Average score of students from this branch on a question from this category. Shows whether the test for biased for students from some particular branch.
