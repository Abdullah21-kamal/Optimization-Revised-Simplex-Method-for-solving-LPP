function listOFBasic = BasicLocations(C)
    listOFBasic = [];
    for i = 1: length(C)
        if C(i) == 0
            listOFBasic(end+1) = i;
        end
    end
    %disp(listOFBasic);
end
