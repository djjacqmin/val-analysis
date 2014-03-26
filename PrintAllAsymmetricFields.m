close all;
clear all;

%% 

% Thumbnail Size
tsize = 2;

%%%% Information that will help us build a filename
FieldSize_X1 = [ 10 0 10 2 0 5 ]; % cm
FieldSize_X2 = [ 10 10 10 2 5 0 ]; % cm 
FieldSize_Y1 = [ 0 10 3 10 -5 -8 ]; % cm
FieldSize_Y2 = [ 10 10 3 10 10 18 ]; % cm 

% % % For Wedges
% FieldSize_X1 = [ 7.5 0 7.5 2 0 5 ]; % cm
% FieldSize_X2 = [ 7.5 7.5 7.5 2 5 0 ]; % cm 
% FieldSize_Y1 = [ 0 10 3 10 -5 -8 ]; % cm
% FieldSize_Y2 = [ 10 10 3 10 10 18 ]; % cm 

Depth = [ 3 7 10 15 ]; % cm
MU = 200;
Linac = 'Dustin 21eX 91'; % 'Varian iX 703';  %'V21EX91'; % 
Linac_Short = 'eX91DJJ'; % 'iX'; %  'eX91'; % 
Energy = '16 MV'; % '16 MV'; %
Energy_Short = '16x'; % '16x'; %

root = 'W:\\Private\\Physics\\21eX91 Validation - DJJ';
beamtype = '1 - Open Field Photons'; %'2 - 60-Degree Wedge Photons'; % 'Alt MLC Models'; %  
fieldtype = '02 - Asymmetric Fields'; % 'A 1'; %'01 - Symmetric Fields\\';

% Does the filename include the LINAC_ENERGY_ designation at the front?
filename_long_m = 0;
filename_long_p = 0;

%%% Analysis Parameters

device_m = 'Mapcheck 2';
device_p = 'Pinnacle3';

% Absolute (0) or relative (1). If relative, dose is normalized to dose at
% cross profile location
rel_analysis = 0; 

% Binary (1) or continuous (0) gamma map
binary_gamma = 0; 

% Automatically center profiles at cross-profile intersection? On (1) or off
% (0)
auto_center_m = 0; % Mapcheck
auto_center_p = 0; % Pinnacle3

% Cap gamma map color bar at this value
gamma_max_cap = 5;

% Location of cross profiles
x_offset = [ 0 5 0 0 2.5 -2.5 ];
y_offset = [ 5 0 0 0 7.5 13 ];

% Correction for Mapcheck Shift
x_shift = [ 0 0 0 0 0 0 ];
y_shift = [ 0 0 0 0 0 9.8 ];

% Gamma Analysis Parameters
dtaThreshold = 0.3; % Distance-to-agreement limit in cm
ddThreshold = 0.03; % Dose difference limit as a fraction of maximum dose
searchRange = 0.4; % Search range for gamma computation in cm
doseDiffExclude = 0.0; % Dose differences less than this are recorded as passing (in cGy)
pctDoseExclude = 0.05; % Doses less than this fraction of maximum dose are ignored.

Gamma_Map_Points = zeros(length(FieldSize_X1),length(Depth));
Gamma_Map_Passing_Points = zeros(length(FieldSize_X1),length(Depth));

% Postscript File and HTML File 

if (rel_analysis == 1), absrel = 'relative'; else absrel = 'absolute'; end
pdfname = sprintf('%s\\Report PDFs\\%s_%s_%s_%s_PrintOut.ps',root,Linac_Short,Energy_Short,regexprep(beamtype,'[^\w'']',''),regexprep(fieldtype,'[^\w'']',''));
delete(pdfname);
htmlname = sprintf('%s\\Report PDFs\\%s_%s_%s_%s_SummaryPage.html',root,Linac_Short,Energy_Short,regexprep(beamtype,'[^\w'']',''),regexprep(fieldtype,'[^\w'']',''));

