
% Main file which drives linear regression to deduce a model to predict
% performance of students given their profile.
% Features can be read from features.csv
% This program can be modified to use all or a subset of features.

% Suppress Compiler warning for Automatic Broadcasting
warning('off', 'Octave:broadcast');

clear;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load input data from features.csv
fprintf("\n\n\nReading data...\n");
inputData = csvread('features.csv');
student_id = inputData(:, 1);	% First column contains student ids
X = inputData(:, 2:8);	% Column 2-8 contain features, X is Training Matrix
% X = X(:, [1, 3, 7]);	% Uncomment this line to use selected features
y = inputData(:, 9);	% Last column contain student scores which can be used as output
fprintf("Data Read.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate training and test data
fprintf("\n\nSegregating Training and Test Set...\n");
trainingFraction = 0.9;	% Fraction of examples to be used for training set
						% Rest will be used in test set.
idx = randperm(size(X, 1));	% Reshuffle indices in X
numTrainingEx = floor(size(X, 1) * trainingFraction);	% Number of training examples

% Build training data
trainingX = X(idx(1:numTrainingEx), :);
trainingStudentId = student_id(idx(1:numTrainingEx), :);
trainingY = y(idx(1:numTrainingEx), :);

% Build test data, Remaining examples go to test set
testX = X(idx(numTrainingEx + 1 : end), :);
testStudentId = student_id(idx(numTrainingEx + 1 : end), :);
testY = y(idx(numTrainingEx + 1 : end), :);
fprintf("Training and Test Set Segregated.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create the binary feature mapping matrix
fprintf("\n\nCreating Binary Feature Mapping...\n");
fflush(stdout);
featureMapping = createFeatureMapping(trainingX);	% This matrix must be
													% same for both
													% training and test
													% set.
fprintf("Binary Feature Mapping Created.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert categorical features to binary features
fprintf("\n\nConverting to binary features...\n");
fflush(stdout);
trainingX = toBinary(trainingX, featureMapping);
fprintf("Converted to binary features.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run Linear Regression
fprintf("\n\nRunning Linear Regression...\n");
theta = linearRegression(trainingX, trainingY, 100);
fprintf("Linear Regression Complete.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert test examples to binary equivalent
fprintf("\n\nConverting test examples to binary features...\n");
fflush(stdout);
testX = toBinary(testX, featureMapping);
fprintf("Converted to binary features.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate the error on test set
fprintf("\n\nEstimating Errors...\n");
fflush(stdout);
predict(trainingX, trainingY, testX, testY, theta);
fprintf("Errors Estimated.\n\n\n");

