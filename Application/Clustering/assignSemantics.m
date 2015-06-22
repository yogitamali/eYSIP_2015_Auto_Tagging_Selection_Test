
function [labels, map] = assignSemantics(centroids, current_labels),

	% Assigns Semantics to the Clustered Obtained based on sorting 
	% the semantic meaning of the features.
	% Edit this file to change the semantics of the features when 
	% new features are added.
	
	% Some Useful Variables
	numClusters = size(centroids, 1);
	numFeatures = size(centroids, 2);
	
	% Label Nomenclature
	hard_label = 2;
	medium_label = 1;
	easy_label = 0;
	
	% Polling will be used to assign meanings. For each feature in each
	% cluster we poll whether it is meant to be low, medium or high.
	% Once done with all the features, winning label is assigned to
	% each cluster.
	polls = zeros(numClusters, numFeatures);
	
	% Note that the data is mean normalized. Hence a negative value 
	% means less than average and a positive value means more than
	% average
	
	
	
	% For feature 1 - Fraction of people who did not attempt the given
	% question.
	% Expectation: Positive value for hard questions
	%			   Negative value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Easy < Medium < Hard
	
	order = arg_sort(centroids, 1);	% Sort based on Feature 1
	polls(order(1), 1) = easy_label;	% Lowest value is easy
	polls(order(2), 1) = medium_label;	% Medium value
	polls(order(3), 1) = hard_label; % Highest value is hard
	
	
	
	% For feature 2 - Fraction of people who solved the given question
	% correctly.
	% Expectation: Negative value for hard questions
	%			   Positive value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Hard < Medium < Easy
	
	order = arg_sort(centroids, 2);	% Sort based on Feature 2
	polls(order(1), 2) = hard_label;	% Lowest value is hard
	polls(order(2), 2) = medium_label;	% Medium value
	polls(order(3), 2) = easy_label; % Highest value is easy
	
	
	% For feature 3 - Fraction of people who solved the given question
	% incorrectly.
	% Expectation: Positive value for hard questions
	%			   Negative value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Easy < Medium < Hard
	
	order = arg_sort(centroids, 3);	% Sort based on Feature 3
	polls(order(1), 3) = easy_label;	% Lowest value is easy
	polls(order(2), 3) = medium_label;	% Medium value
	polls(order(3), 3) = hard_label; % Highest value is hard
	
	
	% For feature 4 - Average Marks of people who solved given question
	% correctly.
	% Expectation: Positive value for hard questions
	%			   Negative value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Easy < Medium < Hard
	
	order = arg_sort(centroids, 4);	% Sort based on Feature 4
	polls(order(1), 4) = easy_label;	% Lowest value is easy
	polls(order(2), 4) = medium_label;	% Medium value
	polls(order(3), 4) = hard_label; % Highest value is hard
	
	
	% For feature 5 - Average marks of people who solved given question
	% incorrectly.
	% Expectation: Positive value for hard questions
	%			   Negative value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Easy < Medium < Hard
	
	order = arg_sort(centroids, 5);	% Sort based on Feature 5
	polls(order(1), 5) = easy_label;	% Lowest value is easy
	polls(order(2), 5) = medium_label;	% Medium value
	polls(order(3), 5) = hard_label; % Highest value is hard
	
	
	% For feature 6 - Average marks of people who did not attempt the
	% given question.
	% Expectation: Positive value for hard questions
	%			   Negative value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Easy < Medium < Hard
	
	order = arg_sort(centroids, 6);	% Sort based on Feature 6
	polls(order(1), 6) = easy_label;	% Lowest value is easy
	polls(order(2), 6) = medium_label;	% Medium value
	polls(order(3), 6) = hard_label; % Highest value is hard
	
	
	% For feature 7 - Fraction of people in top 5 percentile who solved
	% the given question correctly.
	% Expectation: Negative value for hard questions
	%			   Positive value for easy questions
	%			   Values close to zero for medium level questions
	% Hence order expected: Hard < Medium < Easy
	
	order = arg_sort(centroids, 7);	% Sort based on Feature 7
	polls(order(1), 7) = hard_label;	% Lowest value is hard
	polls(order(2), 7) = medium_label;	% Medium value
	polls(order(3), 7) = easy_label; % Highest value is easy
	
	
	polls
	
	% Map the labels
	map = zeros(numClusters, 1);
	map(1) = mode(polls(1, :));	% Winning Label of Cluster 1
	map(2) = mode(polls(2, :));	% Winning Label of Cluster 2
	map(3) = mode(polls(3, :));	% Winning Label of Cluster 3
	
	% Now assign semantically correct labels
	m = size(current_labels, 1);
	for i = [1:m],
		labels(i, 1) = map(current_labels(i, 1));
	end;
end;
	
