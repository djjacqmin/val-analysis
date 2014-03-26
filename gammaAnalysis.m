function [ g, gs, gc, gp ] = gammaAnalysis(Xr,Yr,Dr,Xe,Ye,De,ddThreshold,dtaThreshold,searchRange,doseDiffExclude,pctDoseExclude)
%   function gamma = gammaAnalysis(Xr,Yr,Dr,Xe,Ye,De)
%   Performs gamma analysis on De (dose evaluation) relative to Dr (dose
%   reference). The gamma2d function used in this script expect the dose
%   matricies to be on a 1 mm grid and to be of the same size. Therefore,
%   this function performs some preprocessing of the matrices, a gamma
%   analysis, and some post processing to return a gamma map with the same
%   resolution as the original matrix.

% Assumptions:
%   * Xr, Yr, Xe, and Ye are in cm
%   * Xr, Yr, Xe, and Ye are symmetric about 0
%   * Element (1,1) of Dr, De is the most negative x value and the most
%   positive y value.

% Determine the number of voxels to search in each direction for each point
search_x = floor(searchRange/(Xr(2)-Xr(1)));
search_y = floor(searchRange/(Yr(1)-Yr(2)));

% Get the size of each dose grid
[rr, cr] = size(Dr);
[re, ce] = size(De);

% Pre-allocate gamma
g = zeros(size(De));
gs = zeros(size(De));
gc = 0;
gp = 0;

dmax = max(max(Dr));
ddThreshold = ddThreshold*dmax; % scale dosed as a percent of the maximum dose



% Loop over rows of De (y-axis)
for i=1:re
    
    % Are we inside of the Dr grid?
    % BTW, Y is a descending list!
    if Ye(i) < Yr(1) && Ye(i) > Yr(rr)
        
        % Loop over columns of De (x-axis)
        for j=1:ce
        
            % Are we inside of the Dr grid?
            if Xe(j) > Xr(1) && Xe(j) < Xr(cr)
                
                % Test for dose threshold
                if ( De(i,j)/dmax > pctDoseExclude )
                    
                    % Count this point
                    gc = gc + 1;
               
                    % Set gamma min to 10000
                    gamma_min = 10000;

                    % For (Xe(j),Ye(i)), find nearest indices in Xr, Yr
                    ind_x = floor((1/(Xr(2)-Xr(1)))*(Xe(j)-Xr(1)))+1;
                    ind_y = floor((1/(Yr(1)-Yr(2)))*(Yr(1)-Ye(i)))+1;
                    
                    % Test for dose difference threshold
                    if ( abs(Dr(ind_y,ind_x) - De(i,j)) > doseDiffExclude ) 

                        % Loop over subset of Dr in neighborhood of Xe(j),Ye(i)
                        for k = max(1,(ind_y-search_y)):min(rr,(ind_y+search_y))
                            for l = max(1,(ind_x-search_x)):min(cr,(ind_x+search_x))
                                r2 = ( Ye(i) - Yr(k) )^2 + ( Xe(j) - Xr(l) ) ^2 ; % distance (radius) squared
                                d2 = ( De( i , j ) - Dr( k , l ) )^2 ; % difference squared
                                this_G = sqrt(r2 / (dtaThreshold^2) + d2/ ddThreshold ^ 2);
                                if this_G < gamma_min, gamma_min = this_G; end
                            end
                        end
                        

                        if (gamma_min <= 1)
                            gp = gp + 1; 
                        elseif (  De(i,j) > interp2(Xr,Yr,Dr,Xe(j),Ye(i)) )
                            gs(i,j) = 1;
                        else
                            gs(i,j) = -1;
                        end

                        g(i,j) = gamma_min;
                        
                    end
                    
                end

                
            end % If inside Dr (x)
        end % loop over cols of De
    end % If inside Dr (y)
end % loop over rows of De

