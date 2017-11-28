% --- rotate function -----------------------------------------------------

function rotate(handles,upath)

clear unkdata unkdatab caldata maxtemp maxtemp1 aveerr1 mnlam1 mxlam1
% Clear variables

[~, ~, ~, ~, ~, ~, ~, row, col, ~, ~, ~, ~, mnrowl, mxrowl, mnrowr,...
    mxrowr, lpixl, hpixl, lpixr, hpixr] = ROI(handles);
% Get GUI box values

fid=fopen(strcat('./calfiles/',get(handles.edit2,'string')),'r');
cal_l=fread(fid,[col row],'real*4','l');
fclose(fid);
% Open thermal calibration file: left

fid = fopen(strcat('calfiles/',get(handles.edit12,'string')),'r');
cal_r = fread(fid,[col row],'real*4','l');
fclose(fid);
% Open thermal calibration file: right

filename = get(handles.edit20,'String');
fid=fopen(strcat(upath,filename),'r');
% Get current filename

unkdata=fread(fid,[col row],'real*4','l');
% Reads in unknown file

unkdata(unkdata> 8.4077e-41)=NaN;
% Removes saturated pixels

ninl = unkdata./cal_l;
ninr = unkdata./cal_r;
% Normalize unknown data to calibration data

for i = lpixl:hpixl    
    % For every column of pixels within the ROI on the left
    
    spline_L = spline([mnrowl:mxrowl],ninl(i,mnrowl:mxrowl),[mnrowl:0.01:mxrowl]); %#ok<NBRAK>
    % Do spline fit to interpolate peak in intensity data at 0.01 pixel
    % resolution
    
    [~,pos] = max(spline_L);
    % Determine position of peak wihtin spline fit output array
    
    peak_l(i) = mnrowl + 0.01*pos; %#ok<AGROW>
    %Determine pixel value of peak position
    
end

for i = lpixr:hpixr
    % For every column of pixels within the ROI on the right

    spline_R = spline([mnrowr:mxrowr],ninr(i,mnrowr:mxrowr),[mnrowr:0.01:mxrowr]);  %#ok<NBRAK>
    % Do spline fit to interpolate peak in intensity data at 0.01 pixel
    % resolution    
    
    [~,pos] = max(spline_R);
    % Determine position of peak wihtin spline fit output array
    
    peak_r(i) = mnrowr + 0.01*pos; %#ok<AGROW>
    % Determine pixel value of peak position    
end

peak_l(peak_l < mnrowl) = NaN;
peak_r(peak_r < mnrowr) = NaN;
% Convert zeros to NaN at start of array outside ROI

strike_L = polyfit([lpixl:hpixl]',peak_l(lpixl:hpixl)',1); %#ok<NBRAK>
strike_R = polyfit([lpixr:hpixr]',peak_r(lpixr:hpixr)',1); %#ok<NBRAK>
% Determine slope of peak on the CCD using a linear fit

tilt_L = atand(strike_L(1)/1); %#ok<NASGU>
tilt_R = atand(strike_R(1)/1); %#ok<NASGU>
% Convert slope to tilt angle in degrees

save('rotfile.mat','tilt_L','tilt_R')
% Save tilt angles in .MAT file

axes(handles.axes6)
plot([1:hpixl],peak_l,'bo',[1:1024],polyval(strike_L,1:1:1024),'r-'); %#ok<NBRAK>
plot_axes('pixels', 'pixels', 'Slope', 'Right')
ylim([min(peak_l)-1 max(peak_l)+1]);
xlim([lpixl hpixl])
% Plot spline fit resilte left

axes(handles.axes7)
plot([1:hpixr],peak_r,'bo',[1:1024],polyval(strike_R,1:1:1024),'r-'); %#ok<NBRAK>
plot_axes('pixels', 'pixels', 'Slope', 'Right')
ylim([min(peak_r)-1 max(peak_r)+1]);
xlim([lpixr hpixr])
% Plot spline fit resilte right

set(handles.radiobutton8,'Value',1);
% Set "rotate" radiobutton to on

pause(5);
% Pause to allow user to see results

Tcalc(handles, eval(get(handles.edit22,'string')), eval(get(handles.edit21,'string')), eval(get(handles.edit22,'string')), upath, filename((1:end-(4+length(get(handles.edit21,'string'))))))
% Run Tcalc