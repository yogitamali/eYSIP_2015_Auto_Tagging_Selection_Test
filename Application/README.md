# eYSIP_2015_Auto_Tagging_Selection_Test
Part 1: The aim of part 1 of the project is to use the data generated during the online selection test for e-YRC 2015 to determine the accuracy of the manual difficulty tagging process. Each question is manually assigned a difficulty and the project will aim to find the accuracy and also suggest auto corrections based on the performance of students towards the questions and its assigned difficulty. Part 2: Given the profile of a student taking the test, create a Machine Learning model to deduce its performance in the selection test based on the current year's data.

# Usage
**Step 1:** Set up the database named 'eyrc14_auto_data_analysis' with the same structure as was used during the internship.

**Step 2:** Run all the queries in /Application/Feature Extraction/Weighted SQL Queries.sql. This will generate a file at the location '/tmp/weightedfeatures.csv'.

**Step 3:** Copy the file generated in step 2 to /Application/Weighted Clustering/

**Step 4:** Run the file 'main.m' using octave command line. This will generate a file '/Application/Weighted Clustering/output_labels.csv'.

The output_labels.csv file contains two columns. The first column is for question id and the second column contains the new label for the corresponding question id.

**Label Semantics:**

0 -> Easy

1 -> Medium

2 -> Hard
