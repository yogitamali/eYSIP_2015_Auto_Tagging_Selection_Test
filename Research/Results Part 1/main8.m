
% Usage:
% 1. Save the labels obtained from running the three algorithms in separate files
% 2. Place Features.csv in the same folder.

% Works in accordance with information present in Other Information.txt

% Implementation of Final Result Calculation

close all;
clear;
clc;

% Read features.csv
fprintf("\n\nReading data...\n");
inputData = csvread('features.csv');
fprintf("Data Read.\n");

% Segregate the data
question_id = inputData(:, 1);	% First column is question id
X = inputData(:, 2:8);	% Next 7 columns contain features
y = inputData(:, 9);	% Last column contains current question tag

% Some useful variables
m = size(X, 1);	% Number of training examples
n = size(X, 2);	% Number of Features

% Perform mean normalization
fprintf("\n\nPerforming Mean Normalization...\n");
meanX = mean(X);	% Mean of all the features
stdX = std(X);	% Standard deviation of all the features
X = (X - meanX) ./ stdX;
% X = X(:, [2, 7]);	% Uncomment this line to use selected features
fprintf("Mean Normalization Done.\n");

% Calculate the original Data Statistics
fprintf("\n\nCalculating Statistics of Original Data...\n");
fprintf("Statistics have been calculated after Mean Normalization.\n");
stats = statistics(X);

for i = [1:n],
	fprintf("\nFor Feature %d:\n", i);
	fprintf("Minimum: %f\n", stats(1, i));
	fprintf("First Quartile: %f\n", stats(2, i));
	fprintf("Median: %f\n", stats(3, i));
	fprintf("Third Quartile: %f\n", stats(4, i));
	fprintf("Maximum: %f\n", stats(5, i));
	fprintf("Mean: %f\n", stats(6, i));
	fprintf("Standard Deviation: %f\n", stats(7, i));
end;

fprintf("Original Data Statistics Calculated.\n");


% Analyze Results of k-Means
fprintf("\n\nAnalyzing k-Means Result...\n");

% Load the Suggested Tags
fprintf("\nLoading k-Means Output...\n");
load('KMeansLabels8');	% In variable kmeans_labels
fprintf("k-Means Output Loaded.\n");

% Calculate Disagreements with Orignal Tags
fprintf("\nCalculating Disagreement with Original Tags...\n");
disagreements = (kmeans_labels != y);
fprintf("Disagreements: %f percent\n", (sum(disagreements(:)) * 100) / m);

% Segregate the Data
fprintf("\nSegregating data based on labels...\n");
categories = {};
for i = [1:3],
	categories{i} = [];
end;
for i = [1:m],
	categories{kmeans_labels(i) + 1} = [categories{kmeans_labels(i) + 1}; X(i, :)];
end;
easy = categories{1};
medium = categories{2};
hard = categories{3};
fprintf("Data Segragated.\n");

% Calculate Tag Specific Statistics
fprintf("\nStatistics displayed in format:\nstatistis");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;

fprintf("\n\nCalculating Statistics for Easy Questions...\n");
stats = statistics(easy);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_easy = stats(6, :);	% Will be used later


fprintf("\n\nCalculating Statistics for Medium Questions...\n");
stats = statistics(medium);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_medium = stats(6, :);	% Will be used later

fprintf("\n\nCalculating Statistics for Hard Questions...\n");
stats = statistics(hard);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_hard = stats(6, :);	% Will be used later

% Examples: Manual - 0 and Suggested 1
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Easy\n");
fprintf("\tSuggested Tag: Medium\n");
examples = [];
for i = [1:m],
	if (y(i) == 0 && kmeans_labels(i) == 1)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(medium)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_medium);
end;

% Examples: Manual - 0 and Suggested 2
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Easy\n");
fprintf("\tSuggested Tag: Hard\n");
examples = [];
for i = [1:m],
	if (y(i) == 0 && kmeans_labels(i) == 2)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_hard);
end;

% Examples: Manual - 1 and Suggested 0
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Medium\n");
fprintf("\tSuggested Tag: Easy\n");
examples = [];
for i = [1:m],
	if (y(i) == 1 && kmeans_labels(i) == 0)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(medium)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_medium);
end;

% Examples: Manual - 1 and Suggested 2
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Medium\n");
fprintf("\tSuggested Tag: Hard\n");
examples = [];
for i = [1:m],
	if (y(i) == 1 && kmeans_labels(i) == 2)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(medium)\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_hard = sum((f - mean_hard).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_medium, d_hard);
