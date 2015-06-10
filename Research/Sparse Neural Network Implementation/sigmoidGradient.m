
function g = sigmoidGradient(z)
	
	%----------------------------------------------------------------%
	% Computes the sigmoid gradient of z. z can be scalar or matrix  %
	%----------------------------------------------------------------%
	
	g = zeros(size(z));
	g = sigmoid(z) .* (ones(size(z)) - sigmoid(z));

end;
