
Usage: python TrainingExample.py

Output:
1. A file called 'examples.py' which can be read directly in octave as the training matrix X.
2. In octave use: load('examples.py')
3. Matrix X is (m x n) matrix where m is the number of training examples, and n is the number of questions.
4. Each training examples corresponds to the data about one student.

Purpose:
1. Generates Training Examples based on certain parameters
2. Training Examples are assumed to be binary strings where 1 denotes correct answer and 0 denotes incorrect answer.
3. Incorporates the fact that a student may guess an answer.
4. Generates the data about 3 types of students (Good, Medium and Poor) based on probabilistic distribution.
5. Categorizes Questions as Easy, Medium and Hard.
6. All these Parameters can be changed in TrainingExample.py by modifying the appropriate data.

Caution:
1. This does not correspond to the actual training data mainly because this makes an implicit assumption that data follows some particular probability distribution which may not be true in general.
2. This is a very simple model, containing only yes-no answers to correctness of solution given by the students, the actual dataset may contain other information too which can be used to improve the performance of learning algorithm.

Why not just calculate Expected value for each question to estimate difficulty level?
1. Students might have made a guess (which is a big problem for tests where there is no negative marking).
2. In such a scenario just taking the expected values will not give accurate information.


