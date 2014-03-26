close all;
clear all;

% Load Oblique Pinnacle Doses
% 5 cm depth
FieldSize = [ 10 10 ]; % cm
Depth = 5; % cm
MU = 300;
angle = 30;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

Film_MU = 300;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_Oblique_30deg_300MU_353_274.mat';
[ R, C, D ] = RITfileTOmat(filename,353,274);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - 3;

% Filter the film
c = 10;
H = fspecial('average',[c c]);
D_f = imfilter(D_f,H);

d_norm = interp2(X_f, Y_f, D_f, x_offset, y_offset);
D_f = D_f / d_norm * 100;

[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);

%rif = imagesc(X_f,Y_f,D_f);
%set(gca,'YDir','normal')
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21ex91_16x_%ddeg_%dMU',angle,MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
%D_p = MU*D_p;

d_norm = interp2(X_p, Y_p, D_p, x_offset, y_offset);
D_p = D_p / d_norm * 100;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_30 = figure(...
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
title(sprintf('16x Oblique Incidence (%d degrees) at X = %.1f cm and %.1f cm Depth',angle,x_offset, Depth));
xlabel('Y [cm]');
ylabel('Relative Dose [%]');
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('16x Oblique Incidence (%d degrees) at Y = %.1f cm and %.1f cm Depth',angle,y_offset, Depth));
xlabel('X [cm]');
ylabel('Relative Dose [%]');
legend('Pinnacle3','Film');

%%


% Load Oblique Pinnacle Doses
% 5 cm depth
FieldSize = [ 10 10 ]; % cm
Depth = 5; % cm
MU = 300;
angle = 60;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

Film_MU = 300;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_Oblique_60deg_300MU_367_288.mat';
[ R, C, D ] = RITfileTOmat(filename,367,288);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - 3;

% Filter the film
c = 10;
H = fspecial('average',[c c]);
D_f = imfilter(D_f,H);

d_norm = interp2(X_f, Y_f, D_f, x_offset, y_offset);
D_f = D_f / d_norm * 100;

[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);

%rif = imagesc(X_f,Y_f,D_f);
%set(gca,'YDir','normal')
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21ex91_16x_%ddeg_%dMU',angle,MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
%D_p = MU*D_p;

d_norm = interp2(X_p, Y_p, D_p, x_offset, y_offset);
D_p = D_p / d_norm * 100;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_60 = figure(...
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
title(sprintf('16x Oblique Incidence (%d degrees) at X = %.1f cm and %.1f cm Depth',angle,x_offset, Depth));
xlabel('Y [cm]');
ylabel('Relative Dose [%]');
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('16x Oblique Incidence (%d degrees) at Y = %.1f cm and %.1f cm Depth',angle,y_offset, Depth));
xlabel('X [cm]');
ylabel('Relative Dose [%]');
legend('Pinnacle3','Film');

%%


% Load Oblique Pinnacle Doses
% 5 cm depth
FieldSize = [ 10 10 ]; % cm
Depth = 5; % cm
MU = 300;
angle = 45;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

Film_MU = 300;
filename = 'W:\Private\Physics\21eX91 Validation - DJJ\Film Data for Validation - DJJ\ExportMAT\21eX91_16x_Oblique_45deg_300MU_367_288.mat';
[ R, C, D ] = RITfileTOmat(filename,367,288);
D = MU/Film_MU*D;
% Rows are X, Cols are Y.
% (1,1) corresponds to largest X and Y. Therefore:
X_f = -R;
Y_f = -C;

% Zero the Film
D_f = D' - 3;

% Filter the film
c = 10;
H = fspecial('average',[c c]);
D_f = imfilter(D_f,H);

d_norm = interp2(X_f, Y_f, D_f, x_offset, y_offset);
D_f = D_f / d_norm * 100;

[ x_offsetile_f, y_offsetile_f ] = getCrossProfiles(X_f, Y_f, D_f, x_offset, y_offset);

%rif = imagesc(X_f,Y_f,D_f);
%set(gca,'YDir','normal')
 
filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Film Data for Validation - DJJ\\Planar Doses\\21ex91_16x_%ddeg_%dMU',angle,MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
%D_p = MU*D_p;

d_norm = interp2(X_p, Y_p, D_p, x_offset, y_offset);
D_p = D_p / d_norm * 100;

[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);

fig_45 = figure(...
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
title(sprintf('16x Oblique Incidence (%d degrees) at X = %.1f cm and %.1f cm Depth',angle,x_offset, Depth));
xlabel('Y [cm]');
ylabel('Relative Dose [%]');
legend('Pinnacle3','Film');

subplot(2,1,2);
hold on;
plot(X_p, x_offsetile_p, X_f, x_offsetile_f );
hold off;
title(sprintf('16x Oblique Incidence (%d degrees) at Y = %.1f cm and %.1f cm Depth',angle,y_offset, Depth));
xlabel('X [cm]');
ylabel('Relative Dose [%]');
legend('Pinnacle3','Film');

