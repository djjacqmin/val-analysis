function [ X, Y, D ] = mapcheckTOmatOldFormat(filename)
% function mapcheckTOmat(filename)
% 	reads the output file <filename> from Mapcheck2 and 
%   creates variables containing the dose grid and dimensions
%
%   By Dustin Jacqmin, Medical University of South Carolina


fid = fopen(filename,'r');
C = textscan(fid, repmat('%s',1,26+26+3), 'delimiter','\t', 'CollectOutput',true);
C = C{1};

X = zeros(1,51);
Y = zeros(1,65);
D = zeros(65,51);

for yy = 1:65
    for xx = 1:53
        
        X(xx) = str2double(cell2mat(C(638,2+xx)));
        Y(yy) = str2double(cell2mat(C(571+yy,1)));
        D(yy,xx) = str2double(cell2mat(C(571+yy,2+xx)));
        
    end
end
