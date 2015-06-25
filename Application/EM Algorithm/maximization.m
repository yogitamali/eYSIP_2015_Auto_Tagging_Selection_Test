
function [phi, u, sigma] = maximization(X, w, k),

	% Implements the maximization step of EM Algorithm
	% X = (m x n) Training Matrix
	% w = (m x k) Matrix assigning clusters to Training Examples Probabilistically
	% k = Number of Clusters to be made
	
	% Some useful variables
	[m, n] = size(X);
	
	% Calculate phi, phi(j) represents the a prior probability of cluster j
	phi = sum(w) ./ m;
	
	% Calculate the means [1 x n] mean for each of k clusters
	u = {};
	for i = [1:k],
		u{i} = sum(X .* w(:, i)) / sum(w(:, i));
	end;
	
	% Calculate covariance [n, n] covariance matrix for each of k clusters
	sigma = {};
	for i = [1:k],
		sigma{i} = ((w(:, i) .* X)' * X) ./ sum(w(:, i));
	end;
	
end;
