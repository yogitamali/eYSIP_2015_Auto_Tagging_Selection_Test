
function [centroids, labels] = cluster(X, max_iters, K)

	% Runs the k-Means clustering algorithm on feature matrix X
	% K = Number of clusters to be made
	% max_iters = Maximum number of times the inner loop will iterate
	
	% Some useful variables
	[m n] = size(X);	
	
	% Initialize the labels (clusters)
	previous_labels = zeros(m, 1);

	% Decide the number of times that k-Means must execute
	N = 20;
	
	% Set initial error = infinity
	cluster_error = Inf;

	for j = [1:N],
		
		% Initialize the centroids
		current_centroids = initCentroids(X, K);
		
		fprintf("Running Iteration [%d/%d]: ", j, N);
		fflush(stdout);
			
		% Run K-Means
		for i=1:max_iters
			% For each example in X, assign it to the closest centroid
			[current_error, current_labels] = findClosestCentroids(X, current_centroids);
			% Given the memberships, compute new centroids
			current_centroids = computeCentroids(X, current_labels, K);
			
			% Check for early stopping
			if (sum(previous_labels != current_labels) == 0),
				break;
			end;
			
			previous_labels = current_labels;	
			
		end; 
		
		[current_error, current_labels] = findClosestCentroids(X, current_centroids);		
		
		fprintf("Error = %f\n", current_error);
		
		% Update if error has been reduced
		if (current_error < cluster_error),
			cluster_error = current_error;
			centroids = current_centroids;
			labels = current_labels;
		end;
		
	end;

end;

