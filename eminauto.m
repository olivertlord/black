rp=0;
clear tempec; clear deltec; clear aveerr_left; clear aveerr_right;

win=570; %initial wavelength
wra=200; %wavelength range 

mnll=win; 
mxll=mnll+wra;
mnlr=win;
mxlr=mnlr+wra;

amc=1;
lc=0;
avemin=1000000;

while (mxll<850)
    lc=lc+1;
    mn(lc)=mnll;
    mx(lc)=mxll;
    
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
    
    [tempec(lc,:),j,etemp,deltec(lc,:)] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col,unkdata);
    
    mnll=mnll+10;
    mxll=mxll+10;
    [x,y]=max(tempec(lc,:));
    aveerr_left(lc)=deltec(lc,y);
      
    if(aveerr_left(lc)<avemin); 
        avemin=aveerr_left(lc);
        jl = j;
        etempl = etemp;
        amc=lc;
    end;
    
    templ = tempec(amc,:);
    deltal = deltec(amc,:);
    
    mnl = mn(amc);
    mxl = mx(amc);
     
    set(handles.edit7,'string',mn(amc));
    set(handles.edit8,'string',mx(amc));    
end;

figure(5)
plot (aveerr_left,'O')
set(5,'name','Error LEFT','position', [5, 327, scrsz(3)/7, scrsz(4)/6],'Menubar','none','Toolbar','none');

win=570;
wra=200;

mnll=win; 
mxll=mnll+wra;
mnlr=win;
mxlr=mnlr+wra;

lc=0;
avemin=1000000;

clear tempec; clear deltec; clear aveerr; clear mn; clear mx;

while (mxlr<850)
    lc=lc+1;
    mn(lc)=mnlr;
    mx(lc)=mxlr;
    
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
    
	[tempec(lc,:),j,etemp,deltec(lc,:)] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col,unkdata);
      
    mnlr=mnlr+10;
    mxlr=mxlr+10;
    [x,y]=max(tempec(lc,:));
    aveerr_right(lc)=deltec(lc,y);
    
    if(aveerr_right(lc)<avemin); 
        avemin=aveerr_right(lc);
        jr = j;
        etempr = etemp;
        amc=lc;
    end;
    
    tempr = tempec(amc,:);
    deltar = deltec(amc,:);
   
    mnr = mn(amc);
    mxr = mx(amc);

    set(handles.edit15,'string',mn(amc));
    set(handles.edit16,'string',mx(amc));    
end;

figure(6)
plot (aveerr_right,'O')
set(6,'name','Error RIGHT','position', [380, 327, scrsz(3)/7, scrsz(4)/6],'Menubar','none','Toolbar','none');