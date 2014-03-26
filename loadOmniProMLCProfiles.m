% This file takes absolute output measurements and uses them to turn
% relative profiles to absolute profiles.

close all;
clear all;

%% Raw Data

% Static Field Output Measurements
nC_per_MU_CC04_Open_10x10_5cm = 2.061/200;
nC_per_MU_CC04_Open_10x10_10cm = 1.678/200;
% nC_per_MU_CC04_Open_4x4_5cm = 1.916/200;
% nC_per_MU_CC04_Open_4x4_10cm = 1.521/200;

nC_per_MU_Edge_Open_10x10_5cm = 69.3626/200;
nC_per_MU_Edge_Open_10x10_10cm = 56.3739/200;
%nC_per_MU_Edge_Open_4x4_5cm = 64.514/200;
%nC_per_MU_Edge_Open_4x4_10cm = 51.0596/200;

% Bar Test Output Measurements
nC_per_MU_CC04_BarTest_5cm = 1.907/200;
nC_per_MU_CC04_BarTest_10cm = 1.527/200;
nC_per_MU_Edge_BarTest_5cm = 64.9407/200;
nC_per_MU_Edge_BarTest_10cm = 51.893/200;

% Strip Test Data
X_StripTest = [ -6.825	-5.775	-4.725	-3.675	-2.625	-1.575	-0.525	0.525	1.575	2.625	3.675	4.725	5.775	6.825 ];
nC_per_MU_CC04_StripTest_5cm = [ 0.0351	0.1138	0.7785	0.8163	0.748	0.6651	0.5783	0.4919	0.4146	0.3397	0.2532	0.171	0.0369	0.0196 ]/400;
nC_per_MU_Edge_StripTest_5cm = -[ -1.049	-2.886	-25.757	-26.929	-24.557	-21.72	-18.845	-16.194	-13.606	-10.985	-8.205	-5.453	-0.988	-0.543 ]/400;

%% Calculation of nC/MU to Dose/MU conversion

Output_16x_10x10_3cm = 1; % cGy/MU

PDD_16x_10x10_5cm = .9455; % cGy/MU
Output_16x_10x10_5cm = Output_16x_10x10_3cm*PDD_16x_10x10_5cm;

PDD_16x_10x10_10cm = .7697; % cGy/MU
Output_16x_10x10_10cm = Output_16x_10x10_3cm*PDD_16x_10x10_10cm;

dose_per_nC_CC04_5cm = Output_16x_10x10_5cm/nC_per_MU_CC04_Open_10x10_5cm;
dose_per_nC_CC04_10cm = Output_16x_10x10_10cm/nC_per_MU_CC04_Open_10x10_10cm;

dose_per_nC_CC04 = (dose_per_nC_CC04_5cm + dose_per_nC_CC04_10cm)/2; % cGy/nC

dose_per_nC_Edge_5cm = Output_16x_10x10_5cm/nC_per_MU_Edge_Open_10x10_5cm;
dose_per_nC_Edge_10cm = Output_16x_10x10_10cm/nC_per_MU_Edge_Open_10x10_10cm;

dose_per_nC_Edge = (dose_per_nC_Edge_5cm + dose_per_nC_Edge_10cm)/2; % cGy/nC

%% Conversion of Quantities to Dose

MU_Open = 200;
MU_BarTest = 200;
MU_StripTest = 400;

% Open field 10x10
dose_CC04_Open_10x10_5cm_CAX = nC_per_MU_CC04_Open_10x10_5cm*dose_per_nC_CC04*MU_Open;
dose_CC04_Open_10x10_10cm_CAX = nC_per_MU_CC04_Open_10x10_10cm*dose_per_nC_CC04*MU_Open;

dose_Edge_Open_10x10_5cm_CAX = nC_per_MU_Edge_Open_10x10_5cm*dose_per_nC_Edge*MU_Open;
dose_Edge_Open_10x10_10cm_CAX = nC_per_MU_Edge_Open_10x10_10cm*dose_per_nC_Edge*MU_Open;

% Open field 20x20
PDD_16x_20x20_5cm = .9398;
PDD_16x_20x20_10cm = .7771;
Total_Scatter_Factor_20x20 = 1.052;

dose_CC04_Open_20x20_5cm_CAX = dose_CC04_Open_10x10_5cm_CAX*(PDD_16x_20x20_5cm/PDD_16x_10x10_5cm)*Total_Scatter_Factor_20x20;
dose_CC04_Open_20x20_10cm_CAX = dose_CC04_Open_10x10_10cm_CAX*(PDD_16x_20x20_10cm/PDD_16x_10x10_10cm)*Total_Scatter_Factor_20x20;

