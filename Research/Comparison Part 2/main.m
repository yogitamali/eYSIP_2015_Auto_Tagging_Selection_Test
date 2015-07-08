
% Main file which implements comparison of various algorithms used for
% classification in part 2

clear;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the test data that was used by other algorithms
fprintf("\n\n\nReading test data...\n");
load('testY');
m = size(testY, 1);	% Number of test examples
fprintf("Number of test examples: %d\n", m);
fprintf("Test data read.\n");

% Show original labels in histogram
figure;
hist(testY);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analyze the Naive Bayes Output
fprintf("\n\nAnalysing Naive Bayes Output...\n");

% Load the output
fprintf("\nLoading Output...\n");
load('NBOutput');	% output in nb_output
fprintf("Output Loaded.\n");

% Calculate Accuracy
fprintf("\nCalculating Accuracy...\n");
accuracy = sum((testY == nb_output)(:)) * 100 / m;	% Calculate exact accuracy
fprintf("Accuracy (exact): %f\n", accuracy);
accuracy = sum((abs(testY - nb_output)(:)) <= 1) * 100 / m;	% Calculate accuracy +- 1 class
fprintf("Accuracy (+- 1 Class label): %f\n", accuracy);
accuracy = sum((abs(testY - nb_output)(:)) <= 2) * 100 / m;	% Calculate accuracy +- 2 class
fprintf("Accuracy (+- 2 Class label): %f\n", accuracy);

% Show Correct Correst labels in histogram
% bucket 0 contains incorrect answers
figure;
hist((nb_output == testY) .* testY);

fprintf("\nNaive Bayes Analyzed.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analyze the Neural Network Output
fprintf("\n\nAnalysing Neural Network (1 Hidden Layer) Output...\n");

% Load the output
fprintf("\nLoading Output...\n");
load('NNOutput');	% output in nn_output
fprintf("Output Loaded.\n");

% Calculate Accuracy
fprintf("\nCalculating Accuracy...\n");
accuracy = sum((testY == nn_output)(:)) * 100 / m;	% Calculate exact accuracy
fprintf("Accuracy (exact): %f\n", accuracy);
accuracy = sum((abs(testY - nn_output)(:)) <= 1) * 100 / m;	% Calculate accuracy +- 1 class
fprintf("Accuracy (+- 1 Class label): %f\n", accuracy);
accuracy = sum((abs(testY - nn_output)(:)) <= 2) * 100 / m;	% Calculate accuracy +- 2 class
fprintf("Accuracy (+- 2 Class label): %f\n", accuracy);

% Show Correct Correst labels in histogram
% bucket 0 contains incorrect answers
figure;
hist((nn_output == testY) .* testY);

fprintf("\nNeural Network (1 Hidden Layer) Analyzed.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analyze the Neural Network (2 Hidden Layers) Output
fprintf("\n\nAnalysing Neural Network (2 Hidden Layers) Output...\n");

% Load the output
fprintf("\nLoading Output...\n");
load('NN2Output');	% output in nn2_output
fprintf("Output Loaded.\n");

% Calculate Accuracy
fprintf("\nCalculating Accuracy...\n");
accuracy = sum((testY == nn2_output)(:)) * 100 / m;	% Calculate exact accuracy
fprintf("Accuracy (exact): %f\n", accuracy);
accuracy = sum((abs(testY - nn2_output)(:)) <= 1) * 100 / m;	% Calculate accuracy +- 1 class
fprintf("Accuracy (+- 1 Class label): %f\n", accuracy);
accuracy = sum((abs(testY - nn2_output)(:)) <= 2) * 100 / m;	% Calculate accuracy +- 2 class
fprintf("Accuracy (+- 2 Class label): %f\n", accuracy);

% Show Correct Correst labels in histogram
% bucket 0 contains incorrect answers
figure;
hist((nn2_output == testY) .* testY);

fprintf("\nNeural Network (2 Hidden Layers) Analyzed.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compare Naive Bayes and  Neural Network (1 Hidden Layer)
fprintf("\n\nComparing Naive Bayes and Neural Network (1 Hidden Layer)...\n");

% Calculate Agreement
fprintf("\nCalculating Agreement...\n");
agreement = sum((nb_output == nn_output)(:)) * 100 / m;	% Calculate exact accuracy
fprintf("Agreement (exact): %f\n", agreement);
agreement = sum((abs(nb_output - nn_output)(:)) <= 1) * 100 / m;	% Calculate accuracy +- 1 class
fprintf("Agreement (+- 1 Class label): %f\n", accuracy);
agreement = sum((abs(nb_output - nn_output)(:)) <= 2) * 100 / m;	% Calculate accuracy +- 2 class
fprintf("Agreement (+- 2 Class label): %f\n", agreement);

fprintf("\nComparison Complete.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compare Naive Bayes and  Neural Network (2 Hidden Layers)
fprintf("\n\nComparing Naive Bayes and Neural Network (2 Hidden Layers)...\n");

% Calculate Agreement
fprintf("\nCalculating Agreement...\n");
agreement = sum((nb_output == nn2_output)(:)) * 100 / m;	% Calculate exact accuracy
fprintf("Agreement (exact): %f\n", agreement);
agreement = sum((abs(nb_output - nn2_output)(:)) <= 1) * 100 / m;	% Calculate accuracy +- 1 class
fprintf("Agreement (+- 1 Class label): %f\n", accuracy);
agreement = sum((abs(nb_output - nn2_output)(:)) <= 2) * 100 / m;	% Calculate accuracy +- 2 class
fprintf("Agreement (+- 2 Class label): %f\n", agreement);

fprintf("\nComparison Complete.\n");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compare Neural Network (2 Hidden Layers) and  Neural Network (1 Hidden Layer)
fprintf("\n\nComparing Neural Networks...\n");

% Calculate Agreement
fprintf("\nCalculating Agreement...\n");
agreement = sum((nn2_output == nn_output)(:)) * 100 / m;	% Calculate exact accuracy
fprintf("Agreement (exact): %f\n", agreement);
agreement = sum((abs(nn2_output - nn_output)(:)) <= 1) * 100 / m;	% Calculate accuracy +- 1 class
fprintf("Agreement (+- 1 Class label): %f\n", accuracy);
agreement = sum((abs(nn2_output - nn_output)(:)) <= 2) * 100 / m;	% Calculate accuracy +- 2 class
fprintf("Agreement (+- 2 Class label): %f\n", agreement);

fprintf("\nComparison Complete.\n");
