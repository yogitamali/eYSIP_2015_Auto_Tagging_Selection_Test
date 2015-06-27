
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

% Perform mean normalization
fprintf("\n\nPerforming Mean Normalization...\n");
meanX = mean(X);	% Mean of all the features
stdX = std(X);	% Standard deviation of all the features
X = (X - meanX) ./ stdX;
X = X(:, [2, 7]);	% Uncomment this line to use selected features
fprintf("Mean Normalization Done.\n");

% Calculate the original Data Statistics
fprintf("\n\nCalculating Statistics of Original Data...\n");
fprintf("Statistics have been calculated after Mean Normalization.\n");
stats = statistics(X);

% Show Statistics for Feature 2
fprintf("\nFor Feature 2: Fraction of People who solved a Question\n");
fprintf("Minimum: %f\n", stats(1, 1));
fprintf("First Quartile: %f\n", stats(2, 1));
fprintf("Median: %f\n", stats(3, 1));
fprintf("Third Quartile: %f\n", stats(4, 1));
fprintf("Maximum: %f\n", stats(5, 1));
fprintf("Mean: %f\n", stats(6, 1));
fprintf("Standard Deviation: %f\n", stats(7, 1));

% Show Statistics for Feature 7
fprintf("\nFor Feature 7: Fraction of People int top 5 percentile who solved a Question\n");
fprintf("Minimum: %f\n", stats(1, 2));
fprintf("First Quartile: %f\n", stats(2, 2));
fprintf("Median: %f\n", stats(3, 2));
fprintf("Third Quartile: %f\n", stats(4, 2));
fprintf("Maximum: %f\n", stats(5, 2));
fprintf("Mean: %f\n", stats(6, 2));
fprintf("Standard Deviation: %f\n", stats(7, 2));

fprintf("Original Data Statistics Calculated.\n");


% Analyze Results of k-Means
fprintf("\n\nAnalyzing k-Means Result...\n");

% Load the Suggested Tags
fprintf("\nLoading k-Means Output...\n");
load('KMeansLabels');	% In variable kmeans_labels
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
fprintf("\nStatistics displayed in format:\nstatistis\tFeature 2\tFeature7\n");
fprintf("\nCalculating Statistics for Easy Questions...\n");
stats = statistics(easy);
fprintf("Min:\t%f\t%f\n", stats(1, 1), stats(1, 2));
fprintf("Q1:\t%f\t%f\n", stats(2, 1), stats(2, 2));
fprintf("Median:\t%f\t%f\n", stats(3, 1), stats(3, 2));
fprintf("Q3:\t%f\t%f\n", stats(4, 1), stats(4, 2));
fprintf("Max:\t%f\t%f\n", stats(5, 1), stats(5, 2));
fprintf("Mean:\t%f\t%f\n", stats(6, 1), stats(6, 2));
fprintf("SD:\t%f\t%f\n", stats(7, 1), stats(7, 2));

fprintf("\nCalculating Statistics for Medium Questions...\n");
stats = statistics(medium);
fprintf("Min:\t%f\t%f\n", stats(1, 1), stats(1, 2));
fprintf("Q1:\t%f\t%f\n", stats(2, 1), stats(2, 2));
fprintf("Median:\t%f\t%f\n", stats(3, 1), stats(3, 2));
fprintf("Q3:\t%f\t%f\n", stats(4, 1), stats(4, 2));
fprintf("Max:\t%f\t%f\n", stats(5, 1), stats(5, 2));
fprintf("Mean:\t%f\t%f\n", stats(6, 1), stats(6, 2));
fprintf("SD:\t%f\t%f\n", stats(7, 1), stats(7, 2));

fprintf("\nCalculating Statistics for Hard Questions...\n");
stats = statistics(hard);
fprintf("Min:\t%f\t%f\n", stats(1, 1), stats(1, 2));
fprintf("Q1:\t%f\t%f\n", stats(2, 1), stats(2, 2));
fprintf("Median:\t%f\t%f\n", stats(3, 1), stats(3, 2));
fprintf("Q3:\t%f\t%f\n", stats(4, 1), stats(4, 2));
fprintf("Max:\t%f\t%f\n", stats(5, 1), stats(5, 2));
fprintf("Mean:\t%f\t%f\n", stats(6, 1), stats(6, 2));
fprintf("SD:\t%f\t%f\n", stats(7, 1), stats(7, 2));


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
fprintf("\nQ_Id\tFeature 2\tFeature 7\n");
for i = [1:3],
	fprintf("%d\t%f\t%f\n", question_id(examples(idx(i))), X(examples(idx(i)), 1), X(examples(idx(i)), 2));
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
fprintf("\nQ_Id\tFeature 2\tFeature 7\n");
for i = [1:3],
	fprintf("%d\t%f\t%f\n", question_id(examples(idx(i))), X(examples(idx(i)), 1), X(examples(idx(i)), 2));
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
fprintf("\nQ_Id\tFeature 2\tFeature 7\n");
for i = [1:3],
	fprintf("%d\t%f\t%f\n", question_id(examples(idx(i))), X(examples(idx(i)), 1), X(examples(idx(i)), 2));
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
fprintf("\nQ_Id\tFeature 2\tFeature 7\n");
for i = [1:3],
	fprintf("%d\t%f\t%f\n", question_id(examples(idx(i))), X(examples(idx(i)), 1), X(examples(idx(i)), 2));
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
fprintf("\nQ_Id\tFeature 2\tFeature 7\n");
for i = [1:3],
	fprintf("%d\t%f\t%f\n", question_id(examples(idx(i))), X(examples(idx(i)), 1), X(examples(idx(i)), 2));
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
fprintf("\nQ_Id\tFeature 2\tFeature 7\n");
for i = [1:3],
	fprintf("%d\t%f\t%f\n", question_id(examples(idx(i))), X(examples(idx(i)), 1), X(examples(idx(i)), 2));
end;


