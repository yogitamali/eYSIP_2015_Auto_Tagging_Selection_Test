
function matchAndSave(question_id, labels),

	% Aligns the output of weighted features with the output of 
	% k-means using simple features. Alignment is needed because
	% while using weighted features data is available for 1490 questions
	% whereas while using simple features the data is available for
	% 1489 questions.
	
	% This function must be called when main has finished executing.
	
	% Aligns the output and saves the aligned labels in 'WeightedLabels'
	% as 'weighted_labels'
	
	% Backup the current question_ids
	current_id = question_id;
	
	% Load question ids from simple k-means
	load('QID');	% Loaded in question_id
	
	% Perform matching, they only differ by 1 id
	weighted_labels = [];
	skip = 0;
	for i = [1:size(question_id, 1)],
		if (question_id(i) == current_id(i + skip))
			weighted_labels =  [weighted_labels; labels(i + skip)];
		else
			while (question_id(i) != current_id(i + skip))
				skip = skip + 1;
			end;
			weighted_labels = [weighted_labels; labels(i + skip)];
		end;
	end;
	
	% Save the labels
	save('WeightedLabels', 'weighted_labels');

end;
