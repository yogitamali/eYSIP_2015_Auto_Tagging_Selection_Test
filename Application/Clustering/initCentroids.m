
function centroids = initCentroids(X, K)
	
	% Randomly Initializes Centroids
	
	centroids = zeros(K, size(X, 2));
	randidx = randperm(size(X, 1));
	centroids = X(randidx(1:K), :);

end;

