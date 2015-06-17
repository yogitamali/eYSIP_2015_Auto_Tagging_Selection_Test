
% For plotting the distribution of Average marks

% Query used:
% select avg(marks_scored)
% from teammemberdetail A join test_start_details B on(A.id = B.team_member_id)
% group by teamId
% order by teamId;

% Result of Query was exported to AverageMarks.csv

close all;
clear;
clc;

% Read the data
fprintf("\n\nReading the data...\n");
X = csvread('AverageMarks.csv');
fprintf("Data Read.\n");

% Find the Average and Standard Deviation
fprintf("\n\nFinding Mean and Standard Deviation...\n");
avgMarks = mean(X);
stdDev = std(X);
fprintf("Average Marks per Team = %f\n", avgMarks);
fprintf("Standard Deviation = %f\n", stdDev);

% Find minimum and maximum
fprintf("\n\nFinding minimum and maximum marks...\n");
minMarks = min(X);
maxMarks = max(X);
fprintf("Minimum Marks = %f\n", minMarks);
fprintf("Maximum Marks = %f\n", maxMarks);

% Plot the data
fprintf("\n\nPlotting the data...\n");
hist(X, [minMarks:maxMarks]);
xlabel("Average Team Marks");
ylabel("Number of Teams");
title("Distribution of Average Team Marks");
fprintf("Done plotting.\n\n\n");
