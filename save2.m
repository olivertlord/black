[sfile2,spath2]=uiputfile('.dat','Temperature Data ASCII file');

mnrowl = getappdata(0,'mnrowl');
mxrowl = getappdata(0,'mxrowl');
mnrowr = getappdata(0,'mnrowr');
mxrowr = getappdata(0,'mxrowr');
templ  = getappdata(0,'templ');
tempr  = getappdata(0,'tempr');
deltal = getappdata(0,'deltal');
deltar = getappdata(0,'deltar');
row    = getappdata(0,'row');

savefile2=strcat(spath2,sfile2);

xrange=(1:row);

sdl=[xrange(mnrowl:mxrowl)',templ(mnrowl:mxrowl)',deltal(mnrowl:mxrowl)'];
sdr=[xrange(mnrowr:mxrowr)',tempr(mnrowr:mxrowr)',deltar(mnrowr:mxrowr)'];
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

sd=horzcat(sdl,sdr);

dlmwrite(savefile2,sd,'\t');