
function labels = trainNN(X, y),

	% X = Input training Vector (m x n)
	% m = Number of Training Example
	% n = Number of Features
	% y = current question tags (m x 1)
	% labels = Suggested Question Tags (m x 1)
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Initialze the labels
	labels = zeros(m, 1);
	
	% Set up useful variables
	input_layer_size = n;	% All the features as input
	hidden_layer_size = floor((n + 3) * (2 / 3.0));	% 2/3 times sum of input and output units
	output_layer_size = 3;	% 3 difficulty levels edit this for more difficulty levels
	
	% Regularization Parameter
	lambda = 3;
	
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
	options = optimset('MaXIter', 100);
	costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, output_layer_size, X, newY, lambda);
		
	% Train the network
	[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
	
	% Obtain weights from unrolled parameters
	theta1 = reshape(nn_params(1 : hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, input_layer_size + 1);
	theta2 = reshape(nn_params(1 + (hidden_layer_size * (input_layer_size + 1)) : end), output_layer_size, hidden_layer_size + 1);
	
	% Calculate Suggested Labels
	labels = predict(theta1, theta2, X);
	
