
% File implementing the comparison of the following learning algorithms
% that were implemented for part 1:
% 1. k-Means Clustering
% 2. Competitive Learning Algorithm
% 3. EM Algorithm

% Usage:
% 1. Save the labels obtained from running the three algorithms in separate files
% 2. Place Features.csv in the same folder.

% Works in accordance with information present in Other Information.txt


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

% Visualize the initial data
fprintf("\n\nVisualizing initial data...\n");
plotData(X, y .+ 1, m);
title("Original Question Tags");
fprintf("Visualization done. Press any key to continue.\n");
pause;


% Study the Result of K-Means Algorithm
% Load K-Means Data
fprintf("\n\nLoading K-Means Clustering Labels...\n");
load('KMeansLabels');
fprintf("K-Means Labels Loaded.\n");

% Visualize K-Means Data
fprintf("\n\nVisualizing K-Means Labels...\n");
plotData(X, kmeans_labels .+ 1, m); 
title("K-Means Suggested Question Tags");
fprintf("Visualization done.\n");

% Estimate the Accuracy of K-Means
fprintf("\n\nCalculating Agreement of K-Means Labels with Original Labels...\n");
accuracy = (sum((y == kmeans_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for K-Means...\n");
easy = (sum((kmeans_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((kmeans_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((kmeans_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nK-Means Analyzed. Press any key to continue.\n");
pause;


% Study the Result of Competitive Learning Algorithm
% Load Competitive Learning Data
fprintf("\n\nLoading Competitive Learning Labels...\n");
load('CompetitiveLabels');
fprintf("Competitive Learning Labels Loaded.\n");

% Visualize K-Means Data
fprintf("\n\nVisualizing Competitive Learning Labels...\n");
plotData(X, competitive_labels .+ 1, m); 
title("Competitive Learning Suggested Question Tags");
fprintf("Visualization done.\n");

% Estimate the Accuracy of Competitive Learning
fprintf("\n\nCalculating Agreement of Comeptitive Learning Labels with Original Labels...\n");
accuracy = (sum((y == competitive_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for Competitive Learning...\n");
easy = (sum((competitive_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((competitive_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((competitive_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nCompetitive Learning Analyzed. Press any key to continue.\n");
pause;



% Study the Result of EM Algorithm
% Load EM Data
fprintf("\n\nLoading EM Labels...\n");
load('EMLabels');
fprintf("EM Labels Loaded.\n");

% Visualize EM Data
fprintf("\n\nVisualizing EM Labels...\n");
plotData(X, em_labels .+ 1, m); 
title("EM Suggested Question Tags");
fprintf("Visualization done.\n");

% Estimate the Accuracy of EM
fprintf("\n\nCalculating Agreement of EM Labels with Original Labels...\n");
accuracy = (sum((y == em_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for EM...\n");
easy = (sum((em_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((em_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((em_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nEM Analyzed. Press any key to continue.\n");
pause;



% Compare K-Means with Competitive Learning
fprintf("\n\nComparing K-Means with Competitive Learning.\n");
% Calculating agreement between the two algorithms
fprintf("\n\nCalculating Agreement between Output of both Algorithms...\n");
agreement = (kmeans_labels == competitive_labels);
fprintf("Agreement: %f percent\n", (sum(agreement(:)) * 100) / m);

% Visualize the Labels that were given same labels
fprintf("\n\nVisualizing Labels that were given Same Labels...\n");
plot_data = [];
plot_labels = [];
labels = [];
count = 0;
for i = [1:m],
	if (agreement(i) == 1)
		plot_data = [plot_data; X(i, :)];
		plot_labels = [plot_labels; kmeans_labels(i, :)];
		labels = [labels; y(i, :)];
		count += 1;
	end;
end;
plotData(plot_data, plot_labels .+ 1, count); 
title("K-Means and Competitive Learning Agreement");
fprintf("Visualization done.\n");

% Estimate the Accuracy of EM
fprintf("\n\nCalculating Agreement of both Algorithms with Original Labels...\n");
accuracy = (sum((labels == plot_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for Both Algorithms...\n");
easy = (sum((plot_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((plot_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((plot_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nComparison Done. Press any key to continue.\n");
pause;



% Compare K-Means with EM
fprintf("\n\nComparing K-Means with EM.\n");
% Calculating agreement between the two algorithms
fprintf("\n\nCalculating Agreement between Output of both Algorithms...\n");
agreement = (kmeans_labels == em_labels);
fprintf("Agreement: %f percent\n", (sum(agreement(:)) * 100) / m);

% Visualize the Labels that were given same labels
fprintf("\n\nVisualizing Labels that were given Same Labels...\n");
plot_data = [];
plot_labels = [];
labels = [];
count = 0;
for i = [1:m],
	if (agreement(i) == 1)
		plot_data = [plot_data; X(i, :)];
		plot_labels = [plot_labels; kmeans_labels(i, :)];
		labels = [labels; y(i, :)];
		count += 1;
	end;
end;
plotData(plot_data, plot_labels .+ 1, count); 
title("K-Means and EM Agreement");
fprintf("Visualization done.\n");

% Estimate the Accuracy of EM
fprintf("\n\nCalculating Agreement of both Algorithms with Original Labels...\n");
accuracy = (sum((labels == plot_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for Both Algorithms...\n");
easy = (sum((plot_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((plot_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((plot_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nComparison Done. Press any key to continue.\n");
pause;



% Compare EM with Competitive Learning
fprintf("\n\nComparing EM with Competitive Learning.\n");
% Calculating agreement between the two algorithms
fprintf("\n\nCalculating Agreement between Output of both Algorithms...\n");
agreement = (em_labels == competitive_labels);
fprintf("Agreement: %f percent\n", (sum(agreement(:)) * 100) / m);

% Visualize the Labels that were given same labels
fprintf("\n\nVisualizing Labels that were given Same Labels...\n");
plot_data = [];
plot_labels = [];
labels = [];
count = 0;
for i = [1:m],
	if (agreement(i) == 1)
		plot_data = [plot_data; X(i, :)];
		plot_labels = [plot_labels; em_labels(i, :)];
		labels = [labels; y(i, :)];
		count += 1;
	end;
end;
plotData(plot_data, plot_labels .+ 1, count); 
title("EM and Competitive Learning Agreement");
fprintf("Visualization done.\n");

% Estimate the Accuracy of EM
fprintf("\n\nCalculating Agreement of both Algorithms with Original Labels...\n");
accuracy = (sum((labels == plot_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for Both Algorithms...\n");
easy = (sum((plot_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((plot_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((plot_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nComparison Done. Press any key to continue.\n");
pause;



% Compare All Three Algorithms
fprintf("\n\nComparing All Three Algorithms.\n");
% Calculating agreement between all algorithms
fprintf("\n\nCalculating Agreement between Output of all Algorithms...\n");
agreement = (kmeans_labels == competitive_labels) & (competitive_labels == em_labels);
fprintf("Agreement: %f percent\n", (sum(agreement(:)) * 100) / m);

% Visualize the Labels that were given same labels
fprintf("\n\nVisualizing Labels that were given Same Labels...\n");
plot_data = [];
plot_labels = [];
labels = [];
count = 0;
for i = [1:m],
	if (agreement(i) == 1)
		plot_data = [plot_data; X(i, :)];
		plot_labels = [plot_labels; kmeans_labels(i, :)];
		labels = [labels; y(i, :)];
		count += 1;
	end;
end;
plotData(plot_data, plot_labels .+ 1, count); 
title("All Algorithms Agreement");
fprintf("Visualization done.\n");

% Estimate the Accuracy of EM
fprintf("\n\nCalculating Agreement of both Algorithms with Original Labels...\n");
accuracy = (sum((labels == plot_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for All Algorithms...\n");
easy = (sum((plot_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((plot_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((plot_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nComparison Done. Press any key to continue.\n");
pause;



% Compute Labels as Detected by Majority of Algorithms
fprintf("\n\nComputing Labels based on Majority of Outputs...\n");

% Visualize these Labels
fprintf("\n\nVisualizing Labels as Detected by Majority...\n");
plot_data = [];
plot_labels = [];
labels = [];
all_labels = [kmeans_labels competitive_labels em_labels];
count = 0;
for i = [1:m],
	if (!((all_labels(i, 1) != all_labels(i, 2)) && ...
		(all_labels(i, 2) != all_labels(i, 3)) && ...
		(all_labels(i, 1) != all_labels(i, 3))))
		plot_data = [plot_data; X(i, :)];
		plot_labels = [plot_labels; mode(all_labels(i, :))];
		labels = [labels; y(i, :)];
		count += 1;
	end;
end;
plotData(plot_data, plot_labels .+ 1, count); 
title("Mode of Tags");
fprintf("Visualization done.\n");

% Estimate the Accuracy of EM
fprintf("\n\nCalculating Agreement of Mode with Original Labels...\n");
accuracy = (sum((labels == plot_labels)(:)) * 100) / m;
fprintf("Agreement with Original Labels: %f percent\n", accuracy);

% Displaying Statistics
fprintf("\n\nCalculating Statistics for All Algorithms...\n");
easy = (sum((plot_labels == 0)(:)) * 100) / m;	% Percentage of Easy Questions in Suggested Tags
medium = (sum((plot_labels == 1)(:)) * 100) / m;	% Percentage of Medium Questions in Suggested Tags
hard = (sum((plot_labels == 2)(:)) * 100) / m;	% Percentage of Hard Questions in Suggested Tags
fprintf("Percentage of Easy Questions: %f percent\n", easy);
fprintf("Percentage of Medium Questions: %f percent\n", medium);
fprintf("Percentage of Hard Questions: %f percent\n", hard);

fprintf("\n\nEverything Done. Press any key to continue.\n\n\n");
pause;
