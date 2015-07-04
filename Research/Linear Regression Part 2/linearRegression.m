
function theta = linearRegression(X, y, max_iters),

	% Performs linear regression
	% X = (m x n) is a training matrix
	% y = (m x 1) is training label matrix
	% max_iters = maximum number of iteration allowed for cost minimizing function
	% theta = (n+1 x 1) is the output parameters
	% m = number of training examples
	% n = number of features
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Set up regularization parameter
	lambda = 0.3;
	
	% Add bias
	X = [ones(m, 1) X];
	
	% Set up cost function
	cf = @(p) costFunction(X, y, p, lambda);
	
	% Set up initial theta
	initial_theta = rand(n + 1, 1);
	
	% Minimize the cost function
	options = optimset('MaxIter', max_iters);
	[theta, cost] = fmincg(cf, initial_theta, options);
	
end;
