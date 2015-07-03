
SQL Queries.sql contains SQL Queries to Extract the required features from database for Part 2.

The features and their purpose have been described here:

1. Feature 1 -> Year in college. Will be used as a set of binary features.
   1.1. is_one()
   1.2. is_two()
   1.3. is_three()
   1.4. is_four()
   1.5. is_other_year()
   
   Output is in following format in table Part2Feature1:
          
       team_member_id    feature1
       

2. Feature 2 -> Student's major. Eg. Computer Science etc. Will be used as a set of binary features.
   2.1. is_branch_i()	-- Where i represents id given to a major (branch)
   						-- This feature is present for all majors
   						-- i ranges from [1,n] where n = number of distinct branches
   2.2. is_other_branch()
   
   Output is in following format in table Part2Feature2:
   
       team_member_id    feature2
          

3. Feature 3 -> Gender of the student. Used as a set of binary features.
   3.1. is_male()
   3.2. is_female()
   3.3. is_other_gender()
   
   Output is in following format in table Part2Feature3:
   
       team_member_id    feature3
              

4. Feature 4 -> State to which student belongs. Will be used as a set of binary features.
   4.1. is_state_i()	-- Where i represents id given to a state
   						-- This feature is present for all states
   						-- i ranges from [1,n] where n = number of distinct states
   4.2. is_other_state()
   
   Output is in following format:
   
       team_member_id    feature4
              

5. Feature 5 -> Region to which student belongs. Will be used as a set of binary features.
   5.1. is_region_i()	-- Where i represents id given to a region
   						-- This feature is present for all regions
   						-- i ranges from [1,n] where n = number of distinct region
   						-- pincode has been used to identify regions 		 
   5.2. is_other_region()
      
   Output is in following format:
   
       team_member_id    feature5
              

6. Feature 6 -> College to which student belongs. Will be used as a set of binary features.
   6.1. is_college_i()	-- Where i represents id given to a college
   						-- This feature is present for all colleges
   						-- i ranges from [1,n] where n = number of distinct colleges
   6.2. is_other_college()
      
   Output is in following format:
   
       team_member_id    feature6
              

7. Feature 7 -> Role of student. Will be used as a set of binary features.
   7.1. is_member()
   7.2. is_leader()
   7.3. is_other()
      
   Output is in following format:
   
       team_member_id    feature7



Rest of the details can be found in SQL Queries.sql
