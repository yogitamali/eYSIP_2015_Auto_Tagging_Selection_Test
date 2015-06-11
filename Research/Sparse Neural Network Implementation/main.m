
% Main program that drives the Training of Sparse Neural Network

clear;
close all;
clc;

% Load the training data in matrix X -> m x n
% m = Number of training examples, i.e. Number of students that appeared for test
% n = Total number of features, here total number of questions
load('examples.txt');
m = size(X, 1);
n = size(X, 2);

% Decide the size of hidden layer, this can also be defined in terms of n
num_hidden_units = 10;

% Randomly initialize weights
weights1 = rand(num_hidden_units, n + 1, n) - (0.5 * ones(num_hidden_units, n + 1, n));
weights2 = rand(1, num_hidden_units + 1, n) - (0.5 * ones(1, num_hidden_units + 1, n));

% Remove missing edges from Sparse Network
for i = [1:n],
	for j = [1:num_hidden_units],
		weights1(j, i + 1, i) = 0;
	end;
end;
	

% Unroll the weights
initialNetworkParams = [weights1(:); weights2(:)];

% Define the regularization parameter
lambda = 0.5;

% Train the network
options = optimset('MaxIter', 50);
cf = @(p) costFunction(p, X, lambda, num_hidden_units);
[networkParams, cost] = fmincg(cf, initialNetworkParams, options);

% options = optimset('GradObj', 'on', 'MaxIter', 50);
% cf = @(p) costFunction(p, X, lambda, num_hidden_units);
% [networkParams, cost, exit_flag] = fminunc(cf, initialNetworkParams, options);

% Now unroll the parameters
weights1 = reshape(networkParams(1: (num_hidden_units * (n + 1) * n)), num_hidden_units, n + 1, n);	
weights2 = reshape(networkParams(1 + (num_hidden_units * (n + 1) * n): end), 1, num_hidden_units + 1, n);

[y, h] = feedForward(weights1, weights2, X);
figure;
plot(sum(y) / m, 'rx'); % Plot expected solvability of each question

% Now we can perform clustering on y to obtain question tags
% Then we can compare the question tag to existing question tags and
% offer corrections based on it.

