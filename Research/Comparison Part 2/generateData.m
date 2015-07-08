
% File which generates training and test set to be used by other
% algorithms for comparison.
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
% X = X(:, [1, 2, 6, 7]);	% Uncomment this line to use selected features
y = inputData(:, 9);	% Last column contain student scores which can be used as output
fprintf("Data Read.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Assign class to each output based on marks obtained. Eg. 30 - 34 go to class 6
fprintf("\n\nAssigning Class to Students Based on Marks...\n");
class_interval = 5;	% Adjust this to change precision of output
y = 1 .+ floor((y .- min(y)) / class_interval);
num_classes = max(y);
fprintf("Classes Assigned");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Separate training and test data
fprintf("\n\nSegregating Training and Test Set...\n");
trainingFraction = 0.95;	% Fraction of examples to be used for training set
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

% Save testX, testY, trainingX and trainingY
fprintf("\n\nSaving Data...\n");
save('trainingX', 'trainingX');
save('testX', 'testX');
save('trainingY', 'trainingY');
save('testY', 'testY');
fprintf("Data Saved.\n\n\n");


