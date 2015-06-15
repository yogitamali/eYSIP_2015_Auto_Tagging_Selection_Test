function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

m = size(X, 1);

X = [ones(m, 1) X];

J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

newY = zeros(m, num_labels);
for i = [1:m],
	newY(i, y(i)) = 1;
end;

z1 = (X * Theta1');
a1 = sigmoid(z1);
a1 = [ones(m, 1) a1];
calculated_Answers = sigmoid(a1 * Theta2');

temp = -newY .* log(calculated_Answers) - ((ones(m, num_labels) - newY) .* log(ones(m, num_labels) - calculated_Answers));

theta1_new = Theta1(:, 2:size(Theta1, 2));
theta2_new = Theta2(:, 2:size(Theta2, 2));
thetas = [theta1_new(:); theta2_new(:)];
J = (sum(temp(:)) / m) + ( ( lambda / (2 * m) ) * sum(thetas.^2));

delta_3 = calculated_Answers - newY;
delta_2 = delta_3 * Theta2;
delta_2 = delta_2(:, 2:size(a1, 2));
delta_2 = delta_2 .* sigmoidGradient(z1);

temp2 = ((delta_3' * a1) / m);
fc1 = temp2(:, 1);
temp2 = temp2 + ((lambda / m) * Theta2);
temp2(:, 1) = fc1;
Theta2_grad = temp2;

temp1 = ((delta_2' * X) / m);
fc2 = temp1(:, 1);
temp1 = temp1 + ((lambda / m) * Theta1);
temp1(:, 1) = fc2;
Theta1_grad = temp1;

grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
