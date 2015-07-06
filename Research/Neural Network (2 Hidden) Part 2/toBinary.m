
function binaryX = toBinary(X, featureMapping),

	% Converts the categorical features in X to binary features for
	% all training examples
	% featureMapping must be obtained from createFeatureMapping.m
	
	% Some useful variables
	m = size(X, 1);
	n = size(X, 2);
	
	binaryX = [];
	
	for i = [1:m],
		feature_i = [];	% Current binary representation
		
		for j = [1:n],
			feature_j = zeros(1, featureMapping(j, 1) + 1);	% All features + 'is_other' feature
			idx = findElement(X(i, j), featureMapping(j, :));
			if (idx == -1)
				% By convention feature_j(1) is 'other' for all features j
				feature_j(1) = 1;	% is_other
			else
				feature_j(idx) = 1;	
			end;
			
			feature_i = [feature_i feature_j];	% Concatenate features
		end;
		
		binaryX = [binaryX; feature_i];	% Add the binary representation
	end;
	
end;
