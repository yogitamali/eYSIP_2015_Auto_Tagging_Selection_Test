
function labels = trainNN(X, y),

	% X = Input training Vector (m x n)
	% m = Number of Training Example
	% n = Number of Features
	% y = current question tags (m x 1)
	% labels = Suggested Question Tags (m x 1)
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Initialze the labels
	labels = zeros(m, 2);
	
	m = floor(m * 0.7);	% The training Set size
	
	% Set up useful variables
	input_layer_size = n;	% All the features as input
	hidden_layer_size = 5;	% Number of Hidden Units
	output_layer_size = n;	% To reproduce the input
	
	% Regularization Parameter
	lambda = 1;
	
	% Initialize all the weights
	initial_theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
	initial_theta2 = randInitializeWeights(hidden_layer_size, output_layer_size);
	
	% Unroll the parameters
	initial_nn_params = [initial_theta1(:); initial_theta2(:)];	
	% Set up training environment
	options = optimset('MaXIter', 100);
	costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, output_layer_size, X(1:m, :), X(1:m, :), lambda);
		
	% Train the network
	[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
	
	% Obtain weights from unrolled parameters
	theta1 = reshape(nn_params(1 : hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, input_layer_size + 1);
	theta2 = reshape(nn_params(1 + (hidden_layer_size * (input_layer_size + 1)) : end), output_layer_size, hidden_layer_size + 1);
	
	% Calculate Test Data
	predict(theta1, theta2, X(m + 1:end, :));
	
	labels = predict(theta1, theta2, X);
	
	
	% Save the first weight matrix for feature representation for 
	% competitive learning algorithm
	save('Theta1.txt', 'theta1');
	
