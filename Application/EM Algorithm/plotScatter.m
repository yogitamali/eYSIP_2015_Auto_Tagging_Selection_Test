
function plotScatter(X, w, m),

	% For plotting the results of EM Algorithm
	% Should not be used anywhere else
	
	figure;
	scatter(X(:, 1), X(:, 2), 4, w, "filled");
	
end;
