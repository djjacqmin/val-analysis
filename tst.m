close all;

Linac = 'Dustin 21eX 91'; % 'V21EX91'; % 'Varian iX 703'; %   
Linac_Short =  'eX91DJJ';  % 'eX91'; % 'iX'; % 
Energy = '16 MV'; % '16 MV'; %
Energy_Short = '16x'; % '16x'; %

root = 'W:\\Private\\Physics\\21eX91 Validation - DJJ';
beamtype =  '1 - Open Field Photons'; % '2 - 60-Degree Wedge Photons'; %  '2 - 60-Degree Wedge Photons'; % '2 - Wedged Field\\';
fieldtype = '01 - Symmetric Fields';

% Does the filename include the LINAC_ENERGY_ designation at the front?
filename_long_m = 0;
filename_long_p = 0;

auto_center_m = 0; % Mapcheck
auto_center_p = 0; % Pinnacle3

FS_X = 10;
FS_Y = 10;
D = 7;
MU = 200;

% Open Pinnacle3 Data and Compute Profiles
if ( filename_long_p == 1 )
    filename = sprintf('%s\\%s\\%s\\Planar Dose\\%s_%s_%dx%d_%dcm_%dMU',root,beamtype,fieldtype,Linac_Short,Energy_Short,FS_X,FS_Y,D,MU);
else
    filename = sprintf('%s\\%s\\%s\\Planar Dose\\%dx%d_%dcm_%dMU',root,beamtype,fieldtype,FS_X,FS_Y,D,MU);
end
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 

pngname = sprintf('%s\\Thumbnails\\%s_%s_%s_%s_%dx%d_%dcm_%dMU',root,Linac_Short,Energy_Short,regexprep(beamtype,'[^\w'']',''),regexprep(fieldtype,'[^\w'']',''),FS_X,FS_Y,D,MU);


figure(1)
plot([ 1 2 ], [ 1 2 ]);
plot(1:length(X_p), floor(length(X_p)/2)*ones(1,length(X_p)),floor(length(Y_p)/2)*ones(1,length(Y_p)),1:length(Y_p));
set(gca,'position',[0 0 1.05 1],'units','inches')
axis off

