/*
	SQL Queries for Extraction of Features.
	
	1. Extract Features as mentioned in ReadMe.txt for Part 2
	2. All the Intermediate Feature Tables are removed in the end except those that can be used to assign ids to new examples.
	3. Only 1 table called Part2Features is preserved which summarizes all the features 
	4. Part2Features table is finally dumped to /tmp/features.csv along with student score information
	5. features.csv can be copied to workspace and it can be directly read into octave
*/

/*
	!!!
	
	Warning: Executing this file results in deletion of any previously found features.
	
	!!!
*/

use eyrc14_auto_data_analysis;

-- Drop original Feature tables
drop table if exists Part2Feature1;
drop table if exists Part2Feature2;
drop table if exists Part2Feature3;
drop table if exists Part2Feature4;
drop table if exists Part2Feature5;
drop table if exists Part2Feature6;
drop table if exists Part2Feature7;
drop table if exists Part2Features;

-- Drop support tables
-- These intermediate tables are used to assign ids to branch, year etc.
-- Even if original data changes, due to these tables the mapping can be accomodated
-- without changing any queries.
drop table if exists Branch;
drop table if exists Year;
drop table if exists Gender;
drop table if exists College;
drop table if exists Region;
drop table if exists Role;
drop table if exists State;


-- Set up intermediate tables

-- Threshold to separate 'other' from actual feature. Eg. If number of 
-- students from branch X is less than this threshold than this branch X
-- should be included in other field and hence should not be part of these
-- intermediate tables.
-- Experiment with different values of this parameter.
set @threshold = 0;


-- Create Year table
create table Year
(
	year_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	year INT(3)
);
-- Populate Year table
insert into Year
select NULL, year
from
(
	select distinct year, count(*) as c
	from teammemberdetail
	where not (year = '')
	group by year
	having c >= @threshold
	order by year
) as T;


-- Create Branch table
create table Branch
(
	branch_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	branch VARCHAR(50)
);
-- Populate Branch table
insert into Branch
select NULL, branch
from
(
	select distinct branch, count(*) as c
	from teammemberdetail
	where not (branch = '')
	group by branch
	having c >= @threshold
	order by branch
) as T;


-- Create Gender table
create table Gender
(
	gender_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	gender VARCHAR(50)
);
-- Populate Gender table
insert into Gender
select NULL, gender
from
(
	select distinct gender, count(*) as c
	from teammemberdetail
	where not (gender = '')
	group by gender
	having c >= @threshold
	order by gender
) as T;


-- Create State table
create table State
(
	state_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	state VARCHAR(50)
);
-- Populate State table
insert into State
select NULL, state
from
(
	select distinct state, count(*) as c
	from teamcollege
	where not (state = '')
	group by state
	having c >= @threshold
	order by state
) as T;


-- Create Region table
create table Region
(
	region_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	pincode INT(6)
);
-- Populate Region table
insert into Region
select NULL, pincode
from
(
	select distinct pincode, count(*) as c
	from teamcollege
	where not (pincode = '')
	group by pincode
	having c >= @threshold
	order by pincode
) as T;


-- Create College table
create table College
(
	college_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	collegeName VARCHAR(1000)
);
-- Populate College table
insert into College
select NULL, collegeName
from
(
	select distinct collegeName, count(*) as c
	from teamcollege
	where not (collegeName = '')
	group by collegeName
	having c >= @threshold
	order by collegeName
) as T;


-- Create Role table
create table Role
(
	role_id	INT(10) PRIMARY KEY AUTO_INCREMENT,
	role VARCHAR(50)
);
-- Populate Role table
insert into Role
select NULL, role
from
(
	select distinct role, count(*) as c
	from teammemberdetail
	where not (role = '')
	group by role
	having c >= @threshold
	order by role
) as T;


-- Intermediate tables successfully created and populated




-- Calculate various Features

-- Feature 1: Year in college (team_member_id	year_id)
-- Insert -1 in year_id if corresponding year is not present in the
-- year table. This will correspond to the 'other' option
create table Part2Feature1
(
	team_member_id INT(11) PRIMARY KEY,
	year_id INT(11)
);

-- Insert data about year
insert into Part2Feature1
select distinct id, year_id
from teammemberdetail A join Year B on (A.year = B.year);

-- Insert data about 'other'
insert into Part2Feature1
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature1);


