
function [cluster_error, labels] = findClosestCentroids(X, centroids),

	% Assigns the labels based on closest centroid
	
	% Some useful variables	
	K = size(centroids, 1);
	m = size(X, 1);
	
	% Initialize the labels
	labels = zeros(m, 1);
	
	% Initialize the error
	cluster_error = 0;

	for i = [1:m],
		closest_distance = Inf;
		for k = [1:K],
			distance = sum((X(i, :) - centroids(k, :)).^2);
			if distance < closest_distance,
				closest_distance = distance;
				labels(i) = k;
			end;
		end;
		cluster_error += sqrt(closest_distance);
	end;

end;

