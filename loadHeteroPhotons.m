close all;
clear all;

relative = 0;
FieldSize = [ 10 10 ]; % cm
MU = 400;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

FilterRad = 10; 

BG_Dose = 5;

%%

% Load Heterogeneous
% 5 cm depth

Depth = 5; % cm

Film_MU = 400;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_Hetero_4pHp5_400MU_301_250.mat';
[ R, C, D ] = RITfileTOmat(filename,301,250);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - BG_Dose;

% Filter the film
H = fspecial('average',[FilterRad FilterRad]);
D_f = imfilter(D_f,H);

if (relative == 1)
    d_norm = interp2(X_f, Y_f, D_f, x_offset, y_offset);
    D_f = D_f / d_norm * 100;
end

[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);

%rif = imagesc(X_f,Y_f,D_f);
%set(gca,'YDir','normal')
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21eX91_16x_Hetero_4pHp5_%dMU',MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
%D_p = MU*D_p;

if (relative == 1)
    d_norm = interp2(X_p, Y_p, D_p, x_offset, y_offset);
    D_p = D_p / d_norm * 100;
end

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_5cm = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_p, y_offsetile_p, Y_f, y_offsetile_f );
hold off;
title(sprintf('16x Heterogeneous Phantom at X = %.1f cm and %.1f cm Deep to Heterogeneity',x_offset, Depth));
xlabel('Y [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('16x Heterogeneous Phantom at Y = %.1f cm, %.1f cm Deep to Heterogeneity',y_offset, Depth));
xlabel('X [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');

%%

% Load Heterogeneous 
% 10 cm depth
Depth = 10; % cm

Film_MU = 400;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_Hetero_4pHp10_400MU_328_265.mat';
[ R, C, D ] = RITfileTOmat(filename,328,265);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - BG_Dose;

H = fspecial('average',[FilterRad FilterRad]);
D_f = imfilter(D_f,H);

if (relative == 1)
    d_norm = interp2(X_f, Y_f, D_f, x_offset, y_offset);
    D_f = D_f / d_norm * 100;
end

[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);

%rif = imagesc(X_f,Y_f,D_f);
%set(gca,'YDir','normal')
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21eX91_16x_Hetero_4pHp10_%dMU',MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
%D_p = MU*D_p;

if (relative == 1)
    d_norm = interp2(X_p, Y_p, D_p, x_offset, y_offset);
    D_p = D_p / d_norm * 100;
end

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_10cm = figure(...
        'Visible','on',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
subplot(2,1,1);
hold on;
plot(Y_p, y_offsetile_p, Y_f, y_offsetile_f );
hold off;
title(sprintf('16x Heterogeneous Phantom at X = %.1f cm and %.1f cm Deep to Heterogeneity',x_offset, Depth));
xlabel('Y [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('16x Heterogeneous Phantom at Y = %.1f cm and %.1f cm Deep to Heterogeneity',y_offset, Depth));
xlabel('X [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');
