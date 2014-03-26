function [ x_gamma, y_gamma , x_gs, y_gs ] = getGammaProfiles(X, Y, D, xx, yy)
% function getCrossProfiles(X, Y, D)
% 	returns cross profiles from dose matrix <D> at location x = <xx> and y
% 	= <yy>
%
%   By Dustin Jacqmin PhD, Medical University of South Carolina

x_gamma = interp2(X,Y,D,X,yy);
y_gamma = interp2(X,Y,D,xx,Y);

