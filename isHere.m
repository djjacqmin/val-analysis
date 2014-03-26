function tf = isHere(thisNumber, thisArray)

    for i = 1:length(thisArray)
        if thisNumber == thisArray(i)
            tf = 1;
            return;
        end
    end
    
    tf = 0;


end