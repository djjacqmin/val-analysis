function [ x_centered, y_centered, x_profile, y_profile ] = getCrossProfilesAndShifts(X, Y, D, xx, yy)
% function getCrossProfiles(X, Y, D)
% 	returns cross profiles from dose matrix <D> at location x = <xx> and y
% 	= <yy>
%
%   By Dustin Jacqmin PhD, Medical University of South Carolina

x_profile = interp2(X,Y,D,X,yy);
y_profile = interp2(X,Y,D,xx,Y);

% Find indices near profile intersection
ind_x = floor((1/(X(2)-X(1)))*(xx-X(1)))+1;
ind_y = floor((1/(Y(1)-Y(2)))*(Y(1)-yy))+1;

dref = D(ind_y,ind_x);


%% x-profile
% Find left half-maximum location for x

target = [ dref/4 dref/2 3*dref/4 ];
x_left = zeros(size(target));
x_right = zeros(size(target));

for t = 1:length(target)
    
    i_s = ind_x;

    while ( D(ind_y, i_s) > target(t) )
        i_s = i_s - 1;
    end

    % We've found the first index below 50% We can interpolate to find a left
    % x location

    x_left(t) = X(i_s) + (X(i_s+1) - X(i_s))*( ( target(t) - D(ind_y, i_s) ) / ( D(ind_y, i_s+1) - D(ind_y, i_s) ) );

    % Find right half-maximum location for x

    i_s = ind_x;

    while ( D(ind_y, i_s) > target(t) )
        i_s = i_s + 1;
    end

    % We've found the first index below 50% We can interpolate to find a left
    % x location

    x_right(t) = X(i_s-1) + (X(i_s) - X(i_s-1))*( ( target(t) - D(ind_y, i_s-1) ) / ( D(ind_y, i_s) - D(ind_y, i_s-1) ) );
    
end

% Compute the x-shift and new coordinates
x_shift = mean((x_right - xx) + (x_left - xx))/2;
x_centered = X - x_shift;

%% y-profile
% Find left half-maximum location for y

target = [ dref/4 dref/2 3*dref/4 ];
y_left = zeros(size(target));
y_right = zeros(size(target));

for t = 1:length(target)
    
    i_s = ind_y;

    while ( D(i_s, ind_x) > target(t) )
        i_s = i_s - 1;
    end

    % We've found the first index below 50% We can interpolate to find a left
    % x location

    y_left(t) = Y(i_s) + (Y(i_s+1) - Y(i_s))*( ( target(t) - D(i_s, ind_x) ) / ( D(i_s+1, ind_x) - D(i_s, ind_x) ) );

    % Find right half-maximum location for y

    i_s = ind_y;

    while ( D(i_s, ind_x) > target(t) )
        i_s = i_s + 1;
    end

    % We've found the first index below 50% We can interpolate to find a left
    % x location

    y_right(t) = Y(i_s-1) + (Y(i_s) - Y(i_s-1))*( ( target(t) - D(i_s-1, ind_x) ) / ( D(i_s, ind_x) - D(i_s-1, ind_x) ) );
    
end

% Compute the y-shift and new coordinates
y_shift = mean((y_right - yy) + (y_left - yy))/2;
y_centered = Y - y_shift; % minus sign - Y runs backward
