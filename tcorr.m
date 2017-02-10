clear deltecx deltax;

mnrowl = getappdata(0,'mnrowl');
mxrowl = getappdata(0,'mxrowl');
deltal = getappdata(0,'deltal');
templ  = getappdata(0,'templ');
mnrowr = getappdata(0,'mnrowr');
mxrowr = getappdata(0,'mxrowr');
deltar = getappdata(0,'deltar')
tempr  = getappdata(0,'tempr');
row    = getappdata(0,'row');
ccnt   = getappdata(0,'ccnt');
colers = getappdata(0,'colers');

for i=mnrowl:mxrowl
    
      deltecx(i)=deltal(i)-2.;
      ctempem(i)=templ(i) - (-0.0216*(deltecx(i)*deltecx(i))+17.882*deltecx(i));    
end;

xrangel=(1:row);

mx=max(ctempem(mnrowl:mxrowl));
mn=min(ctempem(mnrowl:mxrowl));
av=mean(ctempem(mnrowl:mxrowl));

plot(handles.axes1,xrangel(mnrowl:mxrowl),ctempem(mnrowl:mxrowl), colers(ccnt),'LineWidth',2);
grid(handles.axes1,'on');
set(handles.axes1,'NextPlot','add');
set(handles.text22,'string',mx);
set(handles.text26,'string',av);

for i=mnrowr:mxrowr
    
      deltecx(i)=deltar(i)-2.;
      ctempem(i)=tempr(i) - (-0.0216*(deltecx(i)*deltecx(i))+17.882*deltecx(i));    
end;

xranger=(1:row);

mx=max(ctempem(mnrowr:mxrowr));
mn=min(ctempem(mnrowr:mxrowr));
av=mean(ctempem(mnrowr:mxrowr));

plot(handles.axes2,xranger(mnrowr:mxrowr),ctempem(mnrowr:mxrowr), colers(ccnt),'LineWidth',2);
grid(handles.axes2,'on');
set(handles.axes2,'NextPlot','add');
set(handles.text24,'string',mx);
set(handles.text28,'string',av);