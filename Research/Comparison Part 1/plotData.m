
function plotData(X, y, m)
	
	% Plots the data represented by feature matrix X colored according
	% to label vector y.
	% X should have 2 columns
	% y must be a column vector
	% X and y must have same number of rows
	% m = Number of training examples in X
	
	% Set plotting options
	options = {"r.", "g.", "b.", "c.", "k.", "m.", "rx", "gx", "bx", "cx"};
	
	% Set number of distinct question labels
	labels = 3;	% This value must be less than or equal to 10
	
	% Initialize all the categories
	categories = {};
	for i = [1:labels],
		categories{i} = [];
	end;
	
	% Segregate X based on labels
	for i = [1:m],
		categories{y(i)} = [categories{y(i)}; X(i, :)];
	end;
	
	% Plot the data
	figure;
	hold on;
	
	for i = [1:labels],
		plot(categories{i}(:, 1), categories{i}(:, 2), options{i});
	end;
		
	xlabel("Mean Normalized Feature 2");
	ylabel("Mean Normalized Feature 7");
	legend("Easy", "Medium", "Hard", "location", "southeast");
	hold off;
	
end;
