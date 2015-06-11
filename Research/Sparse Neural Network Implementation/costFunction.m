
function [J, grad] = costFunction(networkParams, X, lambda, p)

	%-----------------------------------------------------------------%
	% Implements the cost function for the Sparse Neural Network 	  %
	% which can be used by gradient descent or any other optimizing   %
	% algorithm like fmincg()										  %
	%-----------------------------------------------------------------%
	
	% X = input matrix (m x n)
	% y = output matrix using feedForward (m x n)
	% J = (1 x n) matrix containing error per sub network
	% networkParams = unrolled neural network weights
	% p = Number of hidden units
	% weights1 = Weights for the first edge layer, [p x (n + 1) x n] matrix
	% weights2 = Weights for the second edge layer, [1 x (p + 1) x n] matrix
	% lambda = regularization parameter
	% grad = unrolled gradient vector to be fed to the optimizer
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Unroll the weights
	weights1 = reshape(networkParams(1: (p * (n + 1) * n)), p, n + 1, n);	
	weights2 = reshape(networkParams(1 + (p * (n + 1) * n): end), 1, p + 1, n);
	
	% Calculate output y and hidden units z
	[y, z] = feedForward(weights1, weights2, X);
	
	% Compute the error
	J = computeError(X, y, weights1, weights2, lambda);
	
	% Initialize the gradients
	weights1_grad = zeros(size(weights1));
	weights2_grad = zeros(size(weights2));
	
	% Compute the gradients using backpropagation algorithm
	
	for i = [1:n],	% For each of the subnet
		
		for j = [1:m], % For each of the training examples
			
			delta_output = y(j, i) - X(j, i); % 1 x 1 Matrix in our case
			delta_hidden = weights2(:, :, i)' * delta_output; % (p + 1) x 1 Matrix
			z2 = z(j, :, i)';	% p x 1 Matrix
			a2 = [1; sigmoid(z2)];
			delta_hidden = delta_hidden(2:end) .* sigmoidGradient(z2); % p x 1 Matrix
			
			weights1_grad(:, :, i) = weights1_grad(:, :, i) + (delta_hidden * [1 X(j, :)]);
			weights2_grad(:, :, i) = weights2_grad(:, :, i) + (delta_output * a2');			
		end;
		
		weights1_grad(:, :, i) = weights1_grad(:, :, i) ./ m;
		weights2_grad(:, :, i) = weights2_grad(:, :, i) ./ m;
		
		% Now remove gradients for weights that are missing in the
		% sparse neural network		
		for k = [1:p],
			weights1_grad(k, i + 1, i) = 0;
		end;
		
	end;
		
	% Unroll the gradients
	grad = [weights1_grad(:); weights2_grad(:)];
	% Note: Take care to unroll the weights matrix in the same way
	% as you unroll the gradients so that the optimizer can make 
	% sense of the gradient and apply them to the correct weight
		
	% fmincg expects the error to be a scalar quantity
	J = sum(J(:));

end;
