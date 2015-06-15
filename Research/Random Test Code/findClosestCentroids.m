function idx = findClosestCentroids(X, centroids)

K = size(centroids, 1);

m = size(X, 1);
idx = zeros(m, 1);

for i = [1:m],
	closest_distance = 99999;
	for k = [1:K],
		temp = (X(i, :) - centroids(k, :)).^2;
		distance = sum(temp);
		if distance < closest_distance,
			closest_distance = distance;
			idx(i) = k;
		end;
	end;
end;

end

