
function R = pca(X)
	
	% Performs dimensionality reduction on X using PCA algorithm
	% X is the input feature matrix of size m x n
	% m is the number of training examples in X
	% n is the numner of features
	% R is the matrix to perform reduction, reducedX = X * R
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Decide the amount of variance to retain
	varianceToRetain = 0.99;
	
	[U, S, V] = svd((X' * X) * (1 / m));
	
	% Decide Optimal Number of Components to Retain Required Variance
	
	sumSDiagonal = 0;	% Sum of all diagonal elements in S
	for i = [1:n],
		sumSDiagonal += S(i, i);
	end;
	
	numComponents = 0;
	currentSum = 0;	% Sum of all S(j, j) upto current principle component
	for numComponents = [1:n],
		currentSum += S(numComponents, numComponents);
		if (currentSum/sumSDiagonal >= varianceToRetain)
			break;
		end;
	end;
		
	% Find Reduction Matrix
	R = U(:, 1:numComponents);
	
	% Print Statistics
	fprintf("Original Number of Features: %d\n", n);
	fprintf("Number of Features after Dimensionality Reduction: %d\n", numComponents);

end;

