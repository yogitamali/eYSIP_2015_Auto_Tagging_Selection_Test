
function featureMapping = createFeatureMapping(X),

	% m = size(X, 1), no of examples
	% n = size(X, 2), no of features
	% featureMapping = (n x m) matrix. The structure is as follows
	% p = featureMapping(i, 1) = no of distinct entries in feature i
	% featureMapping(i, 2..p) = distinct ids in feature i
	
	m = size(X, 1);
	n = size(X, 2);
	
	% Initialize Feature Mapping
	featureMapping = zeros(n, m);
	
	% Populate featureMapping (Slower Implementation) O(n.m^2) (Less space Complexity)
	% for i = [1:n],
	%	k = 2;	% Position where new id will be inserted
	%	for j = [1:m],
	%		if (X(j, i) != -1), % Since -1 goes in 'other' category
	%			if (findElement(X(j, i), featureMapping(i, :)) == -1)	% If not already added 
	%				featureMapping(i, k) = X(j, i);
	%				k += 1;
	%				featureMapping(i, 1) += 1;
	%			end;
	%		end;
	%	end;
	% end;
	
	% Populate featureMapping (Faster Implementation) O(m.n) (More space complexity)
	for i = [1:n],
		max_i = max(X(:, i));	% Max value of any id in feature i
		counts_i = zeros(max_i);	% Count of all ids in feature i
		
		for j = [1:m],
			if (X(j, i) != -1)	% Since -1 goes in 'other' category
				counts_i(X(j, i)) += 1;
			end;
		end;
		
		% Remove those ids whose counts were 0, all these are in 'other' category
		non_zero_ids = [];
		for j = [1:max_i],
			if (counts_i(j) != 0)
				non_zero_ids = [non_zero_ids j];
			end;
		end;
		
		% Copy non zero ids to featureMapping
		featureMapping(i, 1) = size(non_zero_ids, 2);
		for j = [2:1 + size(non_zero_ids, 2)],
			featureMapping(i, j) = non_zero_ids(j - 1);
		end;
	end;
end;
