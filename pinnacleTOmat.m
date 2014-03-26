function [ dx, dy, dg ] = pinnacleTOmat(name)
% function pinnacleTOmat(name)
% 	reads the output file <name> from pinnacle and 
%   creates variables containing the dose grid and dimensions
%
%   By Dustin Jacqmin, Medical University of South Carolina

wasudf = 0;
if nargin == 0;
    wasudf = 1;
    name = 'W:\Private\Physics\Linac QA\RapidArc QA\04 - Matrixx Evolution Patient QA\Angle Correction Tests\Pinnacle ADAC Ascii\20x20_fields\V_180_I_0_20x20_200MU';
end
%fprintf('%s\n',name);
fid = fopen(name,'r');

% Skip 12 lines
for i=1:11
    line = fgetl(fid);
end

line = fgetl(fid);
[si ei xt mt] = regexp(line, '(-\d*\.\d*|\d*\.\d*)'); 
dx = str2double(mt);
num_cols = length(dx);

u = fscanf(fid,'%f,');
num_rows = length(u)/(num_cols+1);
v = reshape(u,num_cols+1,num_rows)'; 

dy = v(:,1);
dg = v(:,2:num_cols+1);

dy = -dy;

fclose(fid);
