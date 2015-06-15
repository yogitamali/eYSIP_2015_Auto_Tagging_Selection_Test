function centroids = computeCentroids(X, idx, K)

[m n] = size(X);

% You need to return the following variables correctly.
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

end

