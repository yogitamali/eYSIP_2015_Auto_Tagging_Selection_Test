






-- Feature 6 -> Fraction of Students in top 5 percentile who solved the given question correctly

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

create table NewFeature6 (question_id INT(11) PRIMARY KEY, feature6 FLOAT(7, 5));

-- Evaluate Feature 6
insert into NewFeature6
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
