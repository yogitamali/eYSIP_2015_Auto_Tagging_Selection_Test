
function E = computeError(X, y, weights1, weights2, lambda)
	
	%-----------------------------------------------------------------%
	% Computes the Error based on the logistic error function. Error  %
	% here refers to the mismatch between input and calculated output %
	%-----------------------------------------------------------------%
	
	% X = input matrix (m x n)
	% y = output matrix using feedForward (m x n)
	% E = (1 x n) matrix containing error per sub network
	% weights1 = Weights for the first edge layer, [p x (n + 1) x n] matrix
	% weights2 = Weights for the second edge layer, [1 x (p + 1) x n] matrix
	% lambda = regularization parameter
		
	m = size(X, 1);
	n = size(X, 2);
	
	% Use logistic error function
	err = -X .* log(y) - ((1 .- X) .* log(1 .- y));
	
	% Sum over all the training examples
	E = sum(err, 1) / m;
	
	% Calculate sum of squared weights per sub network
	reg = zeros(1, n);
	for i = [1:n],
		reg(i) = sum(weights1(:, :, i)(:).^2) + sum(weights2(:, :, i)(:).^2);
	end;
	
	% Add the regularization term
	E = E + (lambda * reg / (2 * m));
	
end;
