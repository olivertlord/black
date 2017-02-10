[sfile1,spath]=uiputfile('.dat','Wien or Planck Fits ASCII file');

mnrowl = getappdata(0,'mnrowl')
mxrowl = getappdata(0,'mxrowl');
mnrowr = getappdata(0,'mnrowr');
mxrowr = getappdata(0,'mxrowr');
omega  = getappdata(0,'omega');
w      = getappdata(0,'w');
jr     = getappdata(0,'jr');
jl     = getappdata(0,'jl');
nincall= getappdata(0,'nincall');
nincalr= getappdata(0,'nincalr');
lam1   = getappdata(0,'lam1');
lam2   = getappdata(0,'lam2');
conl   = getappdata(0,'conl');
ff     = getappdata(0,'ff');

mnll = eval(get(handles.edit7,'string'))
mxll = eval(get(handles.edit8,'string'));

mnlr = eval(get(handles.edit15,'string'));
mxlr = eval(get(handles.edit16,'string'));

lpixl=round(conl + lam1.*mnll + lam2.*mnll.^2);
hpixl=round(conl + lam1.*mxll + lam2.*mxll.^2);

lpixr=round(conl + lam1.*mnlr + lam2.*mnlr.^2);
hpixr=round(conl + lam1.*mxlr + lam2.*mxlr.^2);

savefile1=strcat(spath,sfile1);

if (ff==1) sdl=[omega(lpixl:hpixl)',jl(lpixl:hpixl,mnrowl:mxrowl)];
           sdr=[omega(lpixr:hpixr)',jr(lpixr:hpixr,mnrowr:mxrowr)];
           [x1,y1]=size(sdl);
           [x2,y2]=size(sdr);
           
           if (x1>x2) diff=x1-x2;
              add=zeros(diff,y2);
              sdr=vertcat(sdr,add);
           end;
         
           if (x2>x1) diff=x2-x1;
              add=zeros(diff,y1);
              sdl=vertcat(sdl,add);
           end;
           
end;

if (ff==2) sdl=[w(lpixl:hpixl)',nincall(lpixl:hpixl,mnrowl:mxrowl)];
           sdr=[w(lpixr:hpixr)',nincalr(lpixr:hpixr,mnrowr:mxrowr)];
           [x1,y1]=size(sdl);
           [x2,y2]=size(sdr);
           
           if (x1>x2) diff=x1-x2;
              add=zeros(diff,y2);
              sdr=vertcat(sdr,add);
           end;
         
           if (x2>x1) diff=x2-x1;
              add=zeros(diff,y1);
              sdl=vertcat(sdl,add);
           end;

end;
       
sd=horzcat(sdl,sdr);
       
dlmwrite(savefile1,sd,'\t');
