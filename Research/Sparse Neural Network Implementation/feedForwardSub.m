
function output = feedForwardSub(weights1, weights2, inputData)

	%-------------------------------------------------------------------%
	% Calculates the output of a sub Network in Sparse Neural Network	%
	% given the input and edge weights for Subnetwork									%
	%-------------------------------------------------------------------%
	
	% m = Number of input vectors size(inputData, 1)
	% n = Number of Questions  = size(inputData, 2)
	% p = Number of Hidden layer units per sub network
	% weights1 = Weights for the first edge layer, [p x (n + 1)] matrix
	% weights2 = Weights for the second edge layer, [1 x (p + 1)] matrix
	% output = m x 1 output matrix, for a particular question
	
	% Here n must include the bias term as well
	m = size(inputData, 1);
	n = size(inputData, 2);
	
	% Calculate the Hidden units (m x p), p units for each of the m examples
	% Calculate sigmoid activations of hidden units
	hiddenUnits = sigmoid(inputData * weights1');
	
	% Add bias to hidden units
	hiddenUnits = [ones(m, 1) hiddenUnits];
	
	% Calculate output units (m x 1) column vector
	% Calculate sigmoid activation of output units
	output = sigmoid(hiddenUnits * weights2');
	% Note: We can also try a linear mapping at output layer instead of
	% a sigmoid mapping

end;
