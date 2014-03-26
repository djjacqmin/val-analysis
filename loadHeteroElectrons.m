close all;
clear all;

relative = 1;
FieldSize = [ 15 15 ]; % cm
MU = 400;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

FilterRad = 10; 

BG_Dose = 0;

%%

% Load Heterogeneous Electrons
% Middle of Heterogeneity

Film_MU = 400;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_12e_Hetero_2pHo2_400MU_322_281.mat';
[ R, C, D ] = RITfileTOmat(filename,322,281);
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
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21eX91_12e_Hetero_2pHo2_400MU');

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
title(sprintf('12e Heterogeneous Phantom at X = %.1f cm, Middle of Heterogeneity',x_offset));
xlabel('Y [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('12e Heterogeneous Phantom at Y = %.1f cm, Middle of Heterogeneity',y_offset));
xlabel('X [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');

%%

% Load Heterogeneous 
% 1 cm deep to heterogeneity

Film_MU = 400;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_12e_Hetero_2pHp1_400MU_318_281.mat';
[ R, C, D ] = RITfileTOmat(filename,312,281);
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
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21eX91_12e_Hetero_2pHp1_400MU');

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
title(sprintf('12e Heterogeneous Phantom at X = %.1f cm, 1 cm Deep to Heterogeneity',x_offset));
xlabel('Y [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('16x Heterogeneous Phantom at Y = %.1f cm, 1 cm Deep to Heterogeneity',y_offset));
xlabel('X [cm]');
if (relative == 1), ylabel('Relative Dose [%]'); else ylabel('Absolute Dose [cGy]'); end
legend('Pinnacle3','Film');
