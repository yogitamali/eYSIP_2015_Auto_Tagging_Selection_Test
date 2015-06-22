
function [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)

	% Cost Function for Training Neural Network
	% X = m x input_layer_size
	% y = m x num_labels
	
	% Reshape the parameters	
	Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
		             hidden_layer_size, (input_layer_size + 1));

	Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
		             num_labels, (hidden_layer_size + 1));

	% Some Useful Variables
	m = size(X, 1);	% Number of Training Examples

	% Add bias term to all the examples
	X = [ones(m, 1) X];

	% Initialize cost and gradient
	J = 0;
	Theta1_grad = zeros(size(Theta1));
	Theta2_grad = zeros(size(Theta2));

	% Run a FeedForward Pass
	z1 = (X * Theta1');	% (m x n+1) . (p x n+1)' -> (m x p)	Hidden units for all examples
	a1 = sigmoid(z1);	% Hidden Unit Activations
	a1 = [ones(m, 1) a1];	% Add bias term to hidden units
	calculated_Answers = sigmoid(a1 * Theta2'); % Calculate Final Outputs
	
	% Calculate error
	errors = -y .* log(calculated_Answers) - ((ones(m, num_labels) - y) .* log(ones(m, num_labels) - calculated_Answers));
	theta1_new = Theta1(:, 2:size(Theta1, 2));	% For Regularization, don't regularize bias term
	theta2_new = Theta2(:, 2:size(Theta2, 2)); % For Regularization, don't regularize bias term
	thetas = [theta1_new(:); theta2_new(:)]; % Unroll the parameters
	J = (sum(errors(:)) / m) + (( lambda / (2 * m)) * sum(thetas.^2));

	% Calculate Gradients	
	delta_output = calculated_Answers - y;	% (m x num_labels)
	delta_hidden = (delta_output * Theta2);	% (m x num_labels) . (num_labels x p+1) -> (m x p+1)
	delta_hidden = delta_hidden(:, 2:end);	% (m x p) Remove bias
	delta_hidden = delta_hidden .* sigmoidGradient(z1);
	
	Theta2_grad = (delta_output' * a1) / m; % (m x num_labels)' . (m x p+1) -> (num_labels x p+1)
	backup_bias = Theta2_grad(:, 1);
	Theta2_grad = Theta2_grad + ((lambda / m) * Theta2);	% Regularize
	Theta2_grad(:, 1) = backup_bias;	% Restore bias term, no regularization on bias
		
	Theta1_grad = (delta_hidden' * X) / m;	% (m x p)' . (m x n+1) -> (p x n+1)
	backup_bias = Theta1_grad(:, 1);
	Theta1_grad = Theta1_grad + ((lambda / m) * Theta1);	% Regularize
	Theta1_grad(:, 1) = backup_bias;	% Restore the bias term
	
	% Unroll the gradients
	grad = [Theta1_grad(:) ; Theta2_grad(:)];

end;
