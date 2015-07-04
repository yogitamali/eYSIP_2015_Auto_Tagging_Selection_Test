
function [J, grad] = costFunction(X, y, theta, lambda),
	
	% Calculates cost and gradient with respect to all parameters theta
	% J = cost = mean sum of square error
	% grad = gradient vector w.r.t. theta
	% X = (m x n) = Training Matrix
	% y = (m x 1) = Training Labels
	% theta = (n+1 x 1) = Parameters of Linear Regression
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Calculate the cost
	predictedY = X * theta;
	J = sum((predictedY - y).^2) / (2 * m) +...
		 (lambda * sum(theta(2:end) .^ 2) / m);	% Add regularization term
	
	% Calculate gradient
	grad = (sum((predictedY - y) .* X) / m)' +...
			[0; (lambda * (2 * theta(2:end) / m))];	% No regularization for bias term
	
end;
