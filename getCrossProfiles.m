function [ x_profile, y_profile ] = getCrossProfiles(X, Y, D, xx, yy)
% function getCrossProfiles(X, Y, D)
% 	returns cross profiles from dose matrix <D> at location x = <xx> and y
% 	= <yy>
%
%   By Dustin Jacqmin PhD, Medical University of South Carolina

x_profile = interp2(X,Y,D,X,yy);
y_profile = interp2(X,Y,D,xx,Y);
