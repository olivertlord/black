function [w, row, templ, deltal, tempr, deltar, omega, mnrowl, mxrowl, mnrowr, mxrowr, mnll, mxll, mnlr, mxlr, ninl, ninr, nincall, nincalr] = planckcalc (handles);

spec = getappdata(0,'spec');
cpathl = getappdata(0,'cpathl');
cpathr = getappdata(0,'cpathr');
upath = getappdata(0,'upath');
conp = getappdata(0,'conp');
pix1 = getappdata(0,'pix1');
pix2 = getappdata(0,'pix2');
conl = getappdata(0,'conl');
lam1 = getappdata(0,'lam1');
lam2 = getappdata(0,'lam2');
ccnt = getappdata(0,'ccnt');
colers = getappdata(0,'colers');

wem = get(handles.radiobutton1,'value');

clear unkdata unkdatab caldata maxtemp maxtemp1 aveerr1 mnlam1 mxlam1
cnt=0;
cnt1=0;
ff=1;
tco=0;
em=0;

cfilel = get(handles.edit2,'string');
cfiler = get(handles.edit12,'string');
ufile = get(handles.edit20,'string');

mnll = eval(get(handles.edit7,'string'));
mxll = eval(get(handles.edit8,'string'));
mnrowl = eval(get(handles.edit9,'string'));
mxrowl = eval(get(handles.edit10,'string'));

mnlr = eval(get(handles.edit15,'string'));
mxlr = eval(get(handles.edit16,'string'));
mnrowr = eval(get(handles.edit17,'string'));
mxrowr = eval(get(handles.edit18,'string'));

fi = eval(get(handles.edit21,'string'));
fl = eval(get(handles.edit22,'string'));

if(spec == 1); row=256; col=1024; end;
if(spec == 2); row=128; col=1024; end;
if(spec == 3); row=124; col=1024; end;
if(spec == 4); row=100; col=1340; end;


% Open Winspec calibration file left
calfilel=strcat(cpathl,cfilel);

fid=fopen(calfilel,'r');
headcl=fread(fid,[1025],'real*4');
caldatal=fread(fid,[col row],'real*4');
st=fclose(fid);

% Open Winspec calibration file right
calfiler=strcat(cpathr,cfiler)

fid=fopen(calfiler,'r');
headcr=fread(fid,[1025],'real*4');
caldatar=fread(fid,[col row],'real*4');
st=fclose(fid);

% open file w/ W-lamp spectral radiance values

if (spec == 1);
    [fid,message]=fopen('c:\MATLAB7\blackv3\E256.dat');
    for i=1:58; E(i) = fscanf(fid,'%f6.3') ; end;
    for i=1:58; lam(i)=460+i*10;end;
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;
    [lamp]= lampcal(w,lam,E);
    
elseif (spec == 2);
    [fid,message]=fopen('c:\MATLAB7\blackv3\E128.dat');
    for i=1:58; E(i) = fscanf(fid,'%f6.3') ; end;
    for i=1:58; lam(i)=430+i*10;end;
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;
    [lamp]= lampcal(w,lam,E);
    
elseif (spec == 4);
    [fid,message]=fopen('c:\MATLAB7\blackv3\E100.dat');
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
a=w

for m = fi:fl
    
    cnt=cnt+1;

    % Open unknown file

    if (m == fi);
    
        unkfile=strcat(upath,ufile);
        
        fid=fopen(unkfile,'r');
        headc=fread(fid,[1025],'real*4');
        unkdata=fread(fid,[col row],'real*4');
        st=fclose(fid);

    else

    cfi = int2str(m-1);

    cfl = int2str(m);

    pos = strfind(ufile, cfi);
    num = size(pos,2);

    ufile = regexprep(ufile, cfi, cfl, num);

    unkfile=strcat(upath,ufile);

    fid=fopen(unkfile,'r');
    headc=fread(fid,[1025],'real*4');
    unkdata=fread(fid,[col row],'real*4');
    st=fclose(fid);

end;

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
mnrow = mnrowl;
mxrow = mxrowl;

[temp,emmi,delta,nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);

templ = temp;
emmil = emmi;
nincall = nincal;
deltal = delta;

nin = ninr;
mnlam = mnlr;
mxlam = mxlr;
mnrow = mnrowr;
mxrow = mxrowr;

[temp,emmi,delta,nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);

tempr = temp;
emmir = emmi;
nincalr = nincal;
deltar = delta;

if emin == 1;
    eminautop;
end;

if ccnt == 6;
    ccnt = 1
else ccnt = ccnt+1
end;

avetempl(cnt)=mean(templ(mnrowl:mxrowl));
erravel(cnt)=mean(deltal(mnrowl:mxrowl));
maxtempl(cnt)=max(templ(mnrowl:mxrowl));
mintempl(cnt)=min(templ(mnrowl:mxrowl));
stdtempl(cnt)=std(templ(mnrowl:mxrowl));

avetempr(cnt)=mean(tempr(mnrowr:mxrowr));
erraver(cnt)=mean(deltar(mnrowr:mxrowr));
maxtempr(cnt)=max(tempr(mnrowr:mxrowr));
mintempr(cnt)=min(tempr(mnrowr:mxrowr));
stdtempr(cnt)=std(tempr(mnrowr:mxrowr));

lpixl=round(conl + lam1.*mnll + lam2.*mnll.^2);
hpixl=round(conl + lam1.*mxll + lam2.*mxll.^2);
xrangel=(1:row);

lpixr=round(conl + lam1.*mnlr + lam2.*mnlr.^2);
hpixr=round(conl + lam1.*mxlr + lam2.*mxlr.^2);
xranger=(1:row);

plot(handles.axes4, w(lpixr:hpixr),nincalr(lpixr:hpixr,mnrowr:mxrowr),'b');
plot(handles.axes3, w(lpixl:hpixl),nincall(lpixl:hpixl,mnrowl:mxrowl),'b');

errorbar(handles.axes1, xrangel(mnrowl:mxrowl),templ(mnrowl:mxrowl),deltal(mnrowl:mxrowl), colers(ccnt));
grid(handles.axes1,'on');
set(handles.axes1,'NextPlot','add');
set(handles.text22,'string',maxtempl(cnt));
set(handles.text26,'string',erravel(cnt));

errorbar(handles.axes2, xranger(mnrowr:mxrowr),tempr(mnrowr:mxrowr),deltar(mnrowr:mxrowr), colers(ccnt));
grid(handles.axes2,'on');
set(handles.axes2,'NextPlot','add');
set(handles.text24,'string',maxtempr(cnt));
set(handles.text28,'string',erraver(cnt));

if fl>1;
    figure(4),
    xlabel('n'), ylabel('Max T (K)'); 
    set(gca,'NextPlot','add');
    legend('Left','Right');
    plot(cnt,maxtempl(cnt),'--ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',10);
    plot(cnt,maxtempr(cnt),'--ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',10);   
end;
end