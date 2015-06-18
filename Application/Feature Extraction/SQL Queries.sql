
/*
	SQL Queries for Extraction of Features.
	
	1. Extract 7 Features as mentioned in ReadMe.txt
	2. All the Intermediate Feature Tables are removed in the end
	3. Only 1 table called NewFeatures is preserved which summarizes all the 5 features 
	4. NewFeatures table is finally dumped to /tmp/features.csv along with current question label information
	5. features.csv can be copied to workspace and it can be directly read into octave
*/

/*
	!!!
	
	Warning: Executing this file results in deletion of any previously found features.
	
	!!!
*/

use eyrc14_auto_data_analysis;

-- Drop original Feature tables
drop table if exists NewFeature1;
drop table if exists NewFeature2;
drop table if exists NewFeature3;
drop table if exists NewFeature4;
drop table if exists NewFeature5;
drop table if exists NewFeature6;
drop table if exists NewFeature7;
drop table if exists NewFeatures;


-- Feature 1 -> Fraction of people who did not attempt the given question

create table NewFeature1 (question_id INT(11) PRIMARY KEY, feature1 FLOAT(7, 5));

insert into NewFeature1
select B.question_id, count(*) / Total as fractionNotAttempted
from test_ques_ans_dtls B join (select question_id, count(*) as Total from test_ques_ans_dtls group by question_id) as T on(B.question_id = T.question_id)
where marks = 0
group by question_id
order by question_id;


-- Feature 2 -> Fraction of people who solved the given question correctly

create table NewFeature2 (question_id INT(11) PRIMARY KEY, feature2 FLOAT(7, 5));

insert into NewFeature2
select B.question_id, count(*) / Total as fractionCorrect
from test_ques_ans_dtls B join (select question_id, count(*) as Total from test_ques_ans_dtls group by question_id) as T on(B.question_id = T.question_id)
where marks = 3
group by question_id
order by question_id;


-- Feature 3 -> Fraction of people who solved the given question incorrectly

create table NewFeature3 (question_id INT(11) PRIMARY KEY, feature3 FLOAT(7, 5));

insert into NewFeature3
select B.question_id, count(*) / Total as fractionIncorrect
from test_ques_ans_dtls B join (select question_id, count(*) as Total from test_ques_ans_dtls group by question_id) as T on(B.question_id = T.question_id)
where marks = -1
group by question_id
order by question_id;



-- Feature 4 -> Average Marks of people who solved the given question correctly

create table NewFeature4 (question_id INT(11) PRIMARY KEY, feature4 FLOAT(7, 5));

insert into NewFeature4
select question_id, avg(marks_scored)
from test_start_details A join test_ques_ans_dtls B on(A.id = B.test_id)
where marks = 3
group by question_id
order by question_id;



-- Feature 5 -> Average Marks of people who solved the given question incorrectly

create table NewFeature5 (question_id INT(11) PRIMARY KEY, feature5 FLOAT(7, 5));

insert into NewFeature5
select question_id, avg(marks_scored)
from test_start_details A join test_ques_ans_dtls B on(A.id = B.test_id)
where marks = -1
group by question_id
order by question_id;



-- Feature 6 -> Average Marks of people who did not attempt the given question

create table NewFeature6 (question_id INT(11) PRIMARY KEY, feature6 FLOAT(7, 5));

insert into NewFeature6
select question_id, avg(marks_scored)
from test_start_details A join test_ques_ans_dtls B on(A.id = B.test_id)
where marks = 0
group by question_id
order by question_id;


-- Feature 7 -> Fraction of Students in top 5 percentile who solved the given question correctly

select FLOOR(0.05 * count(*)) into @rn from test_start_details;

create table TopPerformers (id INT(11) PRIMARY KEY);

-- Find test_id of top performers
PREPARE STMT FROM 'insert into TopPerformers (select id
from test_start_details
order by marks_scored desc
limit ?)';

EXECUTE STMT USING @rn;

create table T1 (question_id INT(11) PRIMARY KEY, numServed INT(11));

-- Find number of times a question was served to top performers
insert into T1 (select question_id, count(*) as numServed from test_ques_ans_dtls where test_id in (select * from TopPerformers) group by question_id); 

create table NewFeature7 (question_id INT(11) PRIMARY KEY, feature7 FLOAT(7, 5));

-- Evaluate Feature 7
insert into NewFeature7
select *
from
(
	select A.question_id, (count(*) / numServed) as fractionCorrect
	from test_ques_ans_dtls A join T1 B on(A.question_id = B.question_id)
	where test_id in (select * from TopPerformers) and marks = 3
	group by A.question_id

	union

	select question_id, 0
	from test_ques_ans_dtls
	where question_id not in
	(
		select distinct A.question_id
		from test_ques_ans_dtls A join T1 B on(A.question_id = B.question_id)
		where test_id in (select * from TopPerformers) and marks = 3
	) and test_id in (select * from TopPerformers)
) as T
order by question_id;

-- Drop Extra Tables
drop table T1;
drop table TopPerformers;




-- Done Evaluation all the Features, Combine them in one big table

create table NewFeatures
(
	question_id INT(11) PRIMARY KEY,
	feature1 FLOAT(7, 5),
	feature2 FLOAT(7, 5),
	feature3 FLOAT(7, 5),
	feature4 FLOAT(7, 5),
	feature5 FLOAT(7, 5),
	feature6 FLOAT(7, 5),
	feature7 FLOAT(7, 5)
);

insert into NewFeatures
select * 
from NewFeature1 natural join NewFeature2
	natural join NewFeature3
	natural join NewFeature4
	natural join NewFeature5
	natural join NewFeature6
	natural join NewFeature7;


-- Remove all the extra tables created in the process

drop table NewFeature1;
drop table NewFeature2;
drop table NewFeature3;
drop table NewFeature4;
drop table NewFeature5;
drop table NewFeature6;
drop table NewFeature7;



-- Now Export the data to CSV file

select *
from NewFeatures natural join (select id as question_id, difficulty_level from question_master) as T
into outfile '/tmp/features.csv'
fields terminated by ','
enclosed by ''
lines terminated by '\r\n';
