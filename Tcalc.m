% --- Tcalc function ------------------------------------------------------

function [expname, result] = Tcalc(handles, fi, fl, filelist, upath, prefix, calpath)

global code timestamp timeSec elapsedSec errpeakl errpeakr...
    maxtempl maxtempr avel stdtempl min_lambda_left max_lambda_left...
    aver stdtempr min_lambda_right max_lambda_right counter_2
% Set global variables

clear unkdata unkdatab caldata maxtemp maxtemp1 aveerr1 mnlam1 mxlam1
% Clear previous variables

[emin, conl, lam1, lam2, conp, pix1, pix2, row, col, mnll, mxll, mnlr, mxlr,...
    mnrowl, mxrowl, mnrowr, mxrowr, lpixl, hpixl, lpixr, hpixr] = ROI(handles);
% Call ROI function to get values from GUI boxes

fid=fopen(strcat(calpath,get(handles.edit2,'string')),'r');
cal_l=fread(fid,[col row],'real*4','l');
fclose(fid);
% Open thermal calibration file: left

fid = fopen(strcat(calpath,get(handles.edit12,'string')),'r');
cal_r = fread(fid,[col row],'real*4','l');
fclose(fid);
% Open thermal calibration file: right

fid = fopen('./E256.dat','r','l');
for i = 1:58
    E(i) = fscanf(fid,'%f6.3'); %#ok<AGROW>
end
for i = 1:58
    lam(i)=460+i*10; %#ok<AGROW>
end
for i = 1:col
    w(i) = conp + pix1*i - pix2*i^2; %#ok<AGROW>
end
lamp = lampcal(w,lam,E);
% Oopen file w/ W-lamp spectral radiance values

expname = strcat(prefix,'black_',date);
% Create unique experiment name

if get(handles.radiobutton41,'Value') == 0 && getappdata(0,'auto_flag') == 0 && exist(strcat(upath,expname),'dir')
    
    rmdir(strcat(upath,expname),'s');
    mkdir(strcat(upath,expname));
    % Overwrite directory if not in auto or increment modes
    
elseif getappdata(0,'auto_flag') == 1 || ~exist(strcat(upath,expname),'dir')
    
    mkdir(strcat(upath,expname));
    % Create directory if in auto mode and if it doesnt yet exist
end

if getappdata(0,'auto_flag') == 0 && getappdata(0,'history_length') < 1
    
    [code, timestamp, timeSec, elapsedSec, errpeakl, errpeakr,...
        maxtempl, maxtempr, avel, stdtempl, min_lambda_left,...
        max_lambda_left, aver, stdtempr, min_lambda_right,...
        max_lambda_right] = deal([]);
    % Clear global variables if not in auto_mode or increment mode 
end

if getappdata(0,'auto_flag') > 0
    
    counter_2 = getappdata(0,'auto_flag');
    % Increment counter when in auto_mode
    
elseif getappdata(0,'history_length') > 0
    
    counter_2 = getappdata(0,'history_length') + 1;
    setappdata(0,'history_length',counter_2);
    % Increment counter if in increment mode
    
else
    counter_2 = 1;
    % Restart counter if not in auto or increment mode
    
end

if getappdata(0,'history_length') == -1
    
    setappdata(0,'history_length',1);
    % Reset history_length to 1 if it was -1; this allowed global variables
    % to be cleared if user fitted a single file when not in increment mode
    % but not after subsequent increments
    
end

