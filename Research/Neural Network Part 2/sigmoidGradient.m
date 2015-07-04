
function g = sigmoidGradient(z)
	
	% Computes the sigmoid gradient
	
	g = zeros(size(z));
	g = sigmoid(z) .* (ones(size(z)) - sigmoid(z));

end;
