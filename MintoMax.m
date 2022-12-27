function newC = MintoMax(C)
    newC = []
    for i = 1: length(C)
        newC(end+1) = -1 * C(i); 
    end
end