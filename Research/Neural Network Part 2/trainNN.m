
function [theta1, theta2] = trainNN(X, y, max_iters, num_classes),

	% X = Input training Vector (m x n)
	% m = Number of Training Example
	% n = Number of Features
	% y = Training Labels (m x 1)
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Set up useful variables
	input_layer_size = n;	% All the features as input
	% hidden_layer_size = floor((n + num_classes) * (2 / 3.0));	% 2/3 times sum of input and output units
	hidden_layer_size = 30;
	output_layer_size = num_classes;	% Number of classes in which marks have been divided
	
	% Regularization Parameter
	lambda = 1;
	
	% Initialize all the weights
	initial_theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
	initial_theta2 = randInitializeWeights(hidden_layer_size, output_layer_size);
	
	% Unroll the parameters
	initial_nn_params = [initial_theta1(:); initial_theta2(:)];
	
	% Convert outputs to required form
	newY = zeros(m, output_layer_size);	% Neural Network output is a vector for each training example
	for i = [1:m],
		newY(i, y(i)) = 1;
	end;
	
	% Set up training environment
	options = optimset('MaxIter', max_iters);
	costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, output_layer_size, X, newY, lambda);
		
	% Train the network
	[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
	
	% Obtain weights from unrolled parameters
	theta1 = reshape(nn_params(1 : hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, input_layer_size + 1);
	theta2 = reshape(nn_params(1 + (hidden_layer_size * (input_layer_size + 1)) : end), output_layer_size, hidden_layer_size + 1);
	
end;	
