
function labels = competitive(X, K)

	% Runs the competitive learning algorithm on feature matrix X
	% K = Number of clusters to be made
	
	% Some useful variables
	[m n] = size(X);	
	
	% Initialize the labels (clusters)
	labels = zeros(m, 1);

	% Load parameters from Autoencoder
	load('6Theta1.txt');	% Loaded in variable theta1

	% Set up features from Autoencoder
	X = sigmoid([ones(m, 1) X] * theta1');
	
	% Find the new number of features
	n = size(X, 2);
	
	% Randomly initialize weights
	weights = rand(K, n);
	
	% Make sure that all weights sum up to 1 for each output unit
	weights = weights ./ sum(weights, 2);
	
	% Initialize the max number of iterations here
	max_iter = 50;
	
	% Set the learning rate
	epsilon = 0.1;
		
	for j = [1:max_iter],
	
		for i = [1:m],	% Perform online learning
			output = X(i, :) * weights';	% Calculate output values
			[dummy, idx] = max(output);		% Find winner index
			weights(idx, :) += ((epsilon .* X(i, :)) ./ sum(X(i, :)) .- epsilon .* weights(idx, :));	% Update the weights according to competitive learning rule
		end;
	
	end;
	
	% Calculate the final labels
	output = X * weights';
	[dummy, idx] = max(output');
	labels = idx';
	
end;