dose_Edge_Open_20x20_5cm_CAX = dose_Edge_Open_10x10_5cm_CAX*(PDD_16x_20x20_5cm/PDD_16x_10x10_5cm)*Total_Scatter_Factor_20x20;
dose_Edge_Open_20x20_10cm_CAX = dose_Edge_Open_10x10_10cm_CAX*(PDD_16x_20x20_10cm/PDD_16x_10x10_10cm)*Total_Scatter_Factor_20x20;

% Bar Test
dose_CC04_BarTest_5cm_CAX = nC_per_MU_CC04_BarTest_5cm*dose_per_nC_CC04*MU_BarTest;
dose_CC04_BarTest_10cm_CAX = nC_per_MU_CC04_BarTest_10cm*dose_per_nC_CC04*MU_BarTest;

dose_Edge_BarTest_5cm_CAX = nC_per_MU_Edge_BarTest_5cm*dose_per_nC_Edge*MU_BarTest;
dose_Edge_BarTest_10cm_CAX = nC_per_MU_Edge_BarTest_10cm*dose_per_nC_Edge*MU_BarTest;

% Strip Test
dose_CC04_StripTest_5cm = nC_per_MU_CC04_StripTest_5cm*dose_per_nC_CC04*MU_StripTest;
dose_Edge_StripTest_5cm = nC_per_MU_Edge_StripTest_5cm*dose_per_nC_Edge*MU_StripTest;


%% Loading OmniPro Data

CC04_Struct = omniproAccessTOmat('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\OmniPro Data\\omniproAccess_16x_10x10_20x20_MLC_BarTest_CC04.ASC');
Edge_Struct = omniproAccessTOmat('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\OmniPro Data\\omniproAccess_16x_10x10_20x20_MLC_BarTest_Edge.ASC');

CC04_Original = omniproAccessTOmat('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\OmniPro Data\\P16_Open.ASC');
CC04_Struct = CC04_Original;
%% CC04 

% 10 x 10

% CC04, 10x10, 5 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[100 100],50,'X');
X_CC04_Open_10x10_5cm = x/10;
dose_CC04_Open_10x10_5cm_X = dose_CC04_Open_10x10_5cm_CAX/100*d;

% CC04, 10x10, 5 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[100 100],50,'Y');
Y_CC04_Open_10x10_5cm = y/10;
dose_CC04_Open_10x10_5cm_Y = dose_CC04_Open_10x10_5cm_CAX/100*d;

% CC04, 10x10, 10 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[100 100],100,'X');
X_CC04_Open_10x10_10cm = x/10;
dose_CC04_Open_10x10_10cm_X = dose_CC04_Open_10x10_10cm_CAX/100*d;

% CC04, 20x20, 10 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[100 100],100,'Y');
Y_CC04_Open_10x10_10cm = y/10;
dose_CC04_Open_10x10_10cm_Y = dose_CC04_Open_10x10_10cm_CAX/100*d;

% 20 x 20

% CC04, 20x20, 5 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[200 200],50,'X');
X_CC04_Open_20x20_5cm = x/10;
dose_CC04_Open_20x20_5cm_X = dose_CC04_Open_20x20_5cm_CAX/100*d;

% CC04, 20x20, 5 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[200 200],50,'Y');
Y_CC04_Open_20x20_5cm = y/10;
dose_CC04_Open_20x20_5cm_Y = dose_CC04_Open_20x20_5cm_CAX/100*d;

% CC04, 10x10, 10 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[200 200],100,'X');
X_CC04_Open_20x20_10cm = x/10;
dose_CC04_Open_20x20_10cm_X = dose_CC04_Open_20x20_10cm_CAX/100*d;

% CC04, 20x20, 10 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[200 200],100,'Y');
Y_CC04_Open_20x20_10cm = y/10;
dose_CC04_Open_20x20_10cm_Y = dose_CC04_Open_20x20_10cm_CAX/100*d;

% Bar Test

% CC04, 20x10, 5 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[100 200],50,'Y');
Y_CC04_BarTest_5cm = y/10;
dose_CC04_BarTest_5cm_Y = dose_CC04_BarTest_5cm_CAX/100*d;

% CC04, 20x10, 10 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(CC04_Struct,'OPP',[100 200],100,'Y');
Y_CC04_BarTest_10cm = y/10;
dose_CC04_BarTest_10cm_Y = dose_CC04_BarTest_10cm_CAX/100*d;

