
function XReduce = pca(X, m)
	
	% Performs dimensionality reduction on X using PCA algorithm
	% X is the input feature matrix of size m x n
	% m is the number of training examples in X
	
	% Decide the number of components to use
	numComponents = 2;
	
	[U, S, V] = svd((X' * X) * (1 / m));
	R = U(:, 1:numComponents);
	XReduce = X * R;

end;

