
select teamId, avg(marks_scored), std(marks_scored), count(*)
from teammemberdetail A join test_start_details B on(A.id = B.team_member_id)
group by teamId
order by teamId;


select teamId, avgMarks, (avgMarks - avgAMarks) / stdAMarks
from
(
	select teamId, avg(marks_scored) as avgMarks
	from teammemberdetail A join test_start_details B on(A.id = B.team_member_id)
	group by teamId
) as T1,
(
	select avg(avgMarks) as avgAMarks, std(avgMarks) as stdAMarks
	from
	(
		select teamId, avg(marks_scored) as avgMarks
		from teammemberdetail A join test_start_details B on(A.id = B.team_member_id)
		group by teamId
	) as T2
) as T3
order by teamId;


select question_id, avgMarks, (avgMarks - avgAMarks) / stdAMarks
from
(
	select question_id, avg(marks) as avgMarks
	from test_ques_ans_dtls
	group by question_id
) as T1,
(
	select avg(avgMarks) as avgAMarks, std(avgMarks) as stdAMarks
	from
	(
		select avg(marks) as avgMarks
		from test_ques_ans_dtls
		group by question_id
	) as T2
) as T3
order by question_id;


select teamId, E.category_name, sum(C.marks) / count(distinct B.team_member_id)
from teammemberdetail A join test_start_details B on(A.id = B.team_member_id) join test_ques_ans_dtls C on(B.id = C.test_id) join question_master D on(C.question_id = D.id) join question_category_master E on (D.category_id = E.id)
group by teamId, E.id
order by teamId, E.id;


select E.id, E.category_name, sum(C.marks) / count(distinct C.test_id)
from test_ques_ans_dtls C join question_master D on(C.question_id = D.id) join question_category_master E on (D.category_id = E.id)
group by E.id
order by E.id;


select A.branch, E.category_name, sum(C.marks) / count(distinct C.test_id)
from teammemberdetail A join test_start_details B on(A.id = B.team_member_id) join test_ques_ans_dtls C on(B.id = C.test_id) join question_master D on(C.question_id = D.id) join question_category_master E on (D.category_id = E.id)
group by A.branch, E.id
order by A.branch, E.id;



