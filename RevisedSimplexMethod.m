function [OptimalVariablsValues, ObjectiveFunctionOptimumValue, iteration] = RevisedSimplexMethod(A,b,c)
    % XB is the final values for the variables 
    % From XB we will know the optimal values needed to make
    % the objective function optimum also
    XB = zeros(length(c),1);
    
    % I need to know the location of Basic variable to fill the tableau
    % I use the function BasicLocations to find them it takes the
    % coefficients of the objective function and any variable = 0 in the 
    % first iteration is a basic for that iteration
    Basic_Locations = [];
    Basic_Locations = BasicLocations(c);
    
    % Create the initial Basis matrix, compute its inverse and    
    % compute the inital basic feasible solution
    %-----------------------------------------
    %Basic  |  B inverse | Xb
    %that is the shape I am using 
    
    % coefficient mar
    B=A(:,Basic_Locations);
    B_inverse = inv(B);
    XB(Basic_Locations) = B_inverse*b;


    % Iteration phase
    iteration = 0;
    while iteration < 15

        % Compute the vector of reduced costs c_r 

        c_B = c(Basic_Locations);         % Basic variable costs
        p = (c_B'*B_inverse)';   % Dual variables
        c_r = c' - p'*A;    % Vector of reduced costs

        % Check if the solution is optimal. If optimal, use 
        % 'return' to break from the function, e.g.

        %locations of any negative costs which I chose the most one to
        %determine the corresponding  entering variable
        
        NegativeCostsLocations = OptimalObjectiveCost(c_r);
        if (length(NegativeCostsLocations) == 0)
            
        %it enter if there are no negative costs and here we reached the
        %optimumm solution and there is no any improvement may happen
        
            ObjectiveFunctionOptimumValue = c'*XB;
            OptimalVariablsValues = XB;
            return;
        end
        
        % if there is any negative cost it will perform additional
        % iteration to improve the solution
        
        
        %selecting the entering variable
        entering_variable = NegativeCostsLocations(1);
        
        % as I mentioned in the report, I need to find the new shape of
        % the entering variable by multiplying it to the B inverse matrix
        
        new_entering_variable = B_inverse*A(:,entering_variable);

        %Variable Positive Locations by using the function of EnteringVariablePositiveLocations
        % to know if there is any positive values to choose the minimum
        % positive one to let the corresponding variable leaves the basic
        % set
        PositiveCostsLocations = EnteringVariablePositiveLocations(new_entering_variable);
        if (length(PositiveCostsLocations) == 0)
           % it enters here if it does not find any positive value in the
           % entering variable which means that I can not let any variable
           % in the basic set leaves the Basic set then I can not improve the solution
           
           ObjectiveFunctionOptimumValue = -inf;  % Optimal objective function cost = -inf
           OptimalVariablsValues = [];
           % at that situation it should terminate the iteration and end
           % the iteratation of improving the solution 
           return        
        end

        % the minimum postitiv ratio
        RatioColumn =  XB(Basic_Locations(PositiveCostsLocations))./new_entering_variable(PositiveCostsLocations);
        ChoosingMinmumProstiveValue = min(RatioColumn);

        L = find(XB(Basic_Locations)./new_entering_variable == ChoosingMinmumProstiveValue); % indices with ratio 

        % Select the leaving variable
        LeavingVariable = L(1);

        XB(Basic_Locations) = XB(Basic_Locations) - ChoosingMinmumProstiveValue*new_entering_variable;
        XB(entering_variable) = ChoosingMinmumProstiveValue;


        % forming the basic set by replacing the leaving variable with the
        % entering variable to start the following iteration

        Basic_Locations(LeavingVariable) = entering_variable;
        
        % I have to normalize the leaving row and to put zeros above and
        % below the identity by performing matrix operations learnt from
        % the linear algebra course before
        % after that I can forrmulate a new structure of B inverse matrix 
        % by concatiniating the entering column to B inverse matrix 

        new_tableau=horzcat(new_entering_variable, B_inverse);
        %disp(new_tableau)
        [rows columns]=size(new_tableau);
        if (ChoosingMinmumProstiveValue~=0)
            new_tableau(LeavingVariable,:)=new_tableau(LeavingVariable,:)/new_tableau(LeavingVariable,1);
        % the meaning of a variable is leaving the basic set is a
        % normalization of the corresponding variable in the XB column and
        % divide the whole row with that value
        end
        % after normalization of the leaving row, I should put zeros above
        % and below that row by subtaracting a multiple of it from other
        % rows to formulate the new tableau
        for i = 1:rows % For all matrix rows
           if (i ~= LeavingVariable) 
               % I skip the normalized row just to subtract from the above
               % and below rows
               new_tableau(i,:)=new_tableau(i,:)-new_tableau(i,1)*new_tableau(LeavingVariable,:);
               % that result in the new tableau after subtracting the
               % multiple of the normalized to get zeros above and below
        end
        end
        B_inverse=new_tableau(1:3,2:end);
        iteration = iteration + 1;
    end
    if iteration > 15
        disp('Max number of iterations performed!');
    end
    return
end  
