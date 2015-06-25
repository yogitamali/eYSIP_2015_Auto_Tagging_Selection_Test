
function w = initEM(m, k, y),
	
	% Initializes the original w matrix where w(i, j) represents
	% the probability that c_j was the cluster from which x_i
	% was drawn	
	
	w = zeros(m, k);	% w(i, j) = P(c_j | x_i), Probability that current
						% training example x_i belongs to c_j
	for i = [1:m],
		w(i, y(i) .+ 1) = 1;
		% w(i, :) = rand(1, k);
		% w(i, :) = w(i, :) / sum(w(i, :));
	end;
	
end;
