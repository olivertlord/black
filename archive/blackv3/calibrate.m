
load wiener

spec = get(a9,'value');
grat = get(a10, 'value');

htb0 = figure('Color',[0.8 0.8 0.8], ...
	'Colormap',mat0, ...
	'Position',[600   200   240   400], ...
	'Tag','Fig2');

htb1 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'BackgroundColor',[.7 .7 .7], ...
	'FontSize',9, ...
	'Position',[25 210 90 12], ...
	'String','Wavelength Calibration', ...
	'Style','text', ...
	'Tag','StaticText1');

htb2 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'BackgroundColor',[.7 .7 .7], ...
	'FontSize',9, ...
	'Position',[25 130 90 12], ...
	'String','Pixel Calibration', ...
	'Style','text', ...
	'Tag','StaticText1');

if(spec == 1);
   
if(grat == 1);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','485.44', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.50821', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','1.831e-7', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-954.87', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','1.9603', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','1.397e-6', ...
	'Style','edit', ...
	'Tag','EditText1');

elseif(grat == 2);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','555.56', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.285', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','-6e-6', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-1861.1', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','3.1934', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','0.0003', ...
	'Style','edit', ...
	'Tag','EditText1');

end;

elseif (spec == 2);
    
if(grat == 1);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','485.44', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.50821', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','1.831e-7', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-954.87', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','1.9603', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','1.397e-6', ...
	'Style','edit', ...
	'Tag','EditText1');

elseif(grat == 2);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','458.7', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.4667', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','-1.642e-5', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-956.03', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','2.0275', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','1.2379e-4', ...
	'Style','edit', ...
	'Tag','EditText1');
    
end;

elseif (spec == 3);
    
if(grat == 1);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','485.44', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.50821', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','1.831e-7', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-954.87', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','1.9603', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','1.397e-6', ...
	'Style','edit', ...
	'Tag','EditText1');

elseif(grat == 2);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','461.22', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.4776', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','-2e-5', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-911.14', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','1.863', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','2e-4', ...
	'Style','edit', ...
	'Tag','EditText1');
    
end;

elseif (spec == 4);
    
    if(grat == 1);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','485.44', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.50821', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','1.831e-7', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-954.87', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','1.9603', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','1.397e-6', ...
	'Style','edit', ...
	'Tag','EditText1');

elseif(grat == 2);
    
a11 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 190 60 18], ...
	'String','560.08', ...
	'Style','edit', ...
	'Tag','EditText1');
a12 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 170 60 18], ...
	'String','0.2107', ...
	'Style','edit', ...
	'Tag','EditText1');
a13 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 150 60 18], ...
	'String','-3e-6', ...
	'Style','edit', ...
	'Tag','EditText1');

a14 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 110 60 18], ...
	'String','-2549.3', ...
	'Style','edit', ...
	'Tag','EditText1');
a15 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 90 60 18], ...
	'String','4.3596', ...
	'Style','edit', ...
	'Tag','EditText1');
a16 = uicontrol('Parent',htb0, ...
	'Units','points', ...
	'BackgroundColor',[1 1 1], ...
	'FontName','Geneva', ...
	'FontSize',10, ...
	'Position',[25 70 60 18], ...
	'String','3e-4', ...
	'Style','edit', ...
	'Tag','EditText1');
    
end;

end;



htb3 = uicontrol('Parent',htb0, ...
	'Units','points', ...
    'BackgroundColor',[0.7 0.7 0.7], ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'Position',[25 40 90 18], ...
	'String','OK', ...
	'Callback','getcal, close(3),close(2)',....
	'Tag','Pushbutton1');

