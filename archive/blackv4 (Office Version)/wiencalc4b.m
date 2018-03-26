clear unkdata unkdatab caldata
%cnt=cnt+1;
ff=1;
tco=0;
em=0;


cfile = get(a1, 'String');  %calibration file
ufile = get(a2, 'String');  %unknown file
mnl = get(a3, 'String'); mnlam=eval(mnl); %Maximum wave length
mxl = get(a4, 'String'); mxlam=eval(mxl); %Minimum wave length 
mnr = get(a5, 'String'); mnrow=eval(mnr); %Maximum Row
mxr = get(a6, 'String'); mxrow=eval(mxr); %Minimum Row
%bns = get(a7, 'String'); bnsize=eval(bns); %Box size
bxs = get(a8, 'String'); bxsize=eval(bxs); %Box size
wem = get(a17, 'Value'); %Box size
fi = get(a18, 'Value'); %Box size
 = get(a19, 'Value'); %Box size

if(spec == 1); row=256; col=1024; end;
if(spec == 2); row=128; col=1024; end;
if(spec == 3); row=124; col=1024; end;
if(spec == 4); row=100; col=1340; end;


% Open Winspec calibration file

calfile=strcat(cpath,cfile);

fid=fopen(calfile,'r');
headc=fread(fid,[1025],'real*4');
caldata=fread(fid,[col row],'real*4');
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
    
    % standard lamp calibration (Raymonds Lamp)
    
    for i=1:col; w(i) = conp + pix1*i - pix2*i^2;end;

       x(1)=4.4577e-14;
       x(2)=-1.6226e-10;
       x(3)=2.4176e-7;
       x(4)=-.00019023;
       x(5)=.084359;
       x(6)=-19.976;
       x(7)=1961.7;

       lamp = polyval(x,w);


end;

for m = 9:15
    
cnt=cnt+1;

% Open unknown file

if (m == 9);
    
unkfile=strcat(upath,ufile);

fid=fopen(unkfile,'r');
headc=fread(fid,[1025],'real*4');
unkdata=fread(fid,[col row],'real*4');
st=fclose(fid);

else

fi = int2str(m-1);

fn = int2str(m);

unkfile = strrep(unkfile, fi, fn);

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

    nin = unkdatab./caldata;
    
else;
    
    nin = unkdata./caldata;
    
end;
    


divby = rot90(w.^5./3.7403E-12,3);

% normalized wavelength for Wien's Law fit
  
omega = (14384000.)./w;


[temp,j,etemp,delta] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);

tc=1;


 % Open Wien Fit and Temperature vs. Position Figures
 
  lpix=round(conl + lam1.*mnlam + lam2.*mnlam.^2);
  hpix=round(conl + lam1.*mxlam + lam2.*mxlam.^2);
  xrange=(1:row);
  

  % boxcar filter

if (bxsize > 0);
    
    for k = 1:bxsize;
    
      for i=mnrow:mxrow-4;
        
        tot=0;
    
        for m=0:4;
            tot=tot+temp(i+m);
        end
    
        temp(i+2)=tot./5;
    
    end;
    
end;

temp(mnrow)=temp(mnrow+2);
temp(mnrow+1)=temp(mnrow+2);
temp(mxrow)=temp(mxrow-2);
temp(mxrow)=temp(mxrow-2);

end; 

  avetemp(cnt)=mean(temp(mnrow:mxrow));
  errave(cnt)=mean(delta(mnrow:mxrow))
  maxtemp(cnt)=max(temp(mnrow:mxrow));
  mintemp(cnt)=min(temp(mnrow:mxrow));
  stdtemp(cnt)=std(temp(mnrow:mxrow));

  colers=char('r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b',...
'r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b',...
'r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b',...
'r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b','r','g','b','c','m','y','b');

  
 if (m==9) figure(h0),end;
 
  subplot('position',[0.28,0.72,0.67,0.25])
  set(gcf,'DefaultAxesColorOrder',[0 0 1])
  plot(omega(1,lpix:hpix),j(lpix:hpix,mnrow:mxrow));
  xlabel('omega'), ylabel('J'); 
  set(gca,'NextPlot','replacechildren');
  
  
 if (m==9) figure(h0), end;
 
  subplot('position',[0.28,0.07,0.67,0.56])
  %set(gcf,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1])
  errorbar(xrange(mnrow:mxrow),temp(mnrow:mxrow),delta(mnrow:mxrow),colers(cnt));
  grid on;
  xlabel('pixel'), ylabel('Temp (K)')
  set(gca,'NextPlot','add');
  
  

  % labeling the x axis

   % xspace = [0 32 64 96 128 160 192 224 256];
    %xnorm=(mnrow-1);
    %xname  = (xspace * 10)-(xnorm*10);

    %set(gca,'xtick',xspace);
    %set(gca,'XTickLabel',xname);
    
    
    
    mx=maxtemp(cnt);
    mn=mintemp(cnt);
    av=avetemp(cnt);
    sd=stdtemp(cnt);
    ea=errave(cnt)
    
    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[175 300 50 12], ...
	'String','maxtemp = ', ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

     h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[225 300 40 12], ...
	'String',mx, ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[175 290 50 12], ...
	'String','mintemp = ', ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[225 290 40 12], ...
	'String',mn, ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[175 280 50 12], ...
	'String','avetemp = ', ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[225 280 40 12], ...
	'String',av, ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[175 270 50 12], ...
	'String','aveerr = ', ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');

    h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
    'BackgroundColor',[0.8 0.8 0.8], ...
	'FontName','Geneva', ...
	'FontSize',8, ...
	'Position',[225 270 40 12], ...
	'String',ea, ...
	'Style','text', ...
    'HandleVisibility', 'on',...
	'Tag','StaticText1');  

end;    


    
 
  
  
 

