
function [labels, w] = em(X, y, k, max_iters),

	% Implements the Expectation Maximization Algorithm on the Training
	% Set X with Initial Labels y, to cluster it into k clusters
	%
	% X = Training Data (m x n)
	% m = Number of Training Examples
	% n = Number of Features
	% y = Initial Labels (m x 1)
	% k = Number of Clusters into which data is to be divided
	% max_iters = Maximum Number of Iterations
	
	% Some useful variables
	[m, n] = size(X);
	
	% Initialize the w matrix
	w = initEM(m, k, y);
	
	% Initialize the means and covariances
	u = {};	% u{i} will contain mean vector of cluster i
	sigma = {};	% sigma{i} will contain covariance of cluster i
	
	% Run the initial maximization step
	[phi, u, sigma] = maximization(X, w, k);
	
	% Run the algorithm
	for i = [1:max_iters],
		w = expectation(X, phi, u, sigma, k);
		[phi, u, sigma] = maximization(X, w, k);
	end;
	
	% Calculate the labels
	labels = zeros(m, 1);
	for i = [1:m],
		[dummy, labels(i)] = max(w(i, :));
	end;
end;
	
