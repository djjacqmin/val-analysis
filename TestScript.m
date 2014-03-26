close all;
clear all;

FieldSize = [ 2 2  ]; % cm
%FieldSize = [ 10 10 3 3  ]; % cm
Depth = 10; % cm
MU = 200;

% Location of cross profiles
x_offset = 0;
y_offset = 0;

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\01 - Symmetric Fields\\Mapcheck\\%dx%d_%dcm_%dMU.txt',FieldSize(1),FieldSize(2),Depth,MU);
%filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\02 - Asymmetric Fields\\Mapcheck\\%d_%d_%d_%d_%dcm_%dMU.txt',FieldSize(1),FieldSize(2),FieldSize(3),FieldSize(4),Depth,MU);
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\05 - MLC Fields\\Mapcheck\\MLC_BarTest_%dcm_%dMU.txt',Depth,MU);
 
[ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
%[ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset, y_offset);
[ X_m, Y_m, x_offsetile_m, y_offsetile_m ] = getCrossProfilesAndShifts(X_m, Y_m, D_m, x_offset, y_offset);

filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\01 - Symmetric Fields\\Planar Dose\\%dx%d_%dcm_%dMU',FieldSize(1),FieldSize(2),Depth,MU);
%filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\02 - Asymmetric Fields\\Planar Dose\\%d_%d_%d_%d_%dcm_%dMU',FieldSize(1),FieldSize(2),FieldSize(3),FieldSize(4),Depth,MU);
% filename = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\1 - Open Field\\05 - MLC Fields\\Planar Dose\\MLC_BarTest_%dcm_%dMU',Depth,MU);

[ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
D_p = MU*D_p;
%[ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset, y_offset);
[ X_p, Y_p, x_offsetile_p, y_offsetile_p ] = getCrossProfilesAndShifts(X_p, Y_p, D_p, x_offset, y_offset);

% Increase resolution via interpolation
n = 5;
[r, c] = size(D_p);
X_n = X_p(1) + ((X_p(2)-X_p(1))/n)*((1:(c-2+(c-1)*(n-1))));
Y_n = Y_p(1) + ((Y_p(2)-Y_p(1))/n)*((1:(r-2+(r-1)*(n-1))));

[XX,YY] = meshgrid(X_n,Y_n);
D_n = interp2(X_p, Y_p, D_p, XX, YY);


%loadOmniProMLCProfiles;

%% Gamma map

Xr = X_n;
Yr = Y_n;
Dr = D_n;
Xe = X_m;
Ye = Y_m;
De = D_m;
dtaThreshold = 0.2; % cm
ddThreshold = 0.02; % fraction of maximum dose
searchRange = 1; % cm
doseDiffExclude = 0.0; % cGy
pctDoseExclude = 0.05; % fraction of maximum dose

dd = doseDifference(Xr,Yr,Dr,Xe,Ye,De);
[ x_dd, y_dd] = getCrossProfiles(X_m, Y_m, dd, x_offset, y_offset);

[ g, gs, gc, gp ] = gammaAnalysis(Xr,Yr,Dr,Xe,Ye,De,ddThreshold,dtaThreshold,searchRange,doseDiffExclude,pctDoseExclude);
[ x_gamma, y_gamma] = getCrossProfiles(X_m, Y_m, g, x_offset, y_offset);

x_gs = zeros(size(x_gamma));
for i=1:length(x_gs)
    if (x_gamma(i) > 1 && x_dd(i) > 0 ), x_gs(i) = 1;
    elseif (x_gamma(i) > 1 && x_dd(i) < 0 ), x_gs(i) = -1;
    end
end
y_gs = zeros(size(y_gamma));
for i=1:length(y_gs)
    if (y_gamma(i) > 1 && y_dd(i) > 0), y_gs(i) = 1;
    elseif (y_gamma(i) > 1 && y_dd(i) < 0), y_gs(i) = -1;
    end
end

fig = figure(2);

% Make a color map
upperLim = ceil(2*max(max(g)))/2;
clims = [ 0 ceil(2*max(max(g)))/2 ]; 
%clims = [ -1 1 ];
imagesc(Ye,Xe,g,clims); 
xlabel('X [cm]');
ylabel('Y [cm]');
title(sprintf('Gamma passing rate: %d of %d (%.1f%%)',gp,gc,gp/gc*100));
gammaColorMap = getGammaColormap(upperLim);
colorbar; colormap(gammaColorMap);


%% Plots
figure(1);
subplot(2,1,1);
hold on
circle_size = 5;
plot(X_m, x_offsetile_m,'ko','MarkerSize',circle_size);
plot(X_p, x_offsetile_p,'k-');
for i = 1:length(X_m)
    if (x_gs(i) == 1)
        plot(X_m(i), x_offsetile_m(i),'ko','MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',circle_size);
    elseif  (x_gs(i) == -1)
        plot(X_m(i), x_offsetile_m(i),'ko','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',circle_size);
    else
        plot(X_m(i), x_offsetile_m(i),'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',circle_size);
    end
end
hold off;
title(sprintf('Crossline Profile at Y = %.1f cm',y_offset));
xlabel('X [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck2','Pinnacle3');

subplot(2,1,2);
hold on
plot(Y_m, y_offsetile_m,'ko','MarkerSize',circle_size);
plot(Y_p, y_offsetile_p,'k-');
for i = 1:length(Y_m)
    if (y_gs(i) == 1)
        plot(Y_m(i), y_offsetile_m(i),'ko','MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',circle_size);
    elseif  (y_gs(i) == -1)
        plot(Y_m(i), y_offsetile_m(i),'ko','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',circle_size);
    else
        plot(Y_m(i), y_offsetile_m(i),'ko','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',circle_size);
    end
end
hold off;
title(sprintf('Inline Profile at X = %.1f cm',x_offset));
xlabel('Y [cm]');
ylabel('Absolute Dose [cCy]');
legend('Mapcheck2','Pinnacle3');