for m = fi:fl
% for every file number in range

    if ismember(m,filelist)
    % if file number is in the file lsit

        [unkdata] = data_prep(handles,m,prefix,m,col,row);
        % Call data_prep function
        
        ninl = unkdata./cal_l;
        ninr = unkdata./cal_r;
        % Normalize unknown data to calibration data
        
        ROI(handles)
        % Call ROI function to draw ROI rectangles on raw image
        
        if get(handles.radiobutton8,'Value') == 1
            
            load('rotfile.mat');
            
            ninl = imrotate(ninl,-tilt_L,'bicubic');
            ninr = imrotate(ninr,-tilt_R,'bicubic');
            
        end
        % Load rotation angles if option selected; rotate images
        
        divby = rot90(w.^5./3.7403E-12,3);
        % Normalized wavelength for Wien's Law fit
        assignin('base','w',w);
        omega = (14384000.)./w;
        % Normalized intensity for Wien's Law fit
        
        if emin == 1
            
            min_lambda = 570;
            counter_1 = 1;
            [min_err_l, min_err_r] = deal(1000);
            % Set counter, min lambda and set error high
            
            while (min_lambda<640)
                
                [templ_emin,jl_emin,etempl_emin,deltal_emin] = Temp(ninl,divby,omega,w,lamp,conl,lam1,lam2,min_lambda+200,min_lambda,mxrowl,mnrowl,col,unkdata,handles);
                % Calculate temperature Left
                
                [tempr_emin,jr_emin,etempr_emin,deltar_emin] = Temp(ninr,divby,omega,w,lamp,conl,lam1,lam2,min_lambda+200,min_lambda,mxrowr,mnrowr,col,unkdata,handles);
                % Calculate temperature right
                
                avg_err_l(counter_1) = nanmean(deltal_emin); %#ok<AGROW>
                % Determine average error left
                
                avg_err_r(counter_1) = nanmean(deltar_emin); %#ok<AGROW>
                % Determine average error right
                
                if avg_err_l(counter_1) < min_err_l
                % If left error is lower  than previous minumum
                
                    min_err_l = avg_err_l(counter_1);
                    % Set new minimum error
                    
                    [templ,jl,~,deltal] = deal(templ_emin,jl_emin,etempl_emin,deltal_emin);
                    % Set fit parameters to current best
                    
                    mnll = min_lambda;
                    mxll = mnll + 200;
                    % Set min and max lambda to current best
                    
                end
                
                if avg_err_r(counter_1) < min_err_r
                % If left error is lower  than previous minumum
                    
                    min_err_r = avg_err_r(counter_1);
                    % Set new minimum error
                    
                    [tempr,jr,~,deltar] = deal(tempr_emin,jr_emin,etempr_emin,deltar_emin);
                    % Set fit parameters to current best
                    
                    mnlr = min_lambda;
                    mxlr = mnlr + 200;
                end
                
                min_lambda = min_lambda + 10;
                counter_1 = counter_1 + 1;
                % Set min and max lambda to current best
                
            end
            
            set(handles.edit7,'string',mnll);
            set(handles.edit8,'string',mxll);
            set(handles.edit15,'string',mnlr);
            set(handles.edit16,'string',mxlr);
            % Update GUI boxes
            
            plot(handles.axes6,linspace(570,640,7),avg_err_l,'ro');
            plot(handles.axes7,linspace(570,640,7),avg_err_r,'go');
            % Plot minimisation curves
            
        else
            
            [templ,jl,~,deltal] = Temp(ninl,divby,omega,w,lamp,conl,lam1,lam2,mxll,mnll,mxrowl,mnrowl,col,unkdata,handles);
            % Calculate temperature Left

            [tempr,jr,~,deltar] = Temp(ninr,divby,omega,w,lamp,conl,lam1,lam2,mxlr,mnlr,mxrowr,mnrowr,col,unkdata,handles);
            % Calculate temperature Right
            
        end
        
        templ(templ<1 | templ>1e6)=NaN;
        tempr(tempr<1 | tempr>1e6)=NaN;
        % Replace zero or unreasonably high temperatures with NaNs so they
        % are not plotted 
        
        code(counter_2) = m;
        % Set code to current file loop iteration
        
        FileInfo = dir(strcat(upath,prefix,num2str(m),'.SPE'));
        timestamp(counter_2) = datenum(FileInfo.date);
        % Get timestamp
        
        timevector = datevec(timestamp(counter_2));
        % Vectorise timestamp
        
        timeSec(counter_2) = (timevector(1,6) + (timevector(1,5)*60) + (timevector(1,4)*60*60));
        % Convert timevector to seconds
        
        elapsedSec(counter_2) = round(timeSec(counter_2)-timeSec(1));
        % Determine seconds elapsed since start of experiment
        
        [maxtempr(counter_2),y] = max(tempr(mnrowr:mxrowr));
        errpeakr(counter_2)=deltar(y+mnrowr-1);
        % Find peak temperature value and position and associated error
        
        [maxtempl(counter_2),y] = max(templ(mnrowl:mxrowl));
        errpeakl(counter_2)=deltal(y+mnrowl-1);
        % Find peak temperature value and position and associated error
        
        stdtempr(counter_2)=(nanstd(tempr(mnrowr:mxrowr)))/((mxrowr-mnrowr)^(1/2));
        stdtempl(counter_2)=(nanstd(templ(mnrowl:mxrowl)))/((mxrowl-mnrowl)^(1/2));
        % Calculate standard deviation associated with peak T
        
        aver(counter_2)=nanmean(tempr(mnrowr:mxrowr));
        avel(counter_2)=nanmean(templ(mnrowl:mxrowl));
        % Calculate average temperature
        
        num2str(round(avel(counter_2)));
        
        min_lambda_left(counter_2)=mnll;
        min_lambda_right(counter_2)=mnlr;
        max_lambda_left(counter_2)=mxll;
        max_lambda_right(counter_2)=mxlr;
        % Store minimum and maximum lambda values
 
        t_diff = round(abs(maxtempl(counter_2)-maxtempr(counter_2)));
        set(handles.text41,'String',num2str(t_diff));
        % Determine and display difference between peaks
        
        if t_diff > 200
            set(handles.text41,'ForegroundColor',[1 0 0])
            set(handles.text50,'BackgroundColor',[1 0 0])
        elseif t_diff < 100
            set(handles.text41,'ForegroundColor',[0 1 0])
            set(handles.text50,'BackgroundColor',[0 1 0])
        else
            set(handles.text41,'ForegroundColor',[1 .5 0])
            set(handles.text50,'BackgroundColor',[1 .5 0])
        end
        % Change color of difference value depending on magnitude
        
        xrangel=mxrowl-mnrowl+2;
        microns_l = linspace(-(xrangel/2).*.52,(xrangel/2).*.52,xrangel-1);        
        xranger=mxrowr-mnrowr+2;
        microns_r = linspace(-(xranger/2).*.52,(xranger/2).*.52,xranger-1);
        % Convert pixels to microns
        
        plot(handles.axes1, omega(lpixl:hpixl),jl(lpixl:hpixl,mnrowl:mxrowl),'r');
        plot(handles.axes2, omega(lpixr:hpixr),jr(lpixr:hpixr,mnrowr:mxrowr),'g');
        % Plot Wien fits
        
