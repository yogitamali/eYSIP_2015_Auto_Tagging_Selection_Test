
function w = expectation(X, phi, u, sigma, k),

	% X = (m x n) Training Data
	% phi = (m x k) obtained from maximization
	% u = means of all clusters
	% sigma = covariance of all clusters
	
	% Some useful variables
	[m, n] = size(X);
	
	% Initialize w
	w = zeros(m, k);
	
	% Now calculate w
	for i = [1:m],
		% First calculate P(x_i)
		p_x = 0;
		for j = [1:k],
			p_x += (p_x_given_n(X(i, :), u{j}, sigma{j}) * phi(j)); 
		end;		
		
		for j = [1:k],		
			w(i, j) = (p_x_given_n(X(i, :), u{j}, sigma{j}) * phi(j)) / p_x;
		end;
	end;
	
end; 
