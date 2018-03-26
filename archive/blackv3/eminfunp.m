cnt=cnt+1;
rp=0;
clear tempec; clear deltec; clear aveerr;

if (em>0) figure(he); clf; end;

wi = get(a22, 'String'); win=eval(wi); %initial wavelength
wr = get(a23, 'String'); wra=eval(wr); %wavelength range 

mnlam=win; 
mxlam=mnlam+wra;
lc=0;
avemin=1000;

if (em==0)
    he = figure('Color',[.8 .8 .8], ...
	'Colormap',mat0, ...
	'Position',[400    80   500   600], ...
    'Tag','Fig3')
end;

while (mxlam<850)
    lc=lc+1;
    mn(lc)=mnlam
    mx(lc)=mxlam
    [tempec(lc,:),emmi,deltec(lc,:),nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);
    mnlam=mnlam+10;
    mxlam=mxlam+10;
    aveerr(lc)=mean(deltec(lc,mnrow:mxrow));
    
    if(aveerr(lc)<avemin); avemin=aveerr(lc); amc=(lc);end;
    
figure(he)
subplot('position',[0.18,0.72,0.75,0.25])
plot(aveerr);
grid on;
xlabel('iteration #');
ylabel('ave error');
set(gca,'NextPlot','replacechildren')


subplot('position',[0.18,0.18,0.75,0.45])
errorbar(xrange(mnrow:mxrow),tempec(amc,mnrow:mxrow),deltec(amc,mnrow:mxrow),colers(cnt));
grid on;
xlabel('pixel'), ylabel('Temp (K)')
set(gca,'NextPlot','add');

end;

amcs=num2str(amc);
mns=num2str(mn(amc));
mxs=num2str(mx(amc));

he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'ForegroundColor',[0 0 0], ...
	'FontSize',10, ...
    'Position',[10 20 120 18], ...
    'String','minimum error at iteration', ...
	'Style','text', ...
	'Tag','StaticText1');

he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'ForegroundColor',[0 0 0], ...
	'FontSize',10, ...
    'Position',[130 20 12 18], ...
    'String',amcs, ...
	'Style','text', ...
	'Tag','StaticText1');

he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'ForegroundColor',[0 0 0], ...
	'FontSize',10, ...
    'Position',[170 20 20 18], ...
    'String',mns,...
	'Style','text', ...
	'Tag','StaticText1');

he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'ForegroundColor',[0 0 0], ...
	'FontSize',10, ...
    'Position',[190 20 10 18], ...
    'String','-',...
	'Style','text', ...
	'Tag','StaticText1');

he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'ForegroundColor',[0 0 0], ...
	'FontSize',10, ...
    'Position',[200 20 20 18], ...
    'String',mxs, ...
	'Style','text', ...
	'Tag','StaticText1');

he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
    'ForegroundColor',[0 0 0], ...
	'FontSize',10, ...
    'Position',[220 20 20 18], ...
    'String','nm', ...
	'Style','text', ...
	'Tag','StaticText1');


he2 = uicontrol('Parent',he, ...
	'Units','points', ...
	'FontName','Geneva', ...
	'FontSize',9, ...
	'BackgroundColor',[1 1 1], ...
	'Position',[300 20 50 20], ...
	'String','Accept', ...
    'Callback','replotp', ...
    'HandleVisibility', 'off',...
	'Tag','Pushbutton11');

em=em+1;