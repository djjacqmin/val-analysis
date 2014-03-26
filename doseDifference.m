function dd = doseDifference(Xr,Yr,Dr,Xe,Ye,De)

% Get the size of each dose grid
[rr, cr] = size(Dr);
[re, ce] = size(De);

% Pre-allocate dose differnce grid
dd = zeros(size(De));

% Loop over rows of De (y-axis)
for i=1:re
    
    % Are we inside of the Dr grid?
    % BTW, Y is a descending list!
    if Ye(i) < Yr(1) && Ye(i) > Yr(rr)
        
        % Loop over columns of De (x-axis)
        for j=1:ce
        
            % Are we inside of the Dr grid?
            if Xe(j) > Xr(1) && Xe(j) < Xr(cr)
                
                dd(i,j) = De(i,j) - interp2(Xr,Yr,Dr,Xe(j),Ye(i));
                
            end
        end
    end
end

