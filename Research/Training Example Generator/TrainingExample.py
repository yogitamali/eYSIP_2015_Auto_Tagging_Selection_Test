
##############################################################################
# @author = 'Shubham Gupta'                                                  #
# Class implementing the generation of a Training Example.                   #
##############################################################################

import random
from TrainingSetup import *

class TrainingExample:
    
    def __init__(self, trainingSetup):
        """
            __init__(TrainingExample, TrainingSetup) -> None
        """
        self.trainingSetup = trainingSetup

    def generate(self):
        """
            generate(TrainingExample) -> List of 0 and 1 with Student type
            label appended at the end
        """
        studentType = self.trainingSetup.getStudentType()
        example = []

        for i in range(1,self.trainingSetup.getNumQuestions() + 1):
            example.append(self.trainingSetup.getSolvability(\
                studentType, self.trainingSetup.getQuestionLabel(i)))

        # example.append(studentType)
        return example

    def writeExample(self, fname):
        """
            writeExample(TrainingExample, file) -> None
        """
        example = self.generate()
        for item in example:
            fname.write(str(item))
            fname.write(' ')
        fname.write('\n')




def generateTrainingData(numQuestions, numExamples):
    """
        generateTrainingData(int) -> None
    """
    trainingSetup = TrainingSetup(numQuestions)
    trainingExample = TrainingExample(trainingSetup)

	# Write training data
    f = open('examples.txt', 'w')

    # Write as an octave matrix
    f.write('# name: X\n')
    f.write('# type: matrix\n')
    f.write('# rows: ' + str(numExamples) + '\n')
    f.write('# columns: ' + str(numQuestions) + '\n');
    
    for  i in range(numExamples):
        trainingExample.writeExample(f)

    f.close() 
       
    # Write the key for data set
    trainingSetup.writeLabels()
    
    # Write test data
    f = open('test.txt', 'w')
    f.write('# name: testd\n')
    f.write('# type: matrix\n')
    f.write('# rows: ' + str((int)(numExamples * 0.1) + 1) + '\n')
    f.write('# columns: ' + str(numQuestions) + '\n');
    
    numTests = (int)(numExamples * 0.1) + 1
    for  i in range(numTests):
        trainingExample.writeExample(f)
        
    f.close();
    

    
    
if (__name__ == '__main__'):
	print '\n\n'
	
	try:
		numExamples = int(raw_input('Enter Number of Examples to Generate: '))
		numQuestions = int(raw_input('Enter Number of Questions: '))
		print '\nGenerating...';
		generateTrainingData(numQuestions, numExamples)
	except:
		print 'Invalid Input'
		
	print 'Done!\n\n';
	
        
