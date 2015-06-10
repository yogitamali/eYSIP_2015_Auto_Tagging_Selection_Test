
function g = sigmoid(z)

	% Compute the sigmoid function of the input 
	
	% z may be a matrix or a scalar value
	% g has same dimensions as z
	
	g = 1.0 ./ (1.0 + exp(-z));

end;
