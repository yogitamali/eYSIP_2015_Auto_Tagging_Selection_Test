
function order = arg_sort(centroids, feature),

	% Sorts the centroids based on feature in a non decreasing order
	% and specifies the indices of sorted array in order in the order
	% variable
	
	[dummy, order] = sort(centroids(:, feature));

end;
	
