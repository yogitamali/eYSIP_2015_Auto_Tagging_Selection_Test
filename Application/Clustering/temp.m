
% Temporary Script

load('KMeansLabels');
plotData(XReduce, kmeans_labels .+ 1, m);

centroids

disagreements = (kmeans_labels != labels);
disagreement_percentage = sum(disagreements(:)) * 100 / m

a = [];
for i = [1:m],
	if (disagreements(i) == 1),
		a = [a; i];
	end;
end;

idx = randperm(size(a, 1))(1:3);

for i = [1:3],
	f1 = X(a(idx(i)), 1);
	f2 = X(a(idx(i)), 2);
	f3 = X(a(idx(i)), 3);
	k2_output = kmeans_labels(a(idx(i)));
	current_output = labels(a(idx(i)));
	fprintf("%f\t%f\t%f\t%d\t%d\n", f1, f2, f3, k2_output, current_output);
end;


