
close all; clear; clc;

inputData = csvread('features.csv');
inputData = inputData(2:end, :);
question_id = inputData(:, 1);
X = inputData(:, 2:9);
y = inputData(:, 10);
m = size(X, 1);

% Mean Normalize
meanX = mean(X);
stdX = std(X);
X = (X .- meanX) ./ stdX;

% Decide Number of features to use
numFeatures = 2;
X = X(:, 1:numFeatures);

% Decide the Number of Components to use
numComponents = 2;
[U, S, V] = svd((X' * X) * (1 / m));
R = U(:, 1:numComponents);
Xreduce = X * R;

c0 = [];
c1 = [];
c2 = [];

for i = [1:m],
	if (y(i) == 0),
		c0 = [c0; Xreduce(i, :)];
	end;
	if (y(i) == 1),
		c1 = [c1; Xreduce(i, :)];
	end;
	if (y(i) == 2),
		c2 = [c2; Xreduce(i, :)];
	end;
end;


% Plot the data
figure;
plot(c0(:, 1), c0(:, 2), 'r.');
figure;
plot(c1(:, 1), c1(:, 2), 'b.');
figure;
plot(c2(:, 1), c2(:, 2), 'g.');
figure;
plot(c0(:, 1), c0(:, 2), 'r.', c1(:, 1), c1(:, 2), 'b.', c2(:, 1), c2(:, 2), 'g.');


% Perform Clustering
initialCentroids = [mean(c0); mean(c1); mean(c2)];
[centroids, idx] = runkMeans(Xreduce, initialCentroids, 10);

idx = idx .- 1;
c0 = [];
c1 = [];
c2 = [];
for i = [1:m],
	if (idx(i) == 0),
		c0 = [c0; Xreduce(i, :)];
	end;
	if (idx(i) == 1),
		c1 = [c1; Xreduce(i, :)];
	end;
	if (idx(i) == 2),
		c2 = [c2; Xreduce(i, :)];
	end;
end;

% Plot the data
figure;
plot(c0(:, 1), c0(:, 2), 'r.', c1(:, 1), c1(:, 2), 'b.', c2(:, 1), c2(:, 2), 'g.');


% Show Differences
sum(y == idx)


% Neural Network
% Xreduce = X;
%% Setup the parameters you will use for this exercise
input_layer_size  = numComponents;  
hidden_layer_size = floor((numComponents + 3) * (2/3.0));   
num_labels = 3;

% Initialize
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

options = optimset('MaxIter', 100);
lambda = 1;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, Xreduce, y .+ 1, lambda);

[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));


% Predict all values
p = predict(Theta1, Theta2, Xreduce);

sum(p == (y .+ 1))

c0 = [];
c1 = [];
c2 = [];
for i = [1:m],
	if (p(i) == 1),
		c0 = [c0; Xreduce(i, :)];
	end;
	if (p(i) == 2),
		c1 = [c1; Xreduce(i, :)];
	end;
	if (p(i) == 3),
		c2 = [c2; Xreduce(i, :)];
	end;
end;

% Plot the data
figure;
plot(c0(:, 1), c0(:, 2), 'r.', c1(:, 1), c1(:, 2), 'b.', c2(:, 1), c2(:, 2), 'g.');


pause;
close all;
clc;

