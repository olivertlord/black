function [automnll, automxll, automnlr, automxlr, timevalue, elapsedSecNorm, mintempl, mintempr, stdtempl, stdtempr, avel, aver, errpeakl, errpeakr, cnt, col, lamp, divby, row, templ, jl, etempl, deltal, tempr, jr, etempr, deltar, omega, mnrowl, mxrowl, mnrowr, mxrowr, mnll, mxll, mnlr, mxlr, ninl, ninr, maxtempl, maxtempr, code,ccnt] = wiencalc4 (handles, fi, fl, togglestate);
clear unkdata unkdatab caldata maxtemp maxtemp1 aveerr1 mnlam1 mxlam1
cnt1=0;
ff=1;
tco=0;
wem=0;
cnt=0;
fcnt=1;
scrsz = get(0,'screensize');

spec = getappdata(0,'spec');
cpathl = getappdata(0,'cpathl');
cpathr = getappdata(0,'cpathr');
upath = getappdata(0,'upath')
conp = getappdata(0,'conp');
pix1 = getappdata(0,'pix1');
pix2 = getappdata(0,'pix2');
conl = getappdata(0,'conl');
lam1 = getappdata(0,'lam1');
lam2 = getappdata(0,'lam2');
colers = getappdata(0,'colers');
ccnt = getappdata(0,'ccnt');

emin = get(handles.radiobutton2,'value');
smooth = get(handles.radiobutton6,'value');
wem = get(handles.radiobutton1,'value');
fi = eval(get(handles.edit21,'string'));
fl = eval(get(handles.edit22,'string'));

cfilel = get(handles.edit2,'string');
cfiler = get(handles.edit12,'string');
ufile = get(handles.edit20,'string');

[mnll,mnl] = deal(eval(get(handles.edit7,'string')));
[mxll,mxl] = deal(eval(get(handles.edit8,'string')));

mnrowl = eval(get(handles.edit9,'string'));
mxrowl = eval(get(handles.edit10,'string'));

[mnlr,mnr] = deal(eval(get(handles.edit15,'string')));
[mxlr,mxr] = deal(eval(get(handles.edit16,'string')));

mnrowr = eval(get(handles.edit17,'string'));
mxrowr = eval(get(handles.edit18,'string'));

if(spec == 1); row=256; col=1024; end;
if(spec == 2); row=128; col=1024; end;
if(spec == 3); row=124; col=1024; end;
if(spec == 4); row=100; col=1340; end;

% Open Winspec calibration file left
calfilel=strcat(cpathl,cfilel);

fid=fopen(calfilel,'r');
headcl=fread(fid,[1025],'real*4');
caldatal=fread(fid,[col row],'real*4','l');
st=fclose(fid);

% Open Winspec calibration file right
calfiler=strcat(cpathr,cfiler);

fid=fopen(calfiler,'r');
headcr=fread(fid,[1025],'real*4');
caldatar=fread(fid,[col row],'real*4','l');
st=fclose(fid);

% open file w/ W-lamp spectral radiance values
if (spec == 1);
    [fid,message]=fopen('./E256.dat','r','l');
    for i=1:58; E(i) = fscanf(fid,'%f6.3') ; end;
    for i=1:58; lam(i)=460+i*10;end;
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;
    [lamp]= lampcal(w,lam,E);
    
elseif (spec == 2);
    [fid,message]=fopen('c:\MATLAB7\blackv5\E128.dat');
    for i=1:58; E(i) = fscanf(fid,'%f6.3') ; end;
    for i=1:58; lam(i)=430+i*10;end;
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;
    [lamp]= lampcal(w,lam,E);
    
elseif (spec == 4);
    [fid,message]=fopen('c:\MATLAB7\blackv5\E100.dat');
    for i=1:50; E(i) = fscanf(fid,'%f6.3') ; end;
    for i=1:50; lam(i)=430+i*10;end;
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;
    [lamp]= lampcal2(w,lam,E);
end;

