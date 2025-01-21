function [] = Tcalc(handles, file_path, output_folder, unkdata, caldata_l, caldata_r, hp, wavelengths, i, elapsedSec, filename, timestamp)
%--------------------------------------------------------------------------
% TCALC
%--------------------------------------------------------------------------
% Version 6.0
% Written and tested on Matlab R2014a (Windows 7) & R2017a (OS X 10.13)

% Copyright 2018 Oliver Lord, Mike Walter
% email: oliver.lord@bristol.ac.uk
 
% This file is part of black.
 
% black is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
 
% black is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
 
% You should have received a copy of the GNU General Public License
% along with black.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------
%   TCALC

%   INPUTS:

%   OUTPUTS:

%--------------------------------------------------------------------------

% Call ROI function to get values from GUI boxes
[mnll, mxll, mnlr, mxlr, mnrowl, mxrowl, mnrowr, mxrowr] = ROI(handles);

% If Auto rotate radiobutton selected, rotate image by angles saved in
% rotfile.mat
if get(handles.radiobutton_auto_rotate,'Value') == 1
            
    rots = load('rotfile.mat');
    unkl = imrotate(unkdata,-rots.tilt_L,'bicubic');
    unkr = imrotate(unkdata,-rots.tilt_R,'bicubic');

else
    
    [unkl,unkr]=deal(unkdata);
    
end

% Constant c1 = 2hc^2*pi*1e4 in W cm2 where h is Planck's constant in J s, c
% is the speed of light in m s-1
c1 = 3.74177e-12;

% Constant c2 = hc/k*1e9 nm K where h is Planck's constant in J s, c is the
% speed of light in m s-1 and k is Boltzmann's constant in J K-1.
c2 = 14387773.54;

% Determines normalised wavelengths for fitting and plotting
nw = c2./wavelengths';

