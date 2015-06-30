use eyrc14_auto_data_analysis;

-- Drop original tables if they exist
drop table if exists WeightedFeature1;
drop table if exists WeightedFeature2;
drop table if exists w_values;
drop table if exists WeightedFeatures;


-- Create the table for weight values
create table w_values 
(
test_id INT(11) PRIMARY KEY,
w FLOAT(7, 5)
);

-- Calculate w values for each test id
set @alpha = 1;	-- Parameter which governs the first order derivative of w values wrt marks_scored

insert into w_values
select distinct id, 2/(1 + exp(@alpha * (avgMarks - marks_scored) / stdMarks)) as w
from test_start_details, 
(
select avg(marks_scored) as avgMarks, std(marks_scored) as stdMarks
from test_start_details
) as T;


-- Calculate weighted Feature 1: Fraction of People who solved the given question correctly
create table WeightedFeature1 (question_id INT(11) PRIMARY KEY, feature1 FLOAT(7, 5));

insert into WeightedFeature1
select B.question_id, sum(w) / Total as feature1
from test_ques_ans_dtls B join 
	(
		select question_id, sum(w) as Total
        from test_ques_ans_dtls T1 join w_values T2 on (T1.test_id = T2.test_id)
        group by question_id
	) as T on(B.question_id = T.question_id) join
    w_values on (B.test_id = w_values.test_id)
where marks = 3
group by question_id
order by question_id;


-- Calculate Weighted Feature 2: Average Marks of People who did not attempt the question or solved it incorrectly
create table WeightedFeature2 (question_id INT(11) PRIMARY KEY, feature2 FLOAT(7, 5));

insert into WeightedFeature2
select question_id, sum(marks_scored * w) / sum(w) as feature2
from test_start_details A join test_ques_ans_dtls B on(A.id = B.test_id) join w_values C on(B.test_id = C.test_id)
where (marks = -1 or marks = 0)
group by question_id
order by question_id;


-- Calculate Weighted Features
create table WeightedFeatures (question_id INT(11) PRIMARY KEY, feature1 FLOAT(7, 5), feature2 FLOAT(7, 5));

insert into WeightedFeatures
select *
from WeightedFeature1 natural join WeightedFeature2
order by question_id;


-- Remove Redundant Tables
drop table w_values;
drop table WeightedFeature1;
drop table WeightedFeature2;


-- Now Export the data to CSV file
select *
from NewFeatures natural join (select id as question_id, difficulty_level from question_master) as T
into outfile '/tmp/weightedfeatures.csv'
fields terminated by ','
enclosed by ''
lines terminated by '\r\n';
