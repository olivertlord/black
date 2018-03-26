%% Create Dialogue Box for Wien Calculation

global cnt

cnt=0;

load Wiener

h0 = figure('Color',[.8 .8 .8], ...
	'Colormap',mat0, ...
	'Position',[105    42   850   680], ...
    'Tag','Fig1')
	

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[26 480 90 18], ...
	'String','Spectrometer Setup', ...
	'Callback','specset', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[26 460 90 15], ...
	'String','Calibration File', ...
	'Callback','opencal', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'BackgroundColor',[1 1 1], ...
	'Position',[26 445 90 15], ...
	'String','*.spe', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[26 425 90 15], ...
	'String','Unknown File', ...
	'Callback','openunk', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a2 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'BackgroundColor',[1 1 1], ...
	'Position',[26 410 90 15], ...
	'String','*.spe', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'ForegroundColor',[1 1 1], ...
    'BackgroundColor',[0.5 0.5 0.5], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[20 390 50 15], ...
	'String','File Range', ...
	'Style','text', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');

a18 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'BackgroundColor',[1 1 1], ...
	'Position',[75 390 20 15], ...
	'String','1', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');

a19 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'BackgroundColor',[1 1 1], ...
	'Position',[100 390 20 15], ...
	'String','1', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');







h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'ForegroundColor',[1 1 1], ...
    'BackgroundColor',[0.5 0.5 0.5], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[20 370 70 15], ...
	'String','Min Lambda (nm)', ...
	'Style','text', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a3 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[90 370 30 15], ...
	'String','570', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'ForegroundColor',[1 1 1], ...
    'BackgroundColor',[0.5 0.5 0.5], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[20 350 70 15], ...
	'String','Max Lambda (nm)', ...
	'Style','text', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a4 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[90 350 30 15], ...
	'String','720', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'ForegroundColor',[1 1 1], ...
    'BackgroundColor',[0.5 0.5 0.5], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[20 330 70 15], ...
	'String','Minimum Row', ...
	'Style','text', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a5 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[90 330 30 15], ...
	'String','1', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'ForegroundColor',[1 1 1], ...
    'BackgroundColor',[0.5 0.5 0.5], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[20 310 70 15], ...
	'String','Maximum Row', ...
	'Style','text', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a6 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[90 310 30 15], ...
	'String','100', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');


%h1 = uicontrol('Parent',h0, ...
	%'Units','points', ...
    %'ForegroundColor',[1 1 1], ...
    %'BackgroundColor',[0.5 0.5 0.5], ...
	%'FontName','Geneva', ...
	%'FontSize',8, ...
	%'Position',[26 250 70 12], ...
	%'String','Binning', ...
	%'Style','text', ...
    %'HandleVisibility', 'off',...
	%'Tag','StaticText1');
%a7 = uicontrol('Parent',h0, ...
	%'Units','points', ...
	%'BackgroundColor',[1 1 1], ...
	%'FontName','Geneva', ...
	%'FontSize',8, ...
	%'Position',[100 250 25 12], ...
	%'String','0', ...
	%'Style','edit', ...
    %'HandleVisibility', 'off',...
	%'Tag','EditText1');
    
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'ForegroundColor',[1 1 1], ...
    'BackgroundColor',[0.5 0.5 0.5], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[20 290 70 15], ...
	'String','Boxcar Smoothing', ...
	'Style','text', ...
    'HandleVisibility', 'off',...
	'Tag','StaticText1');
a8 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[90 290 30 15], ...
	'String','0', ...
	'Style','edit', ...
    'HandleVisibility', 'off',...
	'Tag','EditText1');

a17 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 270 100 15], ...
    'String','Use W emissivity', ...
    'Style','checkbox',...
    'Value',0,...
    'HandleVisibility', 'off',...
    'Tag','check1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 240 100 18], ...
	'String','Calculate Wien Fit', ...
    'Callback','wiencalc4', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 220 100 18], ...
	'String','Wien Error Min', ...
    'Callback','emin', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 190 100 18], ...
	'String','Calculate Planck Fit', ...
    'Callback','planckcalc', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 170 100 18], ...
	'String','Planck Error Min', ...
    'Callback','eminp', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 140 100 18], ...
	'String','T-correction', ...
    'Callback','tcorr', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[26 110 90 18], ...
	'String','Clear Figures', ...
    'HandleVisibility', 'off',...
	'Callback','clf, cnt=0; clear maxtemp; clear avetemp; clear errave',....
	'Tag','Pushbutton1');


h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 80 100 18], ...
	'String','Save Fit File', ...
    'Callback','save1', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 60 100 18], ...
	'String','Save Temperature File', ...
    'Callback','save2', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');

h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[21 40 100 18], ...
	'String','Save T-Error File', ...
    'Callback','save3', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton1');


h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[26 10 90 18], ...
	'String','Quit', ...
    'HandleVisibility', 'off',...
	'Callback','clear, close all',....
	'Tag','Pushbutton1');


