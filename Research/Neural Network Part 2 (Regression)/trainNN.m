
function [theta1, theta2, theta3] = trainNN(X, y, max_iters),

	% X = Input training Vector (m x n)
	% m = Number of Training Example
	% n = Number of Features
	% y = Training Labels (m x 1)
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Set up useful variables
	input_layer_size = n;	% All the features as input
	% hidden_layer_size = floor((n + num_classes) * (2 / 3.0));	% 2/3 times sum of input and output units
	hidden_layer_size_1 = 25;
	hidden_layer_size_2 = 10;
	output_layer_size = 1;	% Number of classes in which marks have been divided
	
	% Regularization Parameter
	lambda = 0.03;
	
	% Initialize all the weights
	initial_theta1 = randInitializeWeights(input_layer_size, hidden_layer_size_1);
	initial_theta2 = randInitializeWeights(hidden_layer_size_1, hidden_layer_size_2);
	initial_theta3 = randInitializeWeights(hidden_layer_size_2, output_layer_size);
	
	% Unroll the parameters
	initial_nn_params = [initial_theta1(:); initial_theta2(:); initial_theta3(:)];
		
	% Set up training environment
	options = optimset('MaxIter', max_iters);
	costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size_1, hidden_layer_size_2, output_layer_size, X, y, lambda);
		
	% Train the network
	[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
	
	% Obtain weights from unrolled parameters
	theta1_ll = 1;
	theta1_ul = hidden_layer_size_1 * (input_layer_size + 1);
	theta2_ll = 1 + theta1_ul;
	theta2_ul = theta2_ll + hidden_layer_size_2 * (1 + hidden_layer_size_1) - 1;
	theta3_ll = theta2_ul + 1;
	theta1 = reshape(nn_params(theta1_ll : theta1_ul), hidden_layer_size_1, input_layer_size + 1);
	theta2 = reshape(nn_params(theta2_ll : theta2_ul), hidden_layer_size_2, hidden_layer_size_1 + 1);
	theta3 = reshape(nn_params(theta3_ll : end), output_layer_size, hidden_layer_size_2 + 1);
	
end;	