%% Edge

% 10 x 10

% Edge, 10x10, 5 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[100 100],50,'X');
X_Edge_Open_10x10_5cm = x/10;
dose_Edge_Open_10x10_5cm_X = dose_Edge_Open_10x10_5cm_CAX/100*d;

% Edge, 10x10, 5 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[100 100],50,'Y');
Y_Edge_Open_10x10_5cm = y/10;
dose_Edge_Open_10x10_5cm_Y = dose_Edge_Open_10x10_5cm_CAX/100*d;

% Edge, 10x10, 10 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[100 100],100,'X');
X_Edge_Open_10x10_10cm = x/10;
dose_Edge_Open_10x10_10cm_X = dose_Edge_Open_10x10_10cm_CAX/100*d;

% Edge, 20x20, 10 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[100 100],100,'Y');
Y_Edge_Open_10x10_10cm = y/10;
dose_Edge_Open_10x10_10cm_Y = dose_Edge_Open_10x10_10cm_CAX/100*d;

% 20 x 20

% Edge, 20x20, 5 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[200 200],50,'X');
X_Edge_Open_20x20_5cm = x/10;
dose_Edge_Open_20x20_5cm_X = dose_Edge_Open_20x20_5cm_CAX/100*d;

% Edge, 20x20, 5 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[200 200],50,'Y');
Y_Edge_Open_20x20_5cm = y/10;
dose_Edge_Open_20x20_5cm_Y = dose_Edge_Open_20x20_5cm_CAX/100*d;

% Edge, 10x10, 10 cm depth, crossline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[200 200],100,'X');
X_Edge_Open_20x20_10cm = x/10;
dose_Edge_Open_20x20_10cm_X = dose_Edge_Open_20x20_10cm_CAX/100*d;

% Edge, 20x20, 10 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[200 200],100,'Y');
Y_Edge_Open_20x20_10cm = y/10;
dose_Edge_Open_20x20_10cm_Y = dose_Edge_Open_20x20_10cm_CAX/100*d;

% Bar Test

% Edge, 20x10, 5 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[100 200],50,'Y');
Y_Edge_BarTest_5cm = y/10;
dose_Edge_BarTest_5cm_Y = dose_Edge_BarTest_5cm_CAX/100*d;

% Edge, 20x10, 10 cm depth, inline profile
[x, y, z, d] = getOmniproAccessData(Edge_Struct,'OPP',[100 200],100,'Y');
Y_Edge_BarTest_10cm = y/10;
dose_Edge_BarTest_10cm_Y = dose_Edge_BarTest_10cm_CAX/100*d;

%% Bar Test

% 5 cm depth
FieldSize = [ 10 20 ]; % cm
Depth = 5; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;


filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\MLC_BarTest_%dcm_%dMU_100SSD.txt',Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.05;


% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\01 - Symmetric Fields\\Planar Dose\\%dx%d_%dcm_%dMU',FieldSize(1),FieldSize(2),Depth,MU);
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\MLC_BarTest_%dcm_%dMU_100SSD',Depth,MU);
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p14\\Planar Dose\\MLC_BarTest_%dcm_100SSD_%dMU',Depth,MU);


