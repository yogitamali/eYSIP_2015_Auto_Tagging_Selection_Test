
function p = p_x_given_n(x, u, sigma),

	% Calculates P(x_i | u_j, sigma_j) using gaussian distribution
	% u = mean
	% sigma = covariance matrix
	
	p = (1 / sqrt(2 * pi * det(sigma))) * ...
		exp(-0.5 * ((x - u) * pinv(sigma) * (x - u)'));

end;	
	
