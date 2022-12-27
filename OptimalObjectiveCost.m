function counterOfNegative = OptimalObjectiveCost(Costs)
    counterOfNegative = [];
    for i = 1: length(Costs)
        if Costs(i) < 0
            counterOfNegative(end+1) = i;
        end
    end
end