%%
for f = 1:length(FieldSize_X1)

    fig_x_prof = figure(...
        'Visible','off',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);

    fig_y_prof = figure(...
        'Visible','off',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);

    fig_gamma = figure(...
        'Visible','off',...
        'PaperOrientation','landscape',...
        'PaperUnits','inches',...
        'PaperPosition',[0 0 11 8.5],...
        'PaperSize',[11 8.5],...
        'Units','inches',...
        'Position',[0 0 11 8.5]);
    
    for d = 1:length(Depth)
        
        FS_X1 = FieldSize_X1(f);
        FS_Y1 = FieldSize_Y1(f);
        FS_X2 = FieldSize_X2(f);
        FS_Y2 = FieldSize_Y2(f);

        D = Depth(d);
        
        % Construct field size string
        S_X1 =  num2str(FS_X1); 
        S_X2 =  num2str(FS_X1); 

        % Open Mapcheck Data and Compute Profiles
        
        if ( filename_long_m == 1 )
            filename = sprintf('%s\\%s\\%s\\Mapcheck\\%s_%s_%s_%s_%d_%d_%dcm_%dMU.txt',root,beamtype,fieldtype,Linac_Short,Energy_Short,num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,MU);
        else
            filename = sprintf('%s\\%s\\%s\\Mapcheck\\%s_%s_%d_%d_%dcm_%dMU.txt',root,beamtype,fieldtype,num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,MU);
        end
        [ X_m, Y_m, D_m ] = mapcheckTOmat(filename);
        if (rel_analysis == 1)
            d_norm = interp2(X_m, Y_m, D_m, x_offset(f), y_offset(f));
            D_m = D_m / d_norm * 100;
        end
        X_m = X_m + x_shift(f);
        Y_m = Y_m + y_shift(f);

        if (auto_center_m == 1)
            [ X_m, Y_m, x_offsetile_m, y_offsetile_m ] = getCrossProfilesAndShifts(X_m, Y_m, D_m, x_offset(f), y_offset(f));
        else
            [ x_offsetile_m, y_offsetile_m ] = getCrossProfiles(X_m, Y_m, D_m, x_offset(f), y_offset(f));
        end

        % Open Pinnacle3 Data and Compute Profiles
        if ( filename_long_p == 1 )
            filename = sprintf('%s\\%s\\%s\\Planar Dose\\%s_%s_%s_%s_%d_%d_%dcm_%dMU',root,beamtype,fieldtype,Linac_Short,Energy_Short,num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,MU);
        else
            filename = sprintf('%s\\%s\\%s\\Planar Dose\\%s_%s_%d_%d_%dcm_%dMU',root,beamtype,fieldtype,num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,MU);
        end
        [ X_p, Y_p, D_p ] = pinnacleTOmat(filename); 
        if (rel_analysis == 1)
            d_norm = interp2(X_p, Y_p, D_p, x_offset(f), y_offset(f));
            D_p = D_p / d_norm * 100;
        else
            D_p = MU*D_p;
        end
        
        if (auto_center_p == 1)
            [ X_p, Y_p, x_offsetile_p, y_offsetile_p ] = getCrossProfilesAndShifts(X_p, Y_p, D_p, x_offset(f), y_offset(f));
        else
            [ x_offsetile_p, y_offsetile_p ] = getCrossProfiles(X_p, Y_p, D_p, x_offset(f), y_offset(f));
        end

        % Increase Pinnacle dose grid resolution via interpolation
        n = 5; % Increase by a factor of n
        [r, c] = size(D_p);
        X_n = X_p(1) + ((X_p(2)-X_p(1))/n)*((1:(c-2+(c-1)*(n-1))));
        Y_n = Y_p(1) + ((Y_p(2)-Y_p(1))/n)*((1:(r-2+(r-1)*(n-1))));

        [XX,YY] = meshgrid(X_n,Y_n);
        D_n = interp2(X_p, Y_p, D_p, XX, YY);
        
        % Perform dose difference analysis
        dd = doseDifference(X_p,Y_p,D_p,X_m,Y_m,D_m);
        [ x_dd, y_dd ] = getCrossProfiles(X_m, Y_m, dd, x_offset(f), y_offset(f));
        
        % Perform gamma analysis using interpolated Pinnacle3 grid
        [ g, gs, gc, gp ] = gammaAnalysis(X_n,Y_n,D_n,X_m,Y_m,D_m,ddThreshold,dtaThreshold,searchRange,doseDiffExclude,pctDoseExclude);
        [ x_gamma, y_gamma ] = getCrossProfiles(X_m, Y_m, g, x_offset(f), y_offset(f));
        
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
        
        
        Gamma_Map_Points(f,d) = gc;
        Gamma_Map_Passing_Points(f,d) = gp;
        
        % Create x profiles
        figure(fig_x_prof);        
        subplot(2,2,d);
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
        title(sprintf('X1: %s X2: %s Y1: %d Y2: %d at %d cm Depth\nCrossline Profile at Y = %.1f cm',num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,y_offset(f)));
        xlabel('X [cm]');
        if (rel_analysis == 0), ylabel('Absolute Dose [cCy]'); else ylabel('Relative Dose [%]'); end
        legend('Mapcheck2','Pinnacle3','Location','Best');
        
        % Create y profiles
        figure(fig_y_prof);           
        subplot(2,2,d);
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
        title(sprintf('X1: %s X2: %s Y1: %d Y2: %d at %d cm Depth\nInline Profile at X = %.1f cm',num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,x_offset(f)));
        xlabel('Y [cm]');
        if (rel_analysis == 0), ylabel('Absolute Dose [cCy]'); else ylabel('Relative Dose [%]'); end
        legend('Mapcheck2','Pinnacle3','Location','Best');
        
        % Create Gamma Map
        figure(fig_gamma);
        if (binary_gamma == 1)
            subplot(2,2,d);
            clims = [ -1 1 ]; % For binary gamma map
            imagesc(X_m,Y_m,gs,clims);          
            xlabel('X [cm]');
            ylabel('Y [cm]');
            title(sprintf('X1: %s X2: %s Y1: %d Y2: %d at %d cm Depth\nGamma passing rate for %.0f%%/%.0fmm: %d of %d (%.1f%%)',num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,ddThreshold*100,dtaThreshold*10,gp,gc,gp/gc*100));
            colormap('jet');
            set(gca,'YDir','normal')
        else
            subplot(2,2,d);          
            upperBnd = ceil(2*max(max(g)))/2;
            upperBnd = 2; % Override
            if (upperBnd > gamma_max_cap), upperBnd = gamma_max_cap; end
            clims = [ 0 upperBnd ]; % For continuous gamma map
            gammaColorMap = getGammaColormap(upperBnd);
            imagesc(X_m,Y_m,g,clims);          
            xlabel('X [cm]');
            ylabel('Y [cm]');
            title(sprintf('X1: %s X2: %s Y1: %d Y2: %d at %d cm Depth\nGamma passing rate for %.0f%%/%.0fmm: %d of %d (%.1f%%)',num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,ddThreshold*100,dtaThreshold*10,gp,gc,gp/gc*100));
            colormap(gammaColorMap); colorbar;
            set(gca,'YDir','normal')
        end
        
        if (D == 10)

            pngname = sprintf('%s\\Thumbnails\\%s_%s_%s_%s_%s_%s_%d_%d_%dcm_%dMU',root,Linac_Short,Energy_Short,regexprep(beamtype,'[^\w'']',''),regexprep(fieldtype,'[^\w'']',''),num2str(FS_X1),num2str(FS_X2),FS_Y1,FS_Y2,D,MU);

            fig_thumbnail = figure('Visible','off'); %,'Units','inches','Position',[0 0 tsize tsize]);
            figure(fig_thumbnail)
            hold on;

            axis([ min(X_p) max(X_p) min(Y_p) max(Y_p) ]);
            imagesc(X_p,Y_p,D_p);
            plot(X_p, zeros(size(X_p)),'-w',zeros(size(Y_p)),Y_p,'-w');
            set(gca,'position',[0 0 1 1],'units','normalized')
            axis off
            hold off;
            print(fig_thumbnail,'-dpng',pngname);
            
        end
        
    end

%     pdfname = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Report PDFs\\%s\\%d.a_%dx%d_x_prof_%s.pdf',subfolder,f,FS,FS,absrel);
%     print(fig_x_prof,'-dpdf',pdfname);
%     pdfname = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Report PDFs\\%s\\%d.b_%dx%d_y_prof_%s.pdf',subfolder,f,FS,FS,absrel);
%     print(fig_y_prof,'-dpdf',pdfname);
%     pdfname = sprintf('W:\\Private\\Physics\\21eX91 Validation - DJJ\\Report PDFs\\%s\\%d.c_%dx%d_gamma_%s.pdf',subfolder,f,FS,FS,absrel);
%     print(fig_gamma,'-dpdf',pdfname);

    print(fig_x_prof,'-dpsc',pdfname,'-append');
    print(fig_y_prof,'-dpsc',pdfname,'-append');
    print(fig_gamma,'-dpsc',pdfname,'-append');
      
    close all;
    
end

%%

Gamma_Map_Points_Depth = sum(Gamma_Map_Points,1);
Gamma_Map_Points_FieldSize = sum(Gamma_Map_Points,2);
Gamma_Map_Passing_Points_Depth = sum(Gamma_Map_Passing_Points,1);
Gamma_Map_Passing_Points_FieldSize = sum(Gamma_Map_Passing_Points,2);

Gamma_Pass_Pct =  Gamma_Map_Passing_Points ./ Gamma_Map_Points*100;
Gamma_Pass_Mean_Depth = mean(Gamma_Pass_Pct,1);
Gamma_Pass_Mean_FieldSize = mean(Gamma_Pass_Pct,2);

fid = fopen(htmlname,'w+');

fprintf(fid,'<html>\n');
fprintf(fid,'<body>\n');
fprintf(fid,'<h2>Beam Validation Analysis</h2>\n\n');

fprintf(fid,'<h3>Linac Data</h3>\n');
fprintf(fid,'<b>Treatment Machine</b>: %s\n',Linac);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Beam Energy</b>: %s\n',Energy);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Beam Directory</b>: %s\n',beamtype);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Field Directory</b>: %s\n',fieldtype);
fprintf(fid,'<br><br>\n\n');

fprintf(fid,'<h3>Analysis Parameters</h3>\n');
fprintf(fid,'<b>Measurement Device</b>: %s',device_m);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Dose Calculation Software</b>: %s',device_p);
fprintf(fid,'<br><br>\n');
%fprintf(fid,'<b>Crossline (X) Profile Location</b>: Y = %.1f cm\n',y_offset(f));
%fprintf(fid,'<br>\n');
%fprintf(fid,'<b>Inline (Y) Profile Location</b>: X = %.1f cm\n',x_offset);
%fprintf(fid,'<br>\n');

if (auto_center_m == 1)
    cen_m_text = 'On';
else
    cen_m_text = 'Off';
end
fprintf(fid,'<b>Automatic Profile Centering - Measured</b>: %s\n',cen_m_text);
fprintf(fid,'<br>\n');

if (auto_center_p == 1)
    cen_p_text = 'On';
else
    cen_p_text = 'Off';
end
fprintf(fid,'<b>Automatic Profile Centering - Calculated</b>: %s\n',cen_p_text);
fprintf(fid,'<br>\n');

if (rel_analysis == 1)
    rel_text = 'Relative Dose Comparison (Normalized to 100% at Profile Intersection)';
else
    rel_text = 'Absolute Dose Comparison';
end
fprintf(fid,'<b>Analysis Type</b>: %s\n',rel_text);

fprintf(fid,'<br><br>\n');

if (binary_gamma == 1)
    gam_text = 'Binary Gamma Map';
else
    gam_text = 'Continuous Gamma Map';
end
fprintf(fid,'<b>Dose Difference Acceptance Criteria</b>: %.1f%%\n',ddThreshold*100);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Distance-to-Agreement Acceptance Criteria</b>: %.0f mm\n',dtaThreshold*10);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Minimum Dose Included in Analysis</b>: %.1f%% of maximum dose\n',pctDoseExclude*100);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Dose Difference Threshold</b>: Automatic pass for dose differences smaller than %.0f cGy\n',doseDiffExclude);
fprintf(fid,'<br>\n');
fprintf(fid,'<b>Gamma Analysis Search Range</b>: %.0f mm\n',searchRange*10);
fprintf(fid,'<br><br>\n');

fprintf(fid,'<h3>Profile Locations</h3>\n');
fprintf(fid,'<table border="1">\n');
for r = 0:length(FieldSize_X1)
    fprintf(fid,'<tr valign="middle" align="center">\n');
   
    for c = 0:2
       
        if (r > 0 && c == 0) 
            fprintf(fid,'<td><b>X1: %s, X2: %s<br>Y1: %d, Y2: %d</b></td>\n',num2str(FieldSize_X1(r)),num2str(FieldSize_X2(r)),FieldSize_Y1(r),FieldSize_Y2(r));
        elseif (r == 0 && c == 1)
            fprintf(fid,'<td><b>Crossline (X)<br>Profile Location</b></td>\n');
        elseif (r == 0 && c == 2)
            fprintf(fid,'<td><b>Inline (Y)<br>Profile Location</b></td>\n');
        elseif (r > 0 && c == 1)
            fprintf(fid,'<td>%.1f cm</td>\n',x_offset(r));
        elseif (r > 0 && c == 2)
            fprintf(fid,'<td>%.1f cm</td>\n',y_offset(r));
        else
            fprintf(fid,'<td></td>\n');

        end
    end
    fprintf(fid,'</tr>\n');
end
fprintf(fid,'</table>\n');
fprintf(fid,'<br><br>\n');

fprintf(fid,'<h3>Gamma Passing Rates</h3>\n');
fprintf(fid,'<table border="1">\n');
for r = 0:(length(FieldSize_X1)+2)
    fprintf(fid,'<tr valign="middle" align="center">\n');
   
    for c = 0:(length(Depth)+2)
      
        if (r == length(FieldSize_X1)+1 && c == 0) || (c == length(Depth)+1 && r == 0) % Average over Points labels
            fprintf(fid,'<td><b>Ave. (Points)</b></td>\n');
        elseif (r == length(FieldSize_X1)+1 && c == length(Depth)+1) 
            fprintf(fid,'<td>%d of %d (%.1f%%)</td>\n',sum(Gamma_Map_Passing_Points_Depth),sum(Gamma_Map_Points_Depth),sum(Gamma_Map_Passing_Points_Depth)/sum(Gamma_Map_Points_Depth)*100);
        elseif (r == length(FieldSize_X1)+2 && c == length(Depth)+2) 
            fprintf(fid,'<td>%.1f%%</td>\n',mean(Gamma_Pass_Mean_Depth));
        elseif (r == length(FieldSize_X1)+2 && c == 0) || (c == length(Depth)+2 && r == 0) % Average over Percentages labels
            fprintf(fid,'<td><b>Ave. (Percents)</b></td>\n');
        elseif (r == length(FieldSize_X1)+2 && c == length(Depth)+1)
            fprintf(fid,'<td>--</td>\n');
        elseif (r == length(FieldSize_X1)+1 && c == length(Depth)+2)
            fprintf(fid,'<td>--</td>\n');
        elseif (r == length(FieldSize_X1)+1 && c > 0) 
            fprintf(fid,'<td>%d of %d (%.1f%%)</td>\n',Gamma_Map_Passing_Points_Depth(c),Gamma_Map_Points_Depth(c),Gamma_Map_Passing_Points_Depth(c)/Gamma_Map_Points_Depth(c)*100);
        elseif (r == length(FieldSize_X1)+2 && c > 0)
            fprintf(fid,'<td>%.1f%%</td>\n',Gamma_Pass_Mean_Depth(c));             
        elseif (c == length(Depth)+1 && r > 0) 
            fprintf(fid,'<td>%d of %d (%.1f%%)</td>\n',Gamma_Map_Passing_Points_FieldSize(r),Gamma_Map_Points_FieldSize(r),Gamma_Map_Passing_Points_FieldSize(r)/Gamma_Map_Points_FieldSize(r)*100);
        elseif (c == length(Depth)+2 && r > 0)
            fprintf(fid,'<td>%.1f%%</td>\n',Gamma_Pass_Mean_FieldSize(r));
        elseif (r > 0 && c == 0) 
            fprintf(fid,'<td><b>X1: %s, X2: %s<br>Y1: %d, Y2: %d</b></td>\n',num2str(FieldSize_X1(r)),num2str(FieldSize_X2(r)),FieldSize_Y1(r),FieldSize_Y2(r));
        elseif (r == 0 && c > 0)
            fprintf(fid,'<td><b>%d cm</b></td>\n',Depth(c));
        elseif (r > 0 && c > 0)
            gc = Gamma_Map_Points(r,c);
            gp = Gamma_Map_Passing_Points(r,c);
            fprintf(fid,'<td>%d of %d (%.1f%%)</td>\n',gp,gc,gp/gc*100);
        else
            fprintf(fid,'<td> \n');

        end
    end
    fprintf(fid,'</tr>\n');
end
fprintf(fid,'</table>\n');

fprintf(fid,'</body>\n');
fprintf(fid,'</html>\n');


fclose(fid);

