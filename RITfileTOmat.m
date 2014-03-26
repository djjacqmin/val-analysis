function [ R, C, D ] = RITfileTOmat(filename,R0,C0)
% function RITfiletoMAT(filename)
% 	reads the output MAT-file <filename> from RIT and 
%   creates variables containing the dose grid and dimensions
%
%   By Dustin Jacqmin, Medical University of South Carolina


data = load(filename);
D = (data.im); 

[r,c] = size(D);

% Files, by default, are oriented with the upper-left corner in the X2,Y2
% direction. Therefore, the columes run from +Y to -Y and the rows run from
% +X to -X

R = 1:r;
C = 1:c;

% Scale for pixel size
R = R*data.ip.ps(1);
C = C*data.ip.ps(2);

% R0 and R0 are the location of 0, 0. Adjust R, C accordingly
R = R - R(R0);
C = C - C(C0);