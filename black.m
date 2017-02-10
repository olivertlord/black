function varargout = black(varargin)

% BLACK M-file for black.fig
% Last Modified by GUIDE v2.5 04-Dec-2013 11:16:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @black_OpeningFcn, ...
                   'gui_OutputFcn',  @black_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function black_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = black_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

set(handles.edit7,'string','570');
set(handles.edit8,'string','830');
set(handles.edit9,'string','160');
set(handles.edit10,'string','200');
set(handles.edit15,'string','570');
set(handles.edit16,'string','830');
set(handles.edit17,'string','60');
set(handles.edit18,'string','100');
set(handles.edit21,'string','1');
set(handles.edit22,'string','1');
set(handles.edit2,'string','.SPE');
set(handles.edit12,'string','.SPE');
set(handles.edit20,'string','.SPE');
set(handles.radiobutton1,'value',0);

colers=char('r','g','b','c','m','b');
setappdata(0,'colers',colers);

function pushbutton1_Callback(hObject, eventdata, handles)

[cfilel,cpathl]=uigetfile('c:\MATLAB7\blackv5\calfiles\.spe','Winspec Calibration File');
set(handles.edit2,'string',cfilel);
setappdata(0,'cpathl',cpathl);

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton2_Callback(hObject, eventdata, handles)

function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton3_Callback(hObject, eventdata, handles)

function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton4_Callback(hObject, eventdata, handles)

function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_Callback(hObject, eventdata, handles)

function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)

function edit10_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit11_Callback(hObject, eventdata, handles)

function edit11_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton5_Callback(hObject, eventdata, handles)

[cfiler,cpathr]=uigetfile('c:\MATLAB7\blackv5\calfiles\.spe','Winspec Calibration File');
set(handles.edit12,'string',cfiler);
setappdata(0,'cpathr',cpathr);

function edit12_Callback(hObject, eventdata, handles)

function edit12_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton6_Callback(hObject, eventdata, handles)

function edit13_Callback(hObject, eventdata, handles)

function edit13_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)

function edit14_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_Callback(hObject, eventdata, handles)

function edit15_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_Callback(hObject, eventdata, handles)

function edit16_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_Callback(hObject, eventdata, handles)

function edit17_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit18_Callback(hObject, eventdata, handles)

function edit18_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton29_Callback(hObject, eventdata, handles)

[unkfile,upath]=uigetfile('C:\Documents and Settings\Oliver Lord\Desktop\Data.SPE','Winspec unknown File');
set(handles.edit20,'string',unkfile);
setappdata(0,'upath',upath);
ccnt=1;
setappdata(0,'ccnt',ccnt);

function edit20_Callback(hObject, eventdata, handles)

function edit20_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit21_Callback(hObject, eventdata, handles)

function edit21_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton40_Callback(hObject, eventdata, handles)

[spec, grat, conp, pix1, pix2, conl, lam1, lam2] = specset;

setappdata(0,'spec',spec);
setappdata(0,'conp',conp);
setappdata(0,'pix1',pix1);
setappdata(0,'pix2',pix2);
setappdata(0,'conl',conl);
setappdata(0,'lam1',lam1);
setappdata(0,'lam2',lam2);

if spec == 2;
    set(handles.edit10,'string','128');
    set(handles.edit18,'string','128');
end;

if spec == 3;
    set(handles.edit10,'string','124');
    set(handles.edit18,'string','124');
end;

if spec == 4;
    set(handles.edit10,'string','100');
    set(handles.edit18,'string','100');
end;

function pushbutton30_Callback(hObject, eventdata, handles)

worp = 1;
setappdata(0,'worp',worp);
ff=1;
setappdata(0,'ff',ff);

fi = eval(get(handles.edit21,'string'));
fl = eval(get(handles.edit22,'string'));
if fl>1
    scrsz = get(0,'ScreenSize');
    figure(4)
    %set(4,'Name', 'Temperature vs. Acquisition', 'Position', [5 552 650 500]);
    set(4,'Name', 'Temperature vs. Acquisition', 'Position', [5 552 650 500],'Menubar','none','Toolbar','none');
    %setAlwaysOnTop(4,true);
end;

if fl<fi
    fl = fi + 1;
    set(handles.edit22,'string',fl);
end;

ufile = get(handles.edit20,'string');
[y, ufile_end] = size(ufile);
ufile_end = ufile_end-4;
num1 = str2num(ufile(ufile_end));
num2 = str2num(ufile(ufile_end-1));
num3 = str2num(ufile(ufile_end-2));
stepback = 3;
if isempty(num3) == 1;
    num3 = 0;
    stepback = 2;