%         tic

        xlim(handles.axes8,[mnrowl mxrowl]);
        xlim(handles.axes9,[mnrowr mxrowr]);
        % Set x-axes limits on cross-section plots
        
        xlim(handles.axes3,[min(microns_l) max(microns_l)]);
        xlim(handles.axes4,[min(microns_r) max(microns_r)]);
        % Set x-axes limits on cross-section overlay plots

        hline = get(handles.axes3, 'children');
        if ~isempty(hline)
            set(hline(1),'Color',[1 .8 .8]);
        end
        % Make previous lines pale
        
%         if length(hline) > 20
%             delete(hline(length(hline)));
%         end
%         % Delete old cross-sections
                
        hline = get(handles.axes4, 'children');
        if ~isempty(hline)
            set(hline(1),'Color',[.8 1 .8]);
        end
        % Make previous lines pale
        
%         if length(hline) > 20
%             delete(hline(length(hline)));
%         end
%         % Delete old cross-sections
        
        errorbar(handles.axes3, microns_l,templ(mnrowl:mxrowl),deltal(mnrowl:mxrowl),'Color','r');
        set(handles.text21,'string',strcat('Peak = ',num2str(round(maxtempl(counter_2))),'±',num2str(round(errpeakl(counter_2)))));
        set(handles.text25,'string',strcat('Average = ',num2str(round(avel(counter_2))),'±',num2str(round(stdtempl(counter_2)))));
        % Plot Temperature cross-section left
        
        errorbar(handles.axes4, microns_r,tempr(mnrowr:mxrowr),deltar(mnrowr:mxrowr), 'g');
        set(handles.text36,'string',strcat('Peak = ',num2str(round(maxtempr(counter_2))),'±',num2str(round(errpeakr(counter_2)))));
        set(handles.text37,'string',strcat('Average = ',num2str(round(aver(counter_2))),'±',num2str(round(stdtempr(counter_2)))));
        % Plot Temperature cross-section right
        
        errorbar(handles.axes5, elapsedSec, maxtempl, errpeakl, 'ro-');
        errorbar(handles.axes5, elapsedSec, maxtempr, errpeakr, 'go-');
        % plot Temperature histories
        
        pause(0.01);
        drawnow;
        
%         toc
%         timer(counter_2) = toc;
%         assignin('base','timer',timer);
        
        pix_dif = (hpixl-lpixl) - (hpixr-lpixr);
        if pix_dif > 0
            lpixl = lpixl + pix_dif;
        elseif pix_dif < 0
            lpixr = lpixr - pix_dif;
        end
        % Ensures pixel range of wien fits are the same despite rounding error
        
        wien_file = char(strcat(upath,'/',expname,'/',prefix,num2str(m),'_wien.txt'));
        wiens = [omega(lpixl:hpixl)' jl(lpixl:hpixl,mnrowl:mxrowl) omega(lpixr:hpixr)' jr(lpixr:hpixr,mnrowr:mxrowr)]; %#ok<NASGU>
        save(wien_file,'wiens','-ASCII');
        % Creates unique file name for wien data and saves it
        
        section_file = char(strcat(upath,'/',expname,'/',prefix,num2str(m),'_x-sections.txt'));
        sections = padcat ((mnrowl:mxrowl)', templ(mnrowl:mxrowl)', deltal(mnrowl:mxrowl)', (mnrowr:mxrowr)', tempr(mnrowr:mxrowr)', deltar(mnrowr:mxrowr)'); %#ok<NASGU>
        save(section_file,'sections','-ASCII');
        % Creates unique file name for wien data and saves it
        
        counter_2 = counter_2 + 1;
        % Increment Counter
    end

end

result = [code', timestamp',elapsedSec',maxtempl',errpeakl',avel',stdtempl',min_lambda_left',max_lambda_left',maxtempr',errpeakr',aver',stdtempr',min_lambda_right',max_lambda_right'];
assignin('base', 'result', result);
% Places results in user workspace