
function p = predict(Theta1, Theta2, X)
	
	% Predicts the output based on a feed forward pass
	
	m = size(X, 1);

	h1 = sigmoid([ones(m, 1) X] * Theta1');
	p = [ones(m, 1) h1] * Theta2';
	
	errors = sum(((p - X).^2)(:)) / m;
	
	fprintf("Test error: %f\n", errors);

end;