end;
if isempty(num2) == 1;
    num2 = 0;
    stepback = 1;
end;
check_number = num1+(num2*10)+(num3*100);

if (fl>1) & (check_number~=fi);
    new_str = num2str(fi);
    old_file = ufile(1:(ufile_end-stepback));
    ufile = horzcat(old_file,new_str,'.SPE');
    set(handles.edit20,'string',ufile);
end;
 
warning off all

[automnll, automxll, automnlr, automxlr, timevalue, elapsedSecNorm, mintempl, mintempr, stdtempl, stdtempr, avel, aver, errpeakl, errpeakr, cnt, col, lamp, divby, row, templ, jl, etempl, deltal, tempr, jr, etempr, deltar, omega, mnrowl, mxrowl, mnrowr, mxrowr, mnll, mxll, mnlr, mxlr, ninl, ninr, maxtempl, maxtempr, code, ccnt] = wiencalc4(handles, fi, fl);

if ccnt == 6;
    ccnt = 1;
else ccnt = ccnt+1;
end;

setappdata(0,'ccnt',ccnt');
setappdata(0,'ninl',ninl);
setappdata(0,'ninr',ninr);
setappdata(0,'mnrowl',mnrowl);
setappdata(0,'mxrowl', mxrowl);
setappdata(0,'mnrowr',mnrowr);
setappdata(0,'mxrowr',mxrowr);
setappdata(0,'omega',omega);
setappdata(0,'divby',divby);
setappdata(0,'lamp',lamp);
setappdata(0,'col',col);
setappdata(0,'row',row);
setappdata(0,'cnt',row);
setappdata(0,'deltal',deltal);
setappdata(0,'templ',templ);
setappdata(0,'deltar',deltar);
setappdata(0,'tempr',tempr);
setappdata(0,'jl',jl);
setappdata(0,'jr',jr);

result = [code', timevalue',elapsedSecNorm',maxtempl',errpeakl',avel',stdtempl',automnll',automxll',maxtempr',errpeakr',aver',stdtempr',automnlr',automxlr'];

assignin('base', 'result', result);

function pushbutton31_Callback(hObject, eventdata, handles)

ff=1;
setappdata(0,'ff',ff);

ccnt = getappdata(0,'ccnt');

if ccnt == 6;
    ccnt = 1;
else ccnt = ccnt+1;
end;

[wra, win, templ, deltal, tempr, deltar, omega, jr, jl] = emin (ccnt, handles);

setappdata(0,'deltal',deltal);
setappdata(0,'templ',templ);
setappdata(0,'deltar',deltar);
setappdata(0,'tempr',tempr);
setappdata(0,'jl',jl);
setappdata(0,'jr',jr);

function pushbutton32_Callback(hObject, eventdata, handles)

worp = 0;
setappdata(0,'worp',worp);
ff=2;
setappdata(0,'ff',ff);

[w, row, templ, deltal, tempr, deltar, omega, mnrowl, mxrowl, mnrowr, mxrowr, mnll, mxll, mnlr, mxlr, ninl, ninr, nincall, nincalr] = planckcalc (handles);

if ccnt == 6;
    ccnt = 1;
else ccnt = ccnt+1;
end;
setappdata(0,'ccnt',ccnt');

setappdata(0,'w',w);
setappdata(0,'ninl',ninl);
setappdata(0,'ninr',ninr);
setappdata(0,'mnrowl',mnrowl);
setappdata(0,'mxrowl', mxrowl);
setappdata(0,'mnrowr',mnrowr);
setappdata(0,'mxrowr',mxrowr);
setappdata(0,'omega',omega);
setappdata(0,'row',row);
setappdata(0,'cnt',row);
setappdata(0,'deltal',deltal);
setappdata(0,'templ',templ);
setappdata(0,'deltar',deltar);
setappdata(0,'tempr',tempr);
setappdata(0,'nincall',nincall);
setappdata(0,'nincalr',nincalr);

function pushbutton33_Callback(hObject, eventdata, handles)

ff=2;
setappdata(0,'ff',ff);

ninl = getappdata(0,'ninl');
ninr = getappdata(0,'ninr');
mnrowl = getappdata(0,'mnrowl');
mxrowl = getappdata(0,'mxrowl');
mnrowr = getappdata(0,'mnrowr');
mxrowr = getappdata(0,'mxrowr');
divby = getappdata(0,'divby');
omega = getappdata(0,'omega');
lamp = getappdata(0,'lamp');
conl = getappdata(0,'conl');
lam1 = getappdata(0,'lam1');
lam2 = getappdata(0,'lam2');
col = getappdata(0,'col');
row = getappdata(0,'row');
cnt = getappdata(0,'cnt');
ccnt = getappdata(0,'ccnt');
colers = getappdata(0,'colers');
w = getappdata(0,'w');

if ccnt == 6;
    ccnt = 1;
else ccnt = ccnt+1;
end;
setappdata(0,'ccnt',ccnt');

[wra, win, deltal, templ, deltar, tempr, nincall, nincalr] = eminp (w, colers, ccnt, cnt, handles, ninl, ninr, mnrowl, mxrowl, mnrowr, mxrowr, divby, omega, lamp, conl, lam1, lam2, col, row);

setappdata(0,'deltal',deltal);
setappdata(0,'templ',templ);
setappdata(0,'deltar',deltar);
setappdata(0,'tempr',tempr);
setappdata(0,'nincall',nincall);
setappdata(0,'nincalr',nincalr);

function pushbutton34_Callback(hObject, eventdata, handles)
tcorr;

function pushbutton35_Callback(hObject, eventdata, handles)

axes(handles.axes1);
cla reset;
axes(handles.axes2);
cla reset;
axes(handles.axes3);
cla reset;
axes(handles.axes4);
cla reset;

set(handles.text22,'string',0);
set(handles.text24,'string',0);
set(handles.text26,'string',0);
set(handles.text28,'string',0);

status = close(figure(4));

function pushbutton36_Callback(hObject, eventdata, handles)
save1;

function pushbutton37_Callback(hObject, eventdata, handles)
save2;

function pushbutton38_Callback(hObject, eventdata, handles)

function pushbutton39_Callback(hObject, eventdata, handles)
clear;
close all;

function edit22_Callback(hObject, eventdata, handles)

function edit22_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton1_Callback(hObject, eventdata, handles)

function radiobutton2_Callback(hObject, eventdata, handles)

function pushbutton41_Callback(hObject, eventdata, handles)

worp = getappdata(0,'worp');

ufile = get(handles.edit20,'string');
dpoint = strfind(ufile,'.');
underscore = strfind(ufile,'_');
position = size(underscore);
underscorepos = underscore(position(1,2));
cfi = str2num(ufile((underscorepos+1):(dpoint-1)));
cfl = num2str(cfi + 1);
ufile = strcat(ufile(1:(underscorepos)),cfl,ufile(dpoint:(dpoint+3)));
set(handles.edit20,'string',ufile)

if worp == 1;
pushbutton30_Callback(hObject, eventdata, handles);
end;

if worp == 0;
pushbutton32_Callback(hObject, eventdata, handles);
end;

function axes1_ButtonDownFcn(hObject, eventdata, handles)

set(zoom,'ActionPostCallback',@zoomeventl);
set(zoom,'Enable','on');

function [mnrowl, mxrowl] = zoomeventl(obj,evd)
newLim = get(evd.Axes,'XLim');
msgbox(sprintf('The new X-Limits on the left are [%.2f %.2f].',newLim));
mnrowl = round(newLim(1));
mxrowl = round(newLim(2));

function axes2_ButtonDownFcn(hObject, eventdata, handles)
set(zoom,'ActionPostCallback',@bob);
set(zoom,'Enable','on');

function bob(obj,evd)
newLim = get(evd.Axes,'XLim');
msgbox(sprintf('The new X-Limits on the right are [%.2f %.2f].',newLim));
mnrowr = round(newLim(1));
mxrowr = round(newLim(2));

function togglebutton2_Callback(hObject, eventdata, handles)

fi = eval(get(handles.edit21,'string'));
fl = eval(get(handles.edit22,'string'));

[upath]=uigetdir('C:\Documents and Settings\Oliver Lord\Desktop\Data\')

dir_content = dir(upath);
filenames = {dir_content.name};
current_files = filenames;

while true
  pause(2);
  dir_content = dir(upath);
  filenames = {dir_content.name};
  new_files = setdiff(filenames,current_files);
  
  if ~isempty(new_files)
    new_files
    set_file = char(new_files)
    set(handles.edit20,'string',set_file);
    upath = strcat(upath,'\')
    pause(1);
    [timevalue, elapsedSecNorm, mintempl, mintempr, stdtempl, stdtempr, avel, aver, errpeakl, errpeakr, cnt, col, lamp, divby, row, templ, jl, etempl, deltal, tempr, jr, etempr, deltar, omega, mnrowl, mxrowl, mnrowr, mxrowr, mnll, mxll, mnlr, mxlr, ninl, ninr, maxtempl, maxtempr, code] = wiencalc4(handles, fi, fl);
    current_files = filenames;
  end
  
end

function radiobutton5_Callback(hObject, eventdata, handles)

togglestate = get(hObject,'Value');

scrsz = get(0,'ScreenSize');
figure(4)
set(4,'Name', 'Temperature vs. Acquisition', 'Position', [5 552 650 500],'Menubar','none','Toolbar','none');

if togglestate == 1

    [upath]=uigetdir('C:\Documents and Settings\Oliver Lord\Desktop\Data\');
    setappdata(0,'upath',upath);

    dir_content = dir(upath);
    filenames = {dir_content.name};
    current_files = filenames;
    auto_cnt = 1;

    while true
        togglestate = get(hObject,'Value');
        if togglestate == 0
            break
        end
        pause(2);
        dir_content = dir(upath);
        filenames = {dir_content.name};
        new_files = setdiff(filenames,current_files);

        if ~isempty(new_files)
            new_files;
            set_file = strcat('\',(char(new_files)));
            set(handles.edit20,'string',set_file);
            %pause(0.1);
            
            [automnll, automxll, automnlr, automxlr, timevalue, elapsedSecNorm, mintempl, mintempr, stdtempl, stdtempr, avel, aver, errpeakl, errpeakr, cnt, col, lamp, divby, row, templ, jl, etempl, deltal, tempr, jr, etempr, deltar, omega, mnrowl, mxrowl, mnrowr, mxrowr, mnll, mxll, mnlr, mxlr, ninl, ninr, maxtempl, maxtempr, code] = wiencalc4 (handles, togglestate);
            
            start = strfind(set_file, '_');
            position = size(start);
            startpos = start(position(1,2));
            finish = size(set_file);
            set_file = str2num(set_file((startpos+1):(finish(2)-4)));
            
            autocode(auto_cnt) = set_file;
            autotimevalue(auto_cnt) = timevalue;
            
            S = datevec(timevalue);
            elapsedSec(auto_cnt) = (S(1,6) + (S(1,5)*60) + (S(1,4)*60*60));
            elapsedSecNorm(auto_cnt) = round(elapsedSec(auto_cnt)-elapsedSec(1));
            
            autoelapsedSecNorm(auto_cnt) = elapsedSecNorm(auto_cnt);
            automaxtempl(auto_cnt) = maxtempl;
            automaxtempr(auto_cnt) = maxtempr;
            autoerravel(auto_cnt) = errpeakl;
            autoerraver(auto_cnt) = errpeakr;
            automeantempl(auto_cnt) = avel;
            automeantempr(auto_cnt) = aver;
            autostdl(auto_cnt) = stdtempl;
            autostdr(auto_cnt) = stdtempr;
                       
            mnll = eval(get(handles.edit7,'string'))
            mxll = eval(get(handles.edit8,'string'));
            mnlr = eval(get(handles.edit15,'string'));
            mxlr = eval(get(handles.edit16,'string'));
            
            testmnll(auto_cnt) = mnll
            testmxll(auto_cnt) = mxll;
            testmnlr(auto_cnt) = mnlr;
            testmxlr(auto_cnt) = mxll;
            
            autoresult = [autocode', autotimevalue',autoelapsedSecNorm',automaxtempl',autoerravel',automeantempl',autostdl',testmnll',testmxll',automaxtempr', autoerraver',automeantempl',autostdl',testmnlr',testmxlr'];

            assignin('base', 'autoresult', autoresult);
            assignin('base', 'set_file', set_file);
            
            set(0,'CurrentFigure', 4);
            xlabel('n'), ylabel('Max T (K)'); 
            set(gca,'NextPlot','add');
            legend('location', 'NorthWest', 'Left','Right');
            plot(auto_cnt,automaxtempl(auto_cnt),'--ko','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','b',...
                        'MarkerSize',10);
            plot(auto_cnt,automaxtempr(auto_cnt),'--ko','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','r',...
                        'MarkerSize',10);
            
            % deal with the new files
            current_files = filenames;
            
            auto_cnt = auto_cnt + 1;
        end
        % fprintf('no new files\n');
    end    
       
elseif togglestate == 0
    return        
end

function radiobutton6_Callback(hObject, eventdata, handles)