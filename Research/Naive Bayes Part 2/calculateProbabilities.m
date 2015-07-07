
function probabilities =  calculateProbabilities(X, y, featureMapping, num_classes),

	% Calculates the probabilities P(x_i = k | y = j) for all i, j, k
	% X is training matrix (m x n)
	% y is training labels vector (m x 1)
	% m = number of training examples
	% n = number of features
	% num_classes = number of classes in which data is to be classified
	% Returns the data in probabilities in the following format:
	% probabilities(i, j, k) = P(x_i = featureMapping(i, j) | y = k)
	% probabilities(i, 1, k) = P(x_i = 'other' | y = k)
	
	
	% Some useful variables
	m = size(X, 1);
	n = size(X, 2);
	
	% Initialize the probabilities
	probabilities = zeros(n, max(featureMapping(:, 1)) + 1, num_classes);
	
	% Calculate probabilities
	for i = [1:n],
		last_index = featureMapping(i, 1) + 1;	% featureMapping(i, 1) contains number of distinct ids in feature i		
		for j = [2:last_index],
			for k = [1:num_classes],
				probabilities(i, j, k) = ...
				(sum((X(:, i) == featureMapping(i, j)) & (y == k)) + 1)/...	% Calculate with Laplace Smoothing
				(sum(y == k) + num_classes);
			end;
		end;
	end;
	
	% Calculate 'other' probabilities
	for i = [1:n],
		for k = [1:num_classes],
			probabilities(i, 1, k) = ...
			(sum((X(:, i) == -1) & (y == k)) + 1)/...
			(sum(y == k) + num_classes);
		end;
	end;
	
end;
