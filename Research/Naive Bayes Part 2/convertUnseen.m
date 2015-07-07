
function converted = convertUnseen(X, featureMapping),
	
	% Converts all those feature to 'other' (represented by -1) in X
	% where the corresponding entry in featureMapping does not exists
	% X = (m x n)
	% m = Number of examples
	% n = Number of features
	% featureMapping = (n x m) and must be obtained from createFeatureMapping.m
	% without any modification
	
	m = size(X, 1);
	n = size(X, 2);	
	
	for i = [1:m],
		for j = [1:n],
			if (!any(featureMapping(j, 2:end) == X(i, j))),	% Search for X(i, j) in featureMapping(j, 2:end)
				X(i, j) = -1;	% If not found, make this other
			end;
		end;
	end;
	
	converted = X;
end;
