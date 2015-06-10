
function [J, grad] = costFunction(weights1, weights2, X, y, lambda)

	%-----------------------------------------------------------------%
	% Implements the cost function for the Sparse Neural Network 	  %
	% which can be used by gradient descent or any other optimizing   %
	% algorithm like fmincg()										  %
	%-----------------------------------------------------------------%
	
	% X = input matrix (m x n)
	% y = output matrix using feedForward (m x n)
	% J = (1 x n) matrix containing error per sub network
	% weights1 = Weights for the first edge layer, [p x (n + 1) x n] matrix
	% weights2 = Weights for the second edge layer, [1 x (p + 1) x n] matrix
	% lambda = regularization parameter
	% grad = unrolled gradient vector to be fed to the optimizer
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Compute the error
	J = computeError(weights1, weights2, X, y, lambda);
	
	% Initialize the gradients
	weights1_grad = zeros(size(weights1));
	weights2_grad = zeros(size(weights2));
	
	% Compute the gradients using backpropagation algorithm
	
	for i = [1:n],	% For each of the subnet
		for j = [1:m], % For each of the training examples
			
			delta_output = y(j, i) - X(j, i); % 1 x 1 Matrix in our case
			delta_hidden = weights2(:, :, i)' * delta_output; % (p + 1) x 1 Matrix
			z2 = weights1(:, :, i) * [1 X(j, :)]';	% p x 1 Matrix
			a2 = [1; sigmoid(z2)];
			delta_hidden = delta_hidden(2:end) .* sigmoidGradient(z2); % p x 1 Matrix
			
			weights1_grad(:, :, i) = weights1_grad(:, :, i) + (delta_hidden * [1 X(j, :)]);
			weights2_grad(:, :, i) = weights2_grad(:, :, i) + (delta_output * a2');			
		end;
		
		weights1_grad(:, :, i) = weights1_grad(:, :, i) ./ m;
		weights2_grad(:, :, i) = weights2_grad(:, :, i) ./ m;
	end;
	
	
	
	% Unroll the gradients
	grad = [weights1_grad(:); weights2_grad(:)];
	% Note: Take care to unroll the weights matrix in the same way
	% as you unroll the gradients so that the optimizer can make 
	% sense of the gradient and apply them to the correct weight

end;
