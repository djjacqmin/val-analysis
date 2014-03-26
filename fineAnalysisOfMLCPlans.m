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

fig_bartest = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);

% 10 cm depth
FieldSize = [ 10 20 ]; % cm
Depth = 10; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field Photons\\05 - MLC Fields\\Mapcheck\\MLC_BarTest_%dcm_%dMU.txt',Depth,MU);
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
Y_m = Y_m + 0.1;

hold on;
plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);

% Plot Trans 1p00
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p00\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-b');

% Plot Trans 1p20
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p20\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-g');


% Plot Trans 1p40
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p40\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');


% Plot Trans 1p60
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p60\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-k');


% Plot Trans 1p80
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p80\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-b');


% Plot Trans 2p00
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 2p00\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-g');


% Plot Trans 2p20
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 2p20\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');


% Plot Trans 2p40
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 2p40\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-k');

% % Plot LR 6 cm
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 6 cm\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-b');
% 
% % Plot LR 8 cm
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 8 cm\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-g');
% 
% 
% %Plot LR 10 cm
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 10 cm\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-r');
% 
% 
% % Plot LR 12 cm
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 12 cm\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-k');
% 
% 
% % Plot LR 14 cm
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 14 cm\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-b');

% % Plot TG 0.06
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p06\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-b');
% 
% % Plot TG 0.08
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p08\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-g');
% 
% 
% % Plot TG 0.10
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p10\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-r');
% 
% 
% % Plot TG 0.12
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p12\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-k');
% 
% 
% % Plot TG 0.14
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\TG 0p14\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(Y_p, y_offsetile_p,'-b');

hold off;
title(sprintf('Bar Test Inline Profile at X = %.1f cm and %.1f cm Depth\nTesting Different MLC Transmission Values',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');    
legend('Mapcheck','T 1','T 1.2','T 1.4','T 1.6','T 1.8','T 2','T 2.2','T 2.4');
%legend('Mapcheck','LR 6','LR 8','LR 10','LR 12','LR 14');
%legend('Mapcheck','TG 0.06','TG 0.08','TG 0.10','TG 0.12','TG 0.14');


%% Strip Test - Leaf Radius

% 5 cm depth
Depth = 3; % cm
MU = 400;

% Location of cross profiles
x_offset = 0;
y_offset = -.5;

if (Depth == 3)
    filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field Photons\\05 - MLC Fields\\Mapcheck\\MLC_StripTest_%dcm_%dMU.txt',Depth,MU);
    [ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
    [ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, 0);
    [ x_offsetile_mo, y_offsetile_mo ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, -.5);
end
    
fig_striptest = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
hold on;
if (Depth == 3)
    plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
    plot(X_m, x_offsetile_mo,'ko','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',5);
end
%plot(X_StripTest, dose_CC04_StripTest_5cm, 'ro', X_StripTest, dose_Edge_StripTest_5cm, 'bo',X_f, x_offsetile_f,'-g');

% Plot For Leaf Radius of 16
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 14 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-g');

% Plot original
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 12 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-r');

% Plot For Leaf Radius of 18
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 10 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-b');

hold off;
title(sprintf('MLC Strip Test Crossline Profile at Y = %.2f cm and %.1f cm Depth\nTesting Different MLC Leaf Radius Values',y_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
if (Depth == 3)
    legend('Mapcheck: 0 cm Offset','Mapcheck: -0.5 cm Offset','P3 Leaf Radius 14 cm','P3 Leaf Radius 12 cm','P3 Leaf Radius 10 cm');
else
    legend('P3 Leaf Radius 14 cm','P3 Leaf Radius 12 cm','P3 Leaf Radius 8 cm');
end

%% Strip Test - Transmission

% 5 cm depth
Depth = 3; % cm
MU = 400;

% Location of cross profiles
x_offset = 0;
y_offset = -.0;

if (Depth == 3)
    filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field Photons\\05 - MLC Fields\\Mapcheck\\MLC_StripTest_%dcm_%dMU.txt',Depth,MU);
    [ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
    [ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, 0);
    [ x_offsetile_mo, y_offsetile_mo ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, -.5);
end
    
fig_striptest = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
hold on;
if (Depth == 3)
    plot(X_m, x_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
    plot(X_m, x_offsetile_mo,'ko','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',5);
end
%plot(X_StripTest, dose_CC04_StripTest_5cm, 'ro', X_StripTest, dose_Edge_StripTest_5cm, 'bo',X_f, x_offsetile_f,'-g');

% % Plot For 1.0% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p00\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-r');
% 
% % Plot For 1.2% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p20\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-b');
% 
% % Plot For 1.4% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p40\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-g');
% 
% % Plot For 1.6% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p60\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-r');
% 
% % Plot For 1.8% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 1p80\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-b');
% 
% % Plot For 2.0% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 2p00\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-g');
% 
% % Plot For 2.2% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 2p20\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-r');
% 
% % Plot For 2.4% Transmission
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\Trans 2p40\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
% [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
% D_p = MU*D_p;
% [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
% plot(X_p, x_offsetile_p,'-b');

% Plot For 6 cm Leaf Radius
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 6 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-r');

% Plot For 8 cm Leaf Radius
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 8 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-b');

% Plot For 10 cm Leaf Radius
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 10 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-g');

% Plot For 12 cm Leaf Radius
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 12 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-r');

% Plot For 14 cm Leaf Radius
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 14 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-b');

% Plot For 16 cm Leaf Radius
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\LR 16 cm\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(X_p, x_offsetile_p,'-g');


hold off;
title(sprintf('MLC Strip Test Crossline Profile at Y = %.2f cm and %.1f cm Depth\nTesting Different MLC Leaf Radius Values',y_offset, Depth));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
if (Depth == 3)
    legend('Mapcheck: 0 cm Offset','Mapcheck: -0.5 cm Offset','LR 6','LR 8','LR 10','LR 12','LR 14','LR 16');
else
        legend('LR 6','LR 8','LR 10','LR 12','LR 14','LR 16');
end

%% Strip Test - Additional Interleaf Leakage

Depth = 3; % cm
MU = 400;

% Location of cross profiles
x_offset = .5;
y_offset = 0;

if (Depth == 3)
    filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field Photons\\05 - MLC Fields\\Mapcheck\\MLC_StripTest_%dcm_%dMU.txt',Depth,MU);
    [ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
    [ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
end
    
fig_striptest = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
hold on;
if (Depth == 3)
    plot(Y_m, y_offsetile_m,'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',5);
end
%plot(X_StripTest, dose_CC04_StripTest_5cm, 'ro', X_StripTest, dose_Edge_StripTest_5cm, 'bo',X_f, x_offsetile_f,'-g');

% Plot For 0.008 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p008\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-g');

% Plot For 0.01 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p010\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');

% Plot For 0.012 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p012\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-b');

% Plot For 0.014 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p014\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-g');

% Plot For 0.016 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p016\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-r');

% Plot For 0.020 Additional Interleaf Leakage
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Alt MLC Models\\AILL 0p020\\Planar Dose\\MLC_StripTest_%dcm_%dMU',Depth,MU/2);
[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
plot(Y_p, y_offsetile_p,'-b');



hold off;
title(sprintf('MLC Strip Test Crossline Profile at X = %.2f cm and %.1f cm Depth\nTesting Different MLC Interleaf Leakages',x_offset, Depth));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
if (Depth == 3)
    legend('Mapcheck','0.008','0.010','0.012','0.014','0.016','0.020');
else
        legend('0.008','0.010','0.012','0.014','0.016','0.020');
end