[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_bartest = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_BarTest_5cm, dose_CC04_BarTest_5cm_Y, Y_Edge_BarTest_5cm, dose_Edge_BarTest_5cm_Y);
hold off;
title(sprintf('Bar Test Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

% 10 cm depth
FieldSize = [ 10 20 ]; % cm
Depth = 10; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\MLC_BarTest_%dcm_%dMU_100SSD.txt',Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\01 - Symmetric Fields\\Planar Dose\\%dx%d_%dcm_%dMU',FieldSize(1),FieldSize(2),Depth,MU);
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\MLC_BarTest_%dcm_%dMU_100SSD',Depth,MU);
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p14\\Planar Dose\\MLC_BarTest_%dcm_100SSD_%dMU',Depth,MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);


subplot(2,1,2);
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_BarTest_10cm, dose_CC04_BarTest_10cm_Y, Y_Edge_BarTest_10cm, dose_Edge_BarTest_10cm_Y);
hold off;
title(sprintf('Bar Test Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

%% 10x10

% 5 cm depth
FieldSize = [ 10 10 ]; % cm
Depth = 5; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\%dx%d_%dcm_%dMU_100SSD.txt',FieldSize(1),FieldSize(2),Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\%dx%d_%dcm_%dMU_100SSD',FieldSize(1),FieldSize(2),Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_10x10_5 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_Open_10x10_5cm, dose_CC04_Open_10x10_5cm_Y, Y_Edge_Open_10x10_5cm, dose_Edge_Open_10x10_5cm_Y);
title(sprintf('10x10 Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
hold off;
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

subplot(2,1,2);
hold on;
plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(X_p, x_offsetile_p, X_CC04_Open_10x10_5cm, dose_CC04_Open_10x10_5cm_X, X_Edge_Open_10x10_5cm, dose_Edge_Open_10x10_5cm_X);
title(sprintf('10x10 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

Depth = 10;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\%dx%d_%dcm_%dMU_100SSD.txt',FieldSize(1),FieldSize(2),Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\%dx%d_%dcm_%dMU_100SSD',FieldSize(1),FieldSize(2),Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_10x10_10 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_Open_10x10_10cm, dose_CC04_Open_10x10_10cm_Y, Y_Edge_Open_10x10_10cm, dose_Edge_Open_10x10_10cm_Y);
title(sprintf('10x10 Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

subplot(2,1,2);
hold on;
plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(X_p, x_offsetile_p, X_CC04_Open_10x10_10cm, dose_CC04_Open_10x10_10cm_X, X_Edge_Open_10x10_10cm, dose_Edge_Open_10x10_10cm_X);
title(sprintf('10x10 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

fig_10x10_10_2 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 4 4],...
        'PaperSize',[4 4],...
        'Units','inches',...
        'Position',[0 0 4 4]);
    
    hold on;
plot(Y_m, y_offsetile_m*.998,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_Open_10x10_10cm, dose_CC04_Open_10x10_10cm_Y,'r');
title(sprintf('10x10 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
axis([-10 10 0 160])
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

%% 20x20

% 5 cm depth
FieldSize = [ 20 20 ]; % cm
Depth = 5; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\%dx%d_%dcm_%dMU_100SSD.txt',FieldSize(1),FieldSize(2),Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\%dx%d_%dcm_%dMU_100SSD',FieldSize(1),FieldSize(2),Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_20x20_5 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_Open_20x20_5cm, dose_CC04_Open_20x20_5cm_Y, Y_Edge_Open_20x20_5cm, dose_Edge_Open_20x20_5cm_Y);
hold off;
title(sprintf('20x20 Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

subplot(2,1,2);
hold on;
plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(X_p, x_offsetile_p, X_CC04_Open_20x20_5cm, dose_CC04_Open_20x20_5cm_X, X_Edge_Open_20x20_5cm, dose_Edge_Open_20x20_5cm_X);
hold off;
title(sprintf('20x20 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

Depth = 10;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\%dx%d_%dcm_%dMU_100SSD.txt',FieldSize(1),FieldSize(2),Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\%dx%d_%dcm_%dMU_100SSD',FieldSize(1),FieldSize(2),Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_20x20_10 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_Open_20x20_10cm, dose_CC04_Open_20x20_10cm_Y, Y_Edge_Open_20x20_10cm, dose_Edge_Open_20x20_10cm_Y);
hold off;
title(sprintf('20x20 Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

subplot(2,1,2);
hold on;
plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);

plot(X_p, x_offsetile_p,'b');
plot(X_CC04_Open_20x20_10cm, dose_CC04_Open_20x20_10cm_X,'g');
plot(X_Edge_Open_20x20_10cm, dose_Edge_Open_20x20_10cm_X,'r');
hold on;
title(sprintf('20x20 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');


%% 20x20

% 5 cm depth
FieldSize = [ 20 20 ]; % cm
Depth = 5; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\%dx%d_%dcm_%dMU_100SSD.txt',FieldSize(1),FieldSize(2),Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\%dx%d_%dcm_%dMU_100SSD',FieldSize(1),FieldSize(2),Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_20x20_5 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
figure(1)
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_p, y_offsetile_p, Y_CC04_Open_20x20_5cm, dose_CC04_Open_20x20_5cm_Y, Y_Edge_Open_20x20_5cm, dose_Edge_Open_20x20_5cm_Y);
hold off;
title(sprintf('20x20 Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

figure(2)
hold on;
plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(X_p, x_offsetile_p, X_CC04_Open_20x20_5cm, dose_CC04_Open_20x20_5cm_X, X_Edge_Open_20x20_5cm, dose_Edge_Open_20x20_5cm_X);
hold off;
title(sprintf('20x20 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Pinnacle3','Water Tank - CC04','Water Tank - Edge');

Depth = 10;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\%dx%d_%dcm_%dMU_100SSD.txt',FieldSize(1),FieldSize(2),Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m - 0.1;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Planar Doses\\%dx%d_%dcm_%dMU_100SSD',FieldSize(1),FieldSize(2),Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_20x20_10 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
figure(3)
hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_CC04_Open_20x20_10cm, dose_CC04_Open_20x20_10cm_Y);
hold off;
title(sprintf('20x20 Inline Profile at X = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Water Tank - CC04');
figure(4)
hold on;
plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);

plot(X_CC04_Open_20x20_10cm, dose_CC04_Open_20x20_10cm_X,'k');
hold on;
title(sprintf('20x20 Crossline Profile at Y = %.1f cm and %.1f cm Depth',x_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck','Water Tank - CC04');

%% Strip Test

% 5 cm depth
Depth = 5; % cm
MU = 400;

% Location of cross profiles
x_offset = 0;
y_offset = 0.25;

Film_MU = 800;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_StripTest_05cm_800MU_370_291.mat';
[ R, C, D ] = RITfileTOmat(filename,370,291);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - 3;
[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);
[ x_offsetile_fo, y_offsetile_fo ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset+.25);

% rif = imagesc(X_f,Y_f,D_f);
% set(gca,'YDir','normal')

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\MLC_StripTest_%dcm_%dMU_100SSD.txt',Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
[ x_offsetile_mo, y_offsetile_mo ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset+.25);

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p010\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Old\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_po, Y_po, D_po ] = pinnacleTOmat(filename); 
D_po = MU*D_po;

[ x_offsetile_po, y_offsetile_po ] = getCrossProfiles(X_po, Y_po, D_po, x_offset, y_offset+.25);


fig_striptest = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
hold on;
plot(-X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
%plot(X_m, x_offsetile_mo,'ko','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',5);
%plot(X_p, x_offsetile_p,'-k',X_p, x_offsetile_po,'-m', X_StripTest, dose_CC04_StripTest_5cm, 'ro', X_StripTest, dose_Edge_StripTest_5cm, 'bo',X_f, x_offsetile_f,'-g',X_f, x_offsetile_fo,'-c');
plot(-X_StripTest, dose_CC04_StripTest_5cm, 'ro', -X_StripTest, dose_Edge_StripTest_5cm, 'bo',-X_f, x_offsetile_f,':b');
plot(-X_p, x_offsetile_p,'-k','LineWidth',2);
plot(-X_p, x_offsetile_po,'--k');
hold off;
title(sprintf('MLC Strip Test Crossline Profile at Y = %.2f cm and %.1f cm Depth',y_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
axis([-7.5 7.5 0 90]);
%legend('Mapcheck: .25 cm Offset','Mapcheck: 0.5 cm Offset','Pinnacle3 0.25 cm Offset','Pinnacle3 0.5 cm Offset','Water Tank - CC04','Water Tank - Edge','Film 0.25 cm Offset','Film 0.5 cm Offset');
legend('Mapcheck2','Water Tank - CC04','Water Tank - Edge','Radiochromic Film','New Pinnacle3 TPS','Old Pinnacle3 TPS');


%% Strip Test Interleaf Leakage

fig_striptest2 = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);

% 5 cm depth
Depth = 5; % cm
MU = 400;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

Film_MU = 800;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_StripTest_05cm_800MU_370_291.mat';
[ R, C, D ] = RITfileTOmat(filename,370,291);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - 3;
[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);

% rif = imagesc(X_f,Y_f,D_f);
% set(gca,'YDir','normal')

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\MATLAB\\Mapcheck\\MLC_StripTest_%dcm_%dMU_100SSD.txt',Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, 0);

hold on;

% Plot For 0.005 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p005\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');

% Plot For 0.008 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p008\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');

% Plot For 0.01 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p010\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');

% Plot For 0.012 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p012\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-b');

% Plot For 0.014 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p014\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-m');

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

% Plot For 0.016 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p016\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-b');

% Plot For 0.020 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p020\\Planar Dose\\MLC_StripTest_%dcm_100SSD_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-m');

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
plot(Y_f, y_offsetile_f,'-g'); 
hold off;
title(sprintf('MLC Strip Test Crossline Profile at Y = %.2f cm and %.1f cm Depth',y_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('0.005','0.008','0.010','0.012','0.014','0.016','0.020','Mapcheck','Film');