% Perform error minmisation if radiobutton selected
if get(handles.popupmenu_error_min_type,'Value') > 1 && get(handles.popupmenu_error_min_type,'Value') < 4
    
    maxpix = 1024;
    lsteps = 45;
    wsteps = lsteps;
    min_step = 20;
    min_width = 124;
    
    if get(handles.popupmenu_error_min_type,'Value') == 2
        wsteps = 0;
        min_width=700;
    end
    
    spix = repmat((0:min_step:maxpix-min_width)',[1 wsteps+1]);
    epix = spix+repmat((min_width:(maxpix-min_width)/wsteps:maxpix),[wsteps+1 1]);
    
    spix(spix==0)=1;
    epix(epix>1024)=NaN;
    spix(isnan(epix))=NaN;
    
    inner_length = size(epix);
    
    for i = 1:length(spix)
        
        for j = 1:inner_length(2)
            if ~isnan(spix(i,j)) && ~isnan(epix(i,j))
                
                % Calculate min and max wavelengths from start and end
                % pixel numbers
                mnl=wavelengths(spix(i,j));
                mxl=wavelengths(epix(i,j));
                
                % Calculate temperature Left and Right
                [Tl,J,El,Eel,el,rl,SSDl] = Temp(unkl,caldata_l,hp.sr,wavelengths,mnl,mxl,mxrowl,mnrowl,handles,nw,c1);
                [Tr,J,Er,Eer,er,rr,SSDr] = Temp(unkr,caldata_r,hp.sr,wavelengths,mnl,mxl,mxrowr,mnrowr,handles,nw,c1);
                
                % Determine average T left and right
                aTl(i,j) = nanmean(Tl); %#ok<AGROW>
                aTr(i,j) = nanmean(Tr); %#ok<AGROW>
              
                % Determine average error left and right
                ael(i,j) = nanmean(el); %#ok<AGROW>
                aer(i,j) = nanmean(er); %#ok<AGROW>

                % Determine SSD left and right
                aSSDl(i,j) = nanmean(SSDl);
                aSSDr(i,j) = nanmean(SSDr);
            end
        end
    end
    
    % Remove negative errors
    ael(ael<=0)=NaN;
    aer(aer<=0)=NaN;
    
    % Remove zeros from SSD
    aSSDl(aSSDl<=0)=NaN;
    aSSDr(aSSDr<=0)=NaN;

    % Definine minimisation indices
    [~,idxl] = min(ael(:));
    [~,idxr] = min(aer(:));

    % Calculate start wavelengths from start pixels
    sw = wavelengths(spix(:,1));
 
    % Calculate widths
    ww = wavelengths(epix(1,:))-wavelengths(spix(1,:));

    % Update GUI boxes
    set(handles.edit_wavelength_min_left,'string',round(wavelengths(spix(idxl))));
    set(handles.edit_wavelength_max_left,'string',round(wavelengths(epix(idxl))));
    set(handles.edit_wavelength_min_right,'string',round(wavelengths(spix(idxr))));
    set(handles.edit_wavelength_max_right,'string',round(wavelengths(epix(idxr))));
    
    % Plot error minimsation data
    if get(handles.popupmenu_error_min_type,'Value') == 2
 
        axes(handles.plot_emin_left);
        plot(wavelengths(spix),ael);
        plot_axes(handles,'plot_emin_left','Start Wavelength (nm)',...
            'Average Error (K)','Error Minimisation Left','Right',1,1);
        
        % Plot error minimisation code right
        axes(handles.plot_emin_right);
        plot(wavelengths(spix),real(aer));
        plot_axes(handles,'plot_emin_right','Start Wavelength (nm)',...
            'Average Error (K)','Error Minimisation Right','Right',1,1);

    elseif get(handles.popupmenu_error_min_type,'Value') == 3

        axes(handles.plot_emin_left);
        imagesc(sw,ww,1./real(ael))
        plot_axes(handles,'plot_emin_left','Start Wavelength (nm)',...
            'Window Width (nm)','Error Minimisation Left','Right',1,0,ww(1),ww(end),sw(1),sw(end));
        
        axes(handles.plot_emin_right);
        imagesc(sw,ww,1./real(aer))
        plot_axes(handles,'plot_emin_right','Start Wavelength (nm)',...
            'Window Width (nm)','Error Minimisation Left','Right',1,0,ww(1),ww(end),sw(1),sw(end));

    end

    % Update ROI box positions
    [mnll, mxll, mnlr, mxlr, mnrowl,mxrowl,mnrowr, mxrowr] = ROI(handles);

end

% Find optimum calibration file
if get(handles.popupmenu_error_min_type,'Value') == 4
    
    % Load previous file path from .MAT file
    lastpath = matfile('lastpath.mat','Writable',true);
    
    % Prompts uder to select folder containing calibration files
    [allcalfiles,allcalpath]=uigetfile(strcat(lastpath.lastpath,'*.SPE'),...
        'Select Image(s)','MultiSelect','on');
    
    % Update ROI box positions
    [mnll, mxll, mnlr, mxlr, mnrowl,mxrowl,mnrowr, mxrowr] = ROI(handles);
    
    for i=3:length(allcalfiles)
        
        % Read in the calibration data and convert to double
        fid=fopen(strcat(allcalpath,allcalfiles{i}),'r');
        testcal=fread(fid,[1024,256],'real*4','l');
        fclose(fid);

        % Calculate temperature Left and Right
        [templ,~,~,errorl] = Temp(unkl,testcal,hp.sr,wavelengths,lpixl,hpixl,mxrowl,mnrowl,handles,nw,c1);
        [tempr,~,~,errorr] = Temp(unkr,testcal,hp.sr,wavelengths,lpixr,hpixr,mxrowr,mnrowr,handles,nw,c1);
        
        % Determine average T left and right
        avg_T_l(i) = nanmean(templ);
        avg_T_r(i) = nanmean(tempr);
        
        % Determine average error left and right
        ael(i) = nanmean(errorl);
        aer(i) = nanmean(errorr);
    end
    
    % Remove negative errors
    ael(ael<=0)=NaN;
    aer(aer<=0)=NaN;
    
    % Find minimum error left and right
    [~,idxl] = min(ael(:));
    [~,idxr] = min(aer(:));

    % Update optimum calibration files to calmat
    calmat = matfile('calibration.mat','Writable',true);
    
    fid=fopen(strcat(allcalpath,allcalfiles{idxl}),'r');
    calmat.cal_l=fread(fid,[1024,256],'real*4','l');
    calmat.name_l=allcalfiles(idxl);
    fclose(fid);
    set(handles.edit_calname_left,'string',calmat.name_l);
    
    fid=fopen(strcat(allcalpath,allcalfiles{idxr}),'r');
    calmat.cal_r=fread(fid,[1024,256],'real*4','l');
    calmat.name_r=allcalfiles(idxr);
    set(handles.edit_calname_right,'string',calmat.name_r);
    fclose(fid);
    
end

% Calculate temperature Left and Right
[Tl,Jl,El,Eel,el,rl,SSDl,paramsl,fitl,lpixl,hpixl] = Temp(unkl,caldata_l,hp.sr,...
    wavelengths,mnll,mxll,mxrowl,mnrowl,handles,nw,c1);
[Tr,Jr,Er,Eer,er,rr,SSDr,paramsr,fitr,lpixr,hpixr] = Temp(unkr,caldata_r,hp.sr,...
    wavelengths,mnlr,mxlr,mxrowr,mnrowr,handles,nw,c1);

% Determine fit with minimum SSD left and right
[a,idxl] = min(SSDl(:));
[b,idxr] = min(SSDr(:));

% Plot Wien fit Left
axes(handles.plot_wien_left)
cla
plot(nw,fitl(:,idxl),'r-','LineWidth',2)
hold on
plot(nw,Jl(:,idxl),'o','Color',[0 0 0]+0.5,'MarkerFaceColor',[0 0 0]+0.5,'MarkerSize',1);
plot(nw(lpixl:hpixl),Jl(lpixl:hpixl,idxl),'bo','MarkerFaceColor','b','MarkerSize',1)

% Plot residuals Left
axes(handles.plot_residuals_left)
cla
plot(nw,zeros(1,length(nw)),'r-','LineWidth',2);
hold on
%plot(nw,Jl(:,idxl)-fitl(:,idxl),'o','Color',[0 0 0]+0.5,'MarkerFaceColor',[0 0 0]+0.5,'MarkerSize',2)
plot(nw(lpixl:hpixl),Jl(lpixl:hpixl,idxl)-fitl(lpixl:hpixl,idxl),'bo','MarkerFaceColor','b','MarkerSize',1)

% Plot Wien fit Right
axes(handles.plot_wien_right)
cla
plot(nw,fitr(:,idxr),'r-','LineWidth',2)
hold on
plot(nw,Jr(:,idxr),'o','Color',[0 0 0]+0.5,'MarkerFaceColor',[0 0 0]+0.5,'MarkerSize',1);
plot(nw(lpixr:hpixr),Jr(lpixr:hpixr,idxr),'bo','MarkerFaceColor','b','MarkerSize',1)

% Plot residuals Right
axes(handles.plot_residuals_right)
cla
plot(nw,zeros(1,length(nw)),'r-','LineWidth',2);
hold on
%plot(nw,Jr(:,idxr)-fitr(:,idxr),'o','Color',[0 0 0]+0.5,'MarkerFaceColor',[0 0 0]+0.5,'MarkerSize',2)
plot(nw(lpixr:hpixr),Jr(lpixr:hpixr,idxr)-fitr(lpixr:hpixr,idxr),'bo','MarkerFaceColor','b','MarkerSize',1)

% Convert pixels to microns
microns_l = linspace(-(mxrowl-mnrowl+2/2).*.52,(mxrowl-mnrowl+2/2).*.52,mxrowl-mnrowl+1);
microns_r = linspace(-(mxrowr-mnrowr+2/2).*.52,(mxrowr-mnrowr+2/2).*.52,mxrowr-mnrowr+1);

% Get max, min and mean T values and errors on the Left
[maxtempl,idx] = max(Tl);
emaxl=el(idx);
[mintempl,idx] = min(Tl);
eminl=el(idx);
meantempl = nanmean(Tl);
emeanl=(nanstd(Tl)/((mxrowl-mnrowl)^(1/2)))+nanmean(el);

% Get max, min and mean T values and errors on the Right
[maxtempr,idx] = max(Tr);
emaxr=er(idx);
[mintempr,idx] = min(Tr);
eminr=er(idx);
meantempr = nanmean(Tr);
emeanr=(nanstd(Tr)/((mxrowr-mnrowr)^(1/2)))+nanmean(er);

% Plot temperature history
axes(handles.plot_history)
% Plot mean
errorbar(elapsedSec,meantempl,emeanl,'-o', 'Color','r', 'MarkerEdgeColor','r', 'MarkerFaceColor','r');
errorbar(elapsedSec,meantempr,emeanr,'-o', 'Color','g', 'MarkerEdgeColor','g', 'MarkerFaceColor','g');
% Plot max
errorbar(elapsedSec,maxtempl,emaxl,'-s', 'Color','r', 'MarkerEdgeColor','r', 'MarkerFaceColor','r');
errorbar(elapsedSec,maxtempr,emaxr,'-s', 'Color','g', 'MarkerEdgeColor','g', 'MarkerFaceColor','g');

% Plot Temperature cross-section left
axes(handles.plot_section_left)
errorbar(microns_l,Tl,el,'Color','r');
set(handles.text_max_left,'string',sprintf('Max = %.0f±%.0f',maxtempl,emaxl))
set(handles.text_min_left,'string',sprintf('Min = %.0f±%.0f',mintempl,eminl))
set(handles.text_average_left,'string',sprintf('Average = %.0f±%.0f',meantempl,emeanl))

% Plot Temperature cross-section right
axes(handles.plot_section_right)
errorbar(microns_r,Tr,er,'Color','r');
set(handles.text_max_right,'string',sprintf('Max = %.0f±%.0f',maxtempr,emaxr))
set(handles.text_min_right,'string',sprintf('Min = %.0f±%.0f',mintempr,eminr))
set(handles.text_average_right,'string',sprintf('Average = %.0f±%.0f',meantempr,emeanr))

% Set x-axes limits on cross-section plots
xlim(handles.plot_section_pixels_left,[mnrowl mxrowl]);
xlim(handles.plot_section_pixels_right,[mnrowr mxrowr]);
xlim(handles.plot_section_left,[microns_l(1) microns_l(end)]);
xlim(handles.plot_section_right,[microns_r(1) microns_r(end)]);

if get(handles.radiobutton_save_output,'Value') == 1
    expname = strsplit(filename,'.sif');
    expname = expname(1);
    output_path = strcat(file_path, output_folder, '/');

    wien_file = char(strcat(output_path,expname,'_wien.txt'));
    wiens = padcat(nw,double(Jl(:,idxl)),fitl(:,idxl),nw,double(Jr(:,idxr)),fitr(:,idxr)); %#ok<NASGU>
    save(wien_file,'wiens','-ASCII');
    % Creates unique file name for wien data and saves it

    section_file = char(strcat(output_path,expname,'_x-sections.txt'));
    sections = padcat((mnrowl:mxrowl)', microns_l', Tl', el', El', Eel', (mnrowr:mxrowr)', microns_r', Tr', er', Er', Eer'); %#ok<NASGU>
    save(section_file,'sections','-ASCII');
    % Creates unique file name for wien data and saves it
    
     % On first pass
    if i == 1
        
        % Open summary file
        fid = fopen(char(strcat(output_path,'/','SUMMARY.txt')),'a');

        % Write header to file
        fprintf(fid,'%20s\t%15s\t%10s\t%10s\t%10s\t%10s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t\n','',...
            '','','LEFT','','','','','','RIGHT','','','','','');
        fprintf('%20s\t%15s\t%10s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t\n','filename',...
            'timestamp','time (s)','Max T','e (K)',...
            'Min T','e (K)','Avg T','e (K)',...
            'Max T','e (K)','Min T','e (K)',...
            'Avg T','e (K)');
        
        % Write header to workspace
        fprintf('%20s\t%15s\t%10s\t%10s\t%10s\t%10s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t%5s\t\n','',...
            '','','LEFT','','','','','','RIGHT','','','','','');
        fprintf('%20s\t%15s\t%10s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t%10s\t%5s\t\n','filename',...
            'timestamp','time (s)','Max T','e (K)',...
            'Min T','e (K)','Avg T','e (K)',...
            'Max T','e (K)','Min T','e (K)',...
            'Avg T','e (K)');
    end
    
    % re-open summary file
    fid = fopen(char(strcat(output_path,'/','SUMMARY.txt')),'a');
    
    % Write summary data to file
    fprintf(fid,'\n%20s\t%15d\t%10.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\n',...
        filename(1:end-4),timestamp,elapsedSec,maxtempl,emaxl,mintempl,eminl,...
        meantempl,emeanl,maxtempr,emaxr,mintempr,eminr,...
        meantempr,emeanr);
    
    % Write summary data to workspace
    fprintf('\n%20s\t%15d\t%10.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\t%10.0f\t%5.0f\n',...
        filename(1:end-4),timestamp,elapsedSec,maxtempl,emaxl,mintempl,eminl,...
        meantempl,emeanl,maxtempr,emaxr,mintempr,eminr,...
        meantempr,emeanr);
    
    fclose(fid);
end