% radiance calibration of W lamp 
if (spec == 3);
    % standard lamp calibration 
    
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;

       %(Raymonds Lamp)
       x(1)=4.4577e-14;
       x(2)=-1.6226e-10;
       x(3)=2.4176e-7;
       x(4)=-.00019023;
       x(5)=.084359;
       x(6)=-19.976;
       x(7)=1961.7;
                         
       lamp = polyval(x,w);
end;

for m = fi:fl
    
    cnt=cnt+1;

    % Open unknown file

    if (m == fi);
        unkfile=strcat(upath,ufile)
        
        fid=fopen(unkfile,'r');
        headc=fread(fid,[1025],'real*4');
        unkdata=fread(fid,[col row],'real*4','l');
        st=fclose(fid);

    else
    
    dpoint = strfind(ufile,'.');
    underscore = strfind(ufile,'_');
    position = size(underscore);
    underscorepos = underscore(position(1,2));
    cfi = str2num(ufile((underscorepos+1):(dpoint-1)));
    cfl = num2str(cfi + 1);
    ufile = strcat(ufile(1:(underscorepos)),cfl,ufile(dpoint:(dpoint+3)));

    unkfile=strcat(upath,ufile);

    fid=fopen(unkfile,'r');
    headc=fread(fid,[1025],'real*4');
    unkdata=fread(fid,[col row],'real*4','l');
    st=fclose(fid);

    set(handles.edit20,'string',ufile);
    
end;

%saturate = unkdata .* 7.1363e44;
unkdata(unkdata> 8.4077e-41)=NaN;

if (wem == 1);
    
    for i=1:col; E(i) = 0.53003 - 0.000136*w(i);end;
    
    for i=1:row;
        for j=1:col;
            unkdatab(j,i) = unkdata(j,i)./E(j);
        end;
    end;
    
    % Normalize unknown data to calibrate data

    ninl = unkdatab./caldatal;
    ninr = unkdatab./caldatar;
    
else;
    
    ninl = unkdata./caldatal;
    ninr = unkdata./caldatar;
    
end;

divby = rot90(w.^5./3.7403E-12,3);

% normalized wavelength for Wien's Law fit
  
omega = (14384000.)./w;

nin = ninl;
mnlam = mnll;
mxlam = mxll;

if smooth == 1
    mnrow = mnrowl-3;
    mxrow = mxrowl+1;
else
    mnrow = mnrowl;
    mxrow = mxrowl;
end;

[temp,j,etemp,delta] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col,unkdata);

templ = temp;
jl = j;
etempl = etemp;
deltal = delta;

nin = ninr;
mnlam = mnlr;
mxlam = mxlr;

if smooth == 1
    mnrow = mnrowr-3;
    mxrow = mxrowr+1
else
    mnrow = mnrowr;
    mxrow = mxrowr;
end;

[temp,j,etemp,delta] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col,unkdata);

tempr = temp;
jr = j;
etempr = etemp;
deltar = delta;

if emin == 1;
    eminauto;
end;

if ccnt == 6;
    ccnt = 1;
else ccnt = ccnt+1;
end;

if smooth == 1;
    windowSize=4;
    templ=filter(ones(1,windowSize)/windowSize,1,templ);
    jl=filter(ones(1,windowSize)/windowSize,1,jl);
    etempl=filter(ones(1,windowSize)/windowSize,1,etempl);
    deltal=filter(ones(1,windowSize)/windowSize,1,deltal);
    tempr=filter(ones(1,windowSize)/windowSize,1,tempr);
    jr=filter(ones(1,windowSize)/windowSize,1,jr);
    etempr=filter(ones(1,windowSize)/windowSize,1,etempr);
    deltar=filter(ones(1,windowSize)/windowSize,1,deltar);
    tempr=tempr(2:end);
    templ=templ(2:end);
end;

templ(templ<1)=NaN;
tempr(tempr<1)=NaN;

code(fcnt)=m;

