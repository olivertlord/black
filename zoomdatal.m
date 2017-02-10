function zoomdatal(mnrowl, mxrowl);

set(handles.edit9,'string',mnrowl);
set(handles.edit10,'string',mxrowl);
setappdata(0,'mnrowl',mnrowl);
setappdata(0,'mxrowl',mxrowl);


end