end;

% Examples: Manual - 2 and Suggested 0
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Hard\n");
fprintf("\tSuggested Tag: Easy\n");
examples = [];
for i = [1:m],
	if (y(i) == 2 && kmeans_labels(i) == 0)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_hard);
end;

% Examples: Manual - 2 and Suggested 1
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Hard\n");
fprintf("\tSuggested Tag: Medium\n");
examples = [];
for i = [1:m],
	if (y(i) == 2 && kmeans_labels(i) == 1)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(medium)\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_medium = sum((f - mean_medium).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_medium, d_hard);
end;


fprintf("\nk-Means Result Analysis Done.\n");



% Analyze the Result of Competitive Learning
fprintf("\n\nAnalyzing Competitive Learning Result...\n");

% Load the Suggested Tags
fprintf("\nLoading Competitive Learning Output...\n");
load('CompetitiveLabels8');	% In variable kmeans_labels
fprintf("Competitive Learning Output Loaded.\n");

% Calculate Disagreements with Orignal Tags
fprintf("\nCalculating Disagreement with Original Tags...\n");
disagreements = (competitive_labels != y);
fprintf("Disagreements: %f percent\n", (sum(disagreements(:)) * 100) / m);

% Segregate the Data
fprintf("\nSegregating data based on labels...\n");
categories = {};
for i = [1:3],
	categories{i} = [];
end;
for i = [1:m],
	categories{competitive_labels(i) + 1} = [categories{competitive_labels(i) + 1}; X(i, :)];
end;
easy = categories{1};
medium = categories{2};
hard = categories{3};
fprintf("Data Segragated.\n");

% Calculate Tag Specific Statistics
fprintf("\nStatistics displayed in format:\nstatistis");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;

fprintf("\n\nCalculating Statistics for Easy Questions...\n");
stats = statistics(easy);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_easy = stats(6, :);	% Will be used later


fprintf("\n\nCalculating Statistics for Medium Questions...\n");
stats = statistics(medium);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_medium = stats(6, :);	% Will be used later

fprintf("\n\nCalculating Statistics for Hard Questions...\n");
stats = statistics(hard);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_hard = stats(6, :);	% Will be used later

% Examples: Manual - 0 and Suggested 1
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Easy\n");
fprintf("\tSuggested Tag: Medium\n");
examples = [];
for i = [1:m],
	if (y(i) == 0 && competitive_labels(i) == 1)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(medium)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_medium);
end;

% Examples: Manual - 0 and Suggested 2
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Easy\n");
fprintf("\tSuggested Tag: Hard\n");
examples = [];
for i = [1:m],
	if (y(i) == 0 && competitive_labels(i) == 2)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_hard);
end;

% Examples: Manual - 1 and Suggested 0
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Medium\n");
fprintf("\tSuggested Tag: Easy\n");
examples = [];
for i = [1:m],
	if (y(i) == 1 && competitive_labels(i) == 0)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(medium)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_medium);
end;

% Examples: Manual - 1 and Suggested 2
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Medium\n");
fprintf("\tSuggested Tag: Hard\n");
examples = [];
for i = [1:m],
	if (y(i) == 1 && competitive_labels(i) == 2)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(medium)\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_hard = sum((f - mean_hard).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_medium, d_hard);
end;

% Examples: Manual - 2 and Suggested 0
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Hard\n");
fprintf("\tSuggested Tag: Easy\n");
examples = [];
for i = [1:m],
	if (y(i) == 2 && competitive_labels(i) == 0)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_hard);
end;

% Examples: Manual - 2 and Suggested 1
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Hard\n");
fprintf("\tSuggested Tag: Medium\n");
examples = [];
for i = [1:m],
	if (y(i) == 2 && competitive_labels(i) == 1)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(medium)\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_medium = sum((f - mean_medium).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_medium, d_hard);
end;

fprintf("\nCompetitive Learning Result Analysis Done.\n");



% Analyze the Result of EM
fprintf("\n\nAnalyzing EM Result...\n");

% Load the Suggested Tags
fprintf("\nLoading EM Output...\n");
load('EMLabels8');	% In variable kmeans_labels
fprintf("EM Output Loaded.\n");

