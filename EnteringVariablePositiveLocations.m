function counterOfPositive = EnteringVariablePositiveLocations(Costs)
    counterOfPositive = [];
    for i = 1: length(Costs)
        if Costs(i) > 0
            counterOfPositive(end+1) = i;
        end
    end
end