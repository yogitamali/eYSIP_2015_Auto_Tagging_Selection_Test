
function predict(question_id, question_ids, X, centroids, labels, map),
	
	% Predicts the cluster for a given question id
	
	idx = 1;
	
	m = size(X, 1);	
	% Find the index in training matrix
	for i = [1:m],
		if (question_ids(i) == question_id)
			idx = i;
			break;
		end;
	end;
	
	idx
	
	vector = X(idx, :);
	
	fprintf("\n\nFeature Vector: \n");
	for i = [1:size(vector, 2)],
		fprintf("\t%f", vector(i));
	end;
	
	fprintf("\n\nDistance from %d: %5.3f\n", map(1), sqrt(sum((centroids(1, :) - vector).^2)));
	fprintf("Distance from %d: %5.3f\n", map(2), sqrt(sum((centroids(2, :) - vector).^2)));
	fprintf("Distance from %d: %5.3f\n", map(3), sqrt(sum((centroids(3, :) - vector).^2)));
	
	fprintf("\n\nAssigned Label: %d\n\n", labels(idx));
end;
