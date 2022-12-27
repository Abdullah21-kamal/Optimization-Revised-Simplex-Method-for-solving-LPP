% matrices and vectors in the standard form:
% the user should enter like that given example
% A martix is the Coefficients of the constraints
% b is the right hand part of these Coefficients
% A martix is the Coefficients of the Objective function

%A = [2 1 -1 1 0 0;2 -1 5 0 1 0;4 1 1 0 0 1];
%b = [2 6 6]';
%c = [1 2 1 0 0 0]';
                       % the initial basic feasible solution
A = input('Enter matrix A: ');
b = input('Enter vector of b: ');
c = input('Enter vector of c: ');
typeofLP = input('Enter   1   Maximziation or   2     minimization: ');
disp('-----------------------Solution---------------------------------')

if typeofLP == 1
    c = MintoMax(c)
    [OptimalVariablsValues, ObjectiveFunctionOptimumValue, iteration]= RevisedSimplexMethod(A,b',c');
    disp('number of iteratios needed to obtain the optimum is')
    disp(iteration+1)
    disp('X vlaues for the optimum solution')
    disp(OptimalVariablsValues)
    disp('the value of the optimum = ')
    disp(-1*ObjectiveFunctionOptimumValue)
    
else
    [OptimalVariablsValues, ObjectiveFunctionOptimumValue, iteration]= RevisedSimplexMethod(A,b',c');
    disp('number of iteratios needed to obtain the optimum is')
    disp(iteration+1)
    disp('X vlaues for the optimum solution')
    disp(OptimalVariablsValues)
    disp('the value of the optimum = ')
    disp(ObjectiveFunctionOptimumValue)
    
    
end