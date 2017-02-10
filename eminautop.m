rp=0;
clear tempec; clear deltec; clear aveerr;

win=570; %initial wavelength
wra=200; %wavelength range 

mnll=win; 
mxll=mnll+wra;
mnlr=win;
mxlr=mnlr+wra;

lc=0;
avemin=1000;

while (mxll<850)
    lc=lc+1;
    mn(lc)=mnll
    mx(lc)=mxll
    
    nin = ninl;
    mnlam = mnll;
    mxlam = mxll;
    mnrow = mnrowl;
    mxrow = mxrowl;
    
	[tempec(lc,:),emmi,deltec(lc,:),nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);
    mnll=mnll+10;
    mxll=mxll+10;
    aveerr_left(lc)=mean(deltec(lc,mnrowl:mxrowl));
    
    if(aveerr_left(lc)<avemin); 
        avemin=aveerr_left(lc);
        amc=lc
    end;
    
    templ = tempec(amc,:);
    emmil = emmi;
    nincall = nincal;
    deltal = deltec(amc,:);
    maxtempl = max(templ(mxrowl:mnrowl));
    
    set(handles.edit7,'string',mn(amc));
    set(handles.edit8,'string',mx(amc));    
end;

win=570;
wra=200;

lc=0;
avemin=1000;

while (mxlr<850)
    lc=lc+1;
    mn(lc)=mnlr
    mx(lc)=mxlr
    
    nin = ninr;
    mnlam = mnlr;
    mxlam = mxlr;
    mnrow = mnrowr;
    mxrow = mxrowr;
    
	[tempec(lc,:),emmi,deltec(lc,:),nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);
    mnlr=mnlr+10;
    mxlr=mxlr+10;
    aveerr_right(lc)=mean(deltec(lc,mnrowr:mxrowr))
    
    if(aveerr_right(lc)<avemin); 
        avemin=aveerr_right(lc);
        emmir = emmi;
        nincalr = nincal;
        amc=lc
    end;
    
    tempr = tempec(amc,:);
    deltar = deltec(amc,:);
    maxtempr = max(tempr(mxrowr:mnrowr));
    
    set(handles.edit15,'string',mn(amc));
    set(handles.edit16,'string',mx(amc));    
end;