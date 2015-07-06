
function g = sigmoid(z)

	% Calculates the sigmoid function	
	
	g = zeros(size(z));
	g = 1./(1 .+ exp(-z));

end;
