
##############################################################################
# @author = 'Shubham Gupta'                                                  #
# Class implementing the basic Training Setup.                               #
##############################################################################

import random

class TrainingSetup:

    def __init__(self, numQuestions):
        """
            __init__(TrainingSetupm, int) -> None
        """
        self.student = {'Good':0.1, 'Medium':0.8, 'Poor':1.0}	# 0.1 Probability of getting a Good Student
								# 0.7 -> 0.8 - 0.1 -> For getting a Medium Student
								# 0.2 -> 1.0 - 0.8 -> For getting a Poor Student

		# self.solvability = 3x3 Matrix where (i, j)th entry represents
		# the probability that student type i will solve question type j        
        self.solvability = {'Good':{'Hard':0.55, 'Medium':0.75, 'Easy':0.95},\
        	               'Medium':{'Hard':0.25, 'Medium':0.5, 'Easy':0.75},\
        	               'Poor':{'Hard':0.05, 'Medium':0.25, 'Easy':0.45}}

        self.labels = {'Easy':0.3, 'Medium':0.7, 'Hard':1.0} 	# 0.3 Chance of getting easy question
								# 0.4 Chance of getting medium level question
								# 0.3 chance of getting hard question

        self.questionLabels = []	# correct question tags
        self.numQuestions = numQuestions
        self.assignLabels()



    def assignLabels(self):
        """
            assignLabels(TrainingSetup) -> None
        """
        for i in range(self.numQuestions):
            r = random.random()	# Randomly assign a tag
            if r <= self.labels['Easy']:
                self.questionLabels.append('Easy')
            elif r <= self.labels['Medium']:
                self.questionLabels.append('Medium')
            else:
                self.questionLabels.append('Hard')
        

    def getNumQuestions(self):
        """
            getNumQuestions(TrainingSetup) -> int
        """
        return self.numQuestions

    
    def getStudentType(self):
        """
            getStudentType(TrainingSetup) -> str
        """
        r = random.random()  # Randomly assign a student type
        if (r <= self.student['Good']):
            return 'Good'
        elif (r <= self.student['Medium']):
            return 'Medium'
        else:
            return 'Poor'

    def getSolvability(self, studentType, questionType):
        """
            getSolvability(TrainingSetup, str, str) -> 0 or 1
        """
        r = random.random()	# Return 1 if question was solved correctly, 0 otherwise
        if (r <= self.solvability[studentType][questionType]):	# Compare with standard solvability of this group
            return 1
        return 0

    def getQuestionLabel(self, i):
        """
            getQuestionLabel(TrainingSetup, int) -> str
        """
        return self.questionLabels[i - 1]

    def writeLabels(self):
        """
            writeLabels(TrainingSetup, file) -> None
        """
        f = open('key.txt', 'w')
        
        for i in self.questionLabels:
            f.write(str(i))
            f.write('\n')
        
        f.close()