-- Feature 2: Major of Student (team_member_id	branch_id)
-- Insert -1 in branch_id if corresponding branch is not present in the
-- Branch table. This will correspond to the 'other' option
create table Part2Feature2
(
	team_member_id INT(11) PRIMARY KEY,
	branch_id INT(11)
);

-- Insert data about Branch
insert into Part2Feature2
select distinct id, branch_id
from teammemberdetail A join Branch B on (A.branch = B.branch);

-- Insert data about 'other'
insert into Part2Feature2
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature2);


-- Feature 3: Gender of Student (team_member_id	gender_id)
-- Insert -1 in gender_id if corresponding gender is not present in the
-- Gender table. This will correspond to the 'other' option
create table Part2Feature3
(
	team_member_id INT(11) PRIMARY KEY,
	gender_id INT(11)
);

-- Insert data about Gender
insert into Part2Feature3
select distinct id, gender_id
from teammemberdetail A join Gender B on (A.gender = B.gender);

-- Insert data about 'other'
insert into Part2Feature3
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature3);


-- Feature 4: State to which Student belongs (team_member_id	state_id)
-- Insert -1 in state_id if corresponding state is not present in the
-- State table. This will correspond to the 'other' option
create table Part2Feature4
(
	team_member_id INT(11) PRIMARY KEY,
	state_id INT(11)
);

-- Insert data about State
insert into Part2Feature4
select distinct A.id, state_id
from teammemberdetail A join teamcollege B on(A.teamId = B.id) join State C on (B.state = C.state);

-- Insert data about 'other'
insert into Part2Feature4
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature4);


-- Feature 5: Region to which Student belongs (team_member_id	region_id)
-- Insert -1 in region_id if corresponding region is not present in the
-- Region table. This will correspond to the 'other' option
create table Part2Feature5
(
	team_member_id INT(11) PRIMARY KEY,
	region_id INT(11)
);

-- Insert data about Region
insert into Part2Feature5
select distinct A.id, region_id
from teammemberdetail A join teamcollege B on(A.teamId = B.id) join Region C on (B.pincode = C.pincode);

-- Insert data about 'other'
insert into Part2Feature5
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature5);


-- Feature 6: College to which Student belongs (team_member_id	college_id)
-- Insert -1 in college_id if corresponding college is not present in the
-- College table. This will correspond to the 'other' option
create table Part2Feature6
(
	team_member_id INT(11) PRIMARY KEY,
	college_id INT(11)
);

-- Insert data about College
insert into Part2Feature6
select distinct A.id, college_id
from teammemberdetail A join teamcollege B on(A.teamId = B.id) join College C on (B.collegeName = C.collegeName);

-- Insert data about 'other'
insert into Part2Feature6
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature6);


-- Feature 7: Role of Student (team_member_id	role_id)
-- Insert -1 in role_id if corresponding role is not present in the
-- Role table. This will correspond to the 'other' option
create table Part2Feature7
(
	team_member_id INT(11) PRIMARY KEY,
	role_id INT(11)
);

-- Insert data about Region
insert into Part2Feature7
select distinct A.id, role_id
from teammemberdetail A join Role B on(A.role = B.role);

-- Insert data about 'other'
insert into Part2Feature7
select distinct id, -1
from teammemberdetail
where id not in (select team_member_id from Part2Feature7);


-- Done Evaluation all the Features, Combine them in one big table

create table Part2Features
(
	team_member_id INT(11) PRIMARY KEY,
	year_id INT(11),
	branch_id INT(11),
	gender_id INT(11),
	state_id INT(11),
	college_id INT(11),
	region_id INT(11),
	role_id INT(11)
);

insert into Part2Features
select * 
from Part2Feature1 natural join Part2Feature2
	natural join Part2Feature3
	natural join Part2Feature4
	natural join Part2Feature5
	natural join Part2Feature6
	natural join Part2Feature7;


-- Remove all the extra tables created in the process
-- Intermediate tables like Year, Branch etc should not be dropped
-- since they will help in providing ids for new examples
drop table Part2Feature1;
drop table Part2Feature2;
drop table Part2Feature3;
drop table Part2Feature4;
drop table Part2Feature5;
drop table Part2Feature6;
drop table Part2Feature7;



-- Now Export the data to CSV file

select *
from Part2Features natural join (select distinct A.id as team_member_id, marks_scored from teammemberdetail A join test_start_details B on (A.id = B.team_member_id)) as T
into outfile '/tmp/features.csv'
fields terminated by ','
enclosed by ''
lines terminated by '\r\n';

