
% Main program that performs autoencoding on data based on features.csv
% file obtained after feature extraction

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

% Some useful variables
m = size(X, 1);	% Number of training examples

% Perform mean normalization
fprintf("\n\nPerforming Mean Normalization...\n");
meanX = mean(X);	% Mean of all the features
stdX = std(X);	% Standard deviation of all the features
X = (X - meanX) ./ stdX;
X = X(:, [2,7]);	% Uncomment this line to use selected features
fprintf("Mean Normalization Done.\n");

% Train the Neural Network
fprintf("\n\nTraining Autoencoder...\n");
labels = trainNN(X, X);
fprintf("Done Training.\n\n\n");