% Calculate Disagreements with Orignal Tags
fprintf("\nCalculating Disagreement with Original Tags...\n");
disagreements = (em_labels != y);
fprintf("Disagreements: %f percent\n", (sum(disagreements(:)) * 100) / m);

% Segregate the Data
fprintf("\nSegregating data based on labels...\n");
categories = {};
for i = [1:3],
	categories{i} = [];
end;
for i = [1:m],
	categories{em_labels(i) + 1} = [categories{em_labels(i) + 1}; X(i, :)];
end;
easy = categories{1};
medium = categories{2};
hard = categories{3};
fprintf("Data Segragated.\n");

% Calculate Tag Specific Statistics
fprintf("\nStatistics displayed in format:\nstatistis");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;

fprintf("\n\nCalculating Statistics for Easy Questions...\n");
stats = statistics(easy);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_easy = stats(6, :);	% Will be used later


fprintf("\n\nCalculating Statistics for Medium Questions...\n");
stats = statistics(medium);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_medium = stats(6, :);	% Will be used later

fprintf("\n\nCalculating Statistics for Hard Questions...\n");
stats = statistics(hard);
fprintf("Min:");
for i = [1:n],
	fprintf("\t%f", stats(1, i));
end;
fprintf("\nQ1:");
for i = [1:n],
	fprintf("\t%f", stats(2, i));
end;
fprintf("\nMedian:");
for i = [1:n],
	fprintf("\t%f", stats(3, i));
end;
fprintf("\nQ3:");
for i = [1:n],
	fprintf("\t%f", stats(4, i));
end;
fprintf("\nMax:");
for i = [1:n],
	fprintf("\t%f", stats(5, i));
end;
fprintf("\nMean:");
for i = [1:n],
	fprintf("\t%f", stats(6, i));
end;
fprintf("\nSD:");
for i = [1:n],
	fprintf("\t%f", stats(7, i));
end;
mean_hard = stats(6, :);	% Will be used later

% Examples: Manual - 0 and Suggested 1
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Easy\n");
fprintf("\tSuggested Tag: Medium\n");
examples = [];
for i = [1:m],
	if (y(i) == 0 && em_labels(i) == 1)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(medium)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_medium);
end;

% Examples: Manual - 0 and Suggested 2
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Easy\n");
fprintf("\tSuggested Tag: Hard\n");
examples = [];
for i = [1:m],
	if (y(i) == 0 && em_labels(i) == 2)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_hard);
end;

% Examples: Manual - 1 and Suggested 0
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Medium\n");
fprintf("\tSuggested Tag: Easy\n");
examples = [];
for i = [1:m],
	if (y(i) == 1 && em_labels(i) == 0)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(medium)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_medium);
end;

% Examples: Manual - 1 and Suggested 2
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Medium\n");
fprintf("\tSuggested Tag: Hard\n");
examples = [];
for i = [1:m],
	if (y(i) == 1 && em_labels(i) == 2)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(medium)\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_hard = sum((f - mean_hard).^2(:));
	d_medium = sum((f - mean_medium).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_medium, d_hard);
end;

% Examples: Manual - 2 and Suggested 0
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Hard\n");
fprintf("\tSuggested Tag: Easy\n");
examples = [];
for i = [1:m],
	if (y(i) == 2 && em_labels(i) == 0)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(easy)\t\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_easy = sum((f - mean_easy).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_easy, d_hard);
end;

% Examples: Manual - 2 and Suggested 1
fprintf("\n\nShowing Examples where:\n");
fprintf("\tManual Tag: Hard\n");
fprintf("\tSuggested Tag: Medium\n");
examples = [];
for i = [1:m],
	if (y(i) == 2 && em_labels(i) == 1)
		examples = [examples; i];
	end;
end;
idx = randperm(size(examples, 1))(1:3);	% Randomly select 3 examples
fprintf("\nQ_Id");
for i = [1:n],
	fprintf("\tFeature %d", i);
end;
fprintf("\td(medium)\td(hard)\n");
for i = [1:3],
	q_id = question_id(examples(idx(i)));
	f = X(examples(idx(i)), :);
	d_medium = sum((f - mean_medium).^2(:));
	d_hard = sum((f - mean_hard).^2(:));
	fprintf("%d", q_id);
	for j = [1:n],
		fprintf("\t%f", f(1, j));
	end;
	fprintf("\t%f\t%f\n", d_medium, d_hard);
end;


fprintf("\nEM Result Analysis Done.\n");
