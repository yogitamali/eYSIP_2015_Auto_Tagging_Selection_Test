
Implmentation of Sparse Neural Network for determining correct question tags, given data about performance of students.


Input:

1. Training Data Matrix
	1.1. Denoted by X
	1.2. Size (m x n)
	1.3. m = Number of Training Examples
	1.4. n = Number of Questions
	1.5. It contains information about performance of m students on n questions
		1.5.1. Performance measure may be as simple as (0/1) for correct/incorrect solution or some other complex function of other variables (Eg. time taken to solve the question etc.)
		1.5.2. Only contraint on performance measure is that it should lie in the interval [0, 1]
	1.6. Training data can be obtained from the training data generator
	
2. [optional] Keys
	2.1. Obtained from training data generator
	2.2. Contains correct question labels (can be used for comparison)
	2.3. It is not used directly in the code
	
	
Output:

1. Estimated Performance Matrix
	1.1. Denoted by y
	1.2. Size (m x n)
	1.3. Contains information about estimated performance of m students on n questions
		1.3.1. Performance measure may represent estimated solvability of the questions
		1.3.2. It may also represent some other performance measure same as input
	1.4. Each output value is contained in the range [0, 1]

2. [optional] Estimated Question Tags
	2.1. Based on expected values of estimated performance from y
	2.2. Obtained by performing clustering on expected values
	2.3. Can be used to suggest correction to original question tags.


Suggested Modifications:

1. Try changing the value of lambda in main.m
2. Try changing num_hidden_units in main.m
3. Use a smarter initialization of weight matrix.
4. Using a better optimization function. [fmincg() is being used currently]	
	
	
Why not calculate probability of solving a question directly from training data?

1. Students might make a guess.
2. Network first aims at estimating the correct performance values.
3. Using these values the true difficulty level of questions can be described more accurately.


How will the network help?

1. In real life training data, performance on various questions is correlated.
2. Neural Network finds and exploits these correlation detect guesses and silly mistakes.
3. While the current training data generator can not detect such correlated questions, real data will usually be correlated.


Caution:
For large datasets, this network converges to almost the same values as those obtained using simple probabilities. Hence for large datasets, calculation of simple expectations will avoid unnecessary overhead.
While this is true for synthetic datasets, in a real dataset there are stronger correlations and hence the network is expected to perform in a more intelligent manner as compared to simple expectation calculation.
Analysis of performance of network on a real dataset is still pending.

