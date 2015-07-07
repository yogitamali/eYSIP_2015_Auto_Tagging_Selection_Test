
function output = predict(testX, testY, phi, probabilities, featureMapping)
	
	% Predicts the output based on a feed forward pass	
	m = size(testX, 1);
	n = size(testX, 2);
	num_classes = size(phi, 1);
	output = zeros(size(testX, 1), 1);	
	weighted_output = zeros(size(testX, 1), num_classes);

	% Calculate P(X_i | y_i = k) * P(y_i = k) for all i and k
	for i = [1:m],
		for k = [1:num_classes],
			weighted_output(i, k) = phi(k);
			for j = [1:n],
				idx = 1;
				max_idx = featureMapping(j, 1);
				for l = [2:max_idx],
					if (featureMapping(j, l) == testX(i, j))
						idx = l;
						break;
					end;
				end;
				weighted_output(i, k) *= probabilities(j, l, k);
			end;
		end;
		fprintf("\rCompleted ... %d percent", round(i * 100/m));	
		fflush(stdout);	
	end;
	
	% Find arg-max
	[dummy, output] = max(weighted_output, [], 2);
	
	% Calculate Accuracy
	accuracy = sum((output(:, 1) == testY)(:)) * 100 / m;
	fprintf("\nAccuracy = %f\n", accuracy); 

end;