D = dir(unkfile);
timevalue(fcnt) = datenum(D.date);
S = datevec(timevalue(fcnt));
elapsedSec(fcnt) = (S(1,6) + (S(1,5)*60) + (S(1,4)*60*60));
elapsedSecNorm(fcnt) = round(elapsedSec(fcnt)-elapsedSec(1));
automnll(fcnt) = eval(get(handles.edit7,'string'));
automxll(fcnt) = eval(get(handles.edit8,'string'));
automnlr(fcnt) = eval(get(handles.edit15,'string'));
automxlr(fcnt) = eval(get(handles.edit16,'string'));

maxtempr(fcnt)=max(tempr(mnrowr:mxrowr));
[x,y]=max(tempr(mnrowr:mxrowr));
errpeakr(fcnt)=deltar(y+mnrowr-1);
mintempr(fcnt)=min(tempr(mnrowr:mxrowr));
stdtempr(fcnt)=(nanstd(tempr(mnrowr:mxrowr)))/((mxrowr-mnrowr)^(1/2));
aver(fcnt)=nanmean(tempr(mnrowr:mxrowr));

maxtempl(fcnt)=max(templ(mnrowl:mxrowl));
[x,y]=max(templ(mnrowl:mxrowl));
errpeakl(fcnt)=deltal(y+mnrowl-1);
mintempl(fcnt)=min(templ(mnrowl:mxrowl));
a=mxrowl-mnrowl
stdtempl(fcnt)=(nanstd(templ(mnrowl:mxrowl)))/((mxrowl-mnrowl)^(1/2));
avel(fcnt)=nanmean(templ(mnrowl:mxrowl));

fcnt=fcnt+1;
lpixl=round(conl + lam1.*mnl + lam2.*mnl.^2);
hpixl=round(conl + lam1.*mxl + lam2.*mxl.^2);
xrangel=(1:row);

if hpixl>1024
   hpixl=1024;
end;

lpixr=round(conl + lam1.*mnr + lam2.*mnr.^2);
hpixr=round(conl + lam1.*mxr + lam2.*mxr.^2);
xranger=(1:row);

if hpixr>1024
   hpixr=1024;
end;

if fl>1
    
    set(0,'CurrentFigure', 4);
    xlabel('n'), ylabel('Max T (K)'); 
    set(gca,'NextPlot','add');
    legend('location', 'NorthWest', 'Left','Right');
    plot(cnt,maxtempl(cnt),'--ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',10);
    plot(cnt,maxtempr(cnt),'--ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',10);   
    errorbar(cnt,avel(cnt),stdtempl(cnt),'--ko','LineWidth',1,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','w',...
                'MarkerSize',10);
    errorbar(cnt,aver(cnt),stdtempr(cnt),'--ko','LineWidth',1,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','w',...
                'MarkerSize',10);
end;

drawnow;

plot(handles.axes3, omega(lpixl:hpixl),jl(lpixl:hpixl,mnrowl:mxrowl),'b');
plot(handles.axes4, omega(lpixr:hpixr),jr(lpixr:hpixr,mnrowr:mxrowr),'b');

axes(handles.axes1)
axis 'auto y'
xlim([mnrowl mxrowl]);

errorbar(handles.axes1, xrangel(mnrowl:mxrowl),templ(mnrowl:mxrowl),deltal(mnrowl:mxrowl), colers(ccnt));
grid(handles.axes1,'on');
set(handles.axes1,'NextPlot','add');
set(handles.text22,'string',maxtempl(cnt));
set(handles.text26,'string',errpeakl(cnt));
set(handles.text29,'string',avel(cnt));
set(handles.text30,'string',stdtempl(cnt));

axes(handles.axes2)
axis 'auto y'
xlim([mnrowr mxrowr]);

errorbar(handles.axes2, xranger(mnrowr:mxrowr),tempr(mnrowr:mxrowr),deltar(mnrowr:mxrowr), colers(ccnt));
grid(handles.axes2,'on');
set(handles.axes2,'NextPlot','add');
set(handles.text24,'string',maxtempr(cnt));
set(handles.text28,'string',errpeakr(cnt));
set(handles.text31,'string',aver(cnt));
set(handles.text32,'string',stdtempr(cnt));

end;