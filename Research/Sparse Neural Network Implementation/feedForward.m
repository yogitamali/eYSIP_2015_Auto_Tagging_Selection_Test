
function output = feedForward(weights1, weights2, inputData)

	%-------------------------------------------------------------------%
	% Calculates the output units of the Overall Sparse Neural Network	%
	% given the input and edge weights									%
	%-------------------------------------------------------------------%

	% m = Number of input vectors size(inputData, 1)
	% n = Number of Questions  = size(inputData, 2)
	% p = Number of Hidden layer units per sub network
	% weights1 = Weights for the first edge layer, [p x (n + 1) x n] matrix
	% weights2 = Weights for the second edge layer, [1 x (p + 1) x n] matrix
	% output = m x n output matrix
	
	m = size(inputData, 1);
	n = size(inputData, 2);
	output = [];
	
	% Append Bias terms to input
	inputData = [ones(m, 1) inputData];	

	% Calculate the output of each subnetwork
	for i = [1:n],
		output = [output feedForwardSub(weights1(:, :, i), weights2(:, :, i), inputData)];
	end;
	
end;
