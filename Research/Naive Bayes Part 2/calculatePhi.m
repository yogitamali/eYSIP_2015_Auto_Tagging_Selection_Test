
function phi = calculatePhi(X, y, num_classes),

	% Calculates phi, phi(k) = P(y_i = k)
	% X is the training matrix (m x n)
	% y is the training label vector (m x 1)
	% num_classes denote different number of classes in which data in X
	% may be classified
	% m = number of training examples
	% n = number of features
	
	% Some useful variables
	m = size(X, 1);
	n = size(X, 2);
	
	% Calculate phi
	phi = zeros(num_classes, 1);	% phi(k) = P(y_i = k) with Laplace Smoothing
	for i = [1:m],
		phi(y(i)) += 1;	% Count how many times each of the class was seen
	end;
	phi = phi + ones(num_classes, 1);	% Add 1 for Laplace smoothing
	phi = phi / (m + num_classes);	% Calculate probabilities with Laplace Smoothing
	
end;
