
function centroids = computeCentroids(X, idx, K),

	% Computes centroids

	% Some Useful Variables
	[m n] = size(X);

	% Initialize the Centroids
	centroids = zeros(K, n);

	for i = [1:K],
		temp = zeros(1, n);
		count = 0;
		for j = [1:m],
			if idx(j) == i,
				temp += X(j, :);
				count += 1;
			end;
		end;
		centroids(i, :) = temp / count;
	end;

end;

