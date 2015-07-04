
function predict(trainingX, trainingY, testX, testY, theta),
	
	% Predicts the value of trainingY and testY given trainingX and testX
	% respectively by using parameters theta.
	% Displays the mean sum of square error for both training and test set
	% trainingX = (m x n)
	% trainingY = (m x 1)
	% testX = (p x n)
	% testY = (p x 1)
	% theta = (n+1 x 1)
	% m = Number of training examples
	% n = Number of Features
	% p = Number of test examples
	
	m = size(trainingX, 1);
	p = size(testX, 1);
	
	trainingX = [ones(m, 1) trainingX];	% Add bias
	testX = [ones(p, 1) testX];	% Add bias
	
	
	% Calculate training error	
	fprintf("\nEstimating Training Error...\n");
	predictedTrainingY = trainingX * theta;
	trainingError = sum((predictedTrainingY - trainingY).^2)...
					 / (2 * m);
	fprintf("Training Error: %f\n", trainingError);
	
	
	% Calculate test error	
	fprintf("\nEstimating Test Error...\n");
	predictedTestY = testX * theta;
	testError = sum((predictedTestY - testY).^2)...
					 / (2 * p);
	fprintf("Test Error: %f\n", testError);	

end;
