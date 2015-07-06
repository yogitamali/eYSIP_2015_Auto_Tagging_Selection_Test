
function [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size_1, hidden_layer_size_2, num_labels, X, y, lambda)

	% Cost Function for Training Neural Network
	% X = m x input_layer_size
	% y = m x num_labels
	
	% Reshape the parameters
	theta1_ll = 1;
	theta1_ul = hidden_layer_size_1 * (input_layer_size + 1);
	theta2_ll = 1 + theta1_ul;
	theta2_ul = theta2_ll + hidden_layer_size_2 * (1 + hidden_layer_size_1) - 1;
	theta3_ll = theta2_ul + 1;
	Theta1 = reshape(nn_params(theta1_ll : theta1_ul), hidden_layer_size_1, input_layer_size + 1);
	Theta2 = reshape(nn_params(theta2_ll : theta2_ul), hidden_layer_size_2, hidden_layer_size_1 + 1);
	Theta3 = reshape(nn_params(theta3_ll : end), num_labels, hidden_layer_size_2 + 1);

	% Some Useful Variables
	m = size(X, 1);	% Number of Training Examples

	% Add bias term to all the examples
	X = [ones(m, 1) X];

	% Initialize cost and gradient
	J = 0;
	Theta1_grad = zeros(size(Theta1));
	Theta2_grad = zeros(size(Theta2));
	Theta3_grad = zeros(size(Theta3));

	% Run a FeedForward Pass
	z1 = (X * Theta1');	% (m x n+1) . (p x n+1)' -> (m x p)	Hidden units for all examples
	a1 = sigmoid(z1);	% Hidden Unit Activations
	a1 = [ones(m, 1) a1];	% Add bias term to hidden units (m x p+1)
	z2 = (a1 * Theta2'); % (m x p+1) . (p+1 x q) = (m x q)
	a2 = sigmoid(z2);	% Hidden unit activation #2
	a2 = [ones(m, 1) a2];	% Add bias term to hidden units
	calculated_Answers = a2 * Theta3'; % Calculate Final Outputs
	
	% Calculate error
	errors = (calculated_Answers - y).^2;
	theta1_new = Theta1(:, 2:size(Theta1, 2));	% For Regularization, don't regularize bias term
	theta2_new = Theta2(:, 2:size(Theta2, 2)); % For Regularization, don't regularize bias term
	theta3_new = Theta3(:, 2:size(Theta3, 2));	% For Regularization, don't regularize bias term
	thetas = [theta1_new(:); theta2_new(:); theta3_new(:)]; % Unroll the parameters
	J = (sum(errors(:)) / m) + (( lambda / (2 * m)) * sum(thetas.^2));

	% Calculate Gradients	
	delta_output = calculated_Answers - y;	% (m x num_labels)
	delta_hidden_2 = (delta_output * Theta3);	% (m x num_labels) . (num_labels x q+1) -> (m x q+1)
	delta_hidden_2 = delta_hidden_2(:, 2:end);	% (m x q) Remove bias
	delta_hidden_2 = delta_hidden_2 .* sigmoidGradient(z2);
	delta_hidden_1 = (delta_hidden_2 * Theta2);	% (m x q) . (q * p+1) = (m x p+1)
	delta_hidden_1 = delta_hidden_1(:, 2:end); % (m x p) Remove bias
	delta_hidden_1 = delta_hidden_1 .* sigmoidGradient(z1);
	
	Theta3_grad = (delta_output' * a2) / m; % (m x num_labels)' . (m x q+1) -> (num_labels x q+1)
	backup_bias = Theta3_grad(:, 1);
	Theta3_grad = Theta3_grad + ((lambda / m) * Theta3);	% Regularize
	Theta3_grad(:, 1) = backup_bias;	% Restore bias term, no regularization on bias
	
	Theta2_grad = (delta_hidden_2' * a1) / m; % (m x q)' . (m x p+1) -> (q x p+1)
	backup_bias = Theta2_grad(:, 1);
	Theta2_grad = Theta2_grad + ((lambda / m) * Theta2);	% Regularize
	Theta2_grad(:, 1) = backup_bias;	% Restore bias term, no regularization on bias
		
	Theta1_grad = (delta_hidden_1' * X) / m;	% (m x p)' . (m x n+1) -> (p x n+1)
	backup_bias = Theta1_grad(:, 1);
	Theta1_grad = Theta1_grad + ((lambda / m) * Theta1);	% Regularize
	Theta1_grad(:, 1) = backup_bias;	% Restore the bias term
	
	% Unroll the gradients
	grad = [Theta1_grad(:) ; Theta2_grad(:); Theta3_grad(:)];

end;
