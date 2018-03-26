[sfile2,spath2]=uiputfile('.dat','Temperature Data ASCII file');

savefile2=strcat(spath2,sfile2);

if (em==0)
    
    if(tco==1)sd2=[xrange(mnrow:mxrow)',ctemp(mnrow:mxrow)'];end;
        
    if(tco==0)sd2=[xrange(mnrow:mxrow)',temp(mnrow:mxrow)'];end;

end;

if (em>0)
    
    if(tco==1)sd2=[xrange(mnrow:mxrow)',ctempem(mnrow:mxrow)'];end;
    
    if (tco==0)sd2=[xrange(mnrow:mxrow)',tempec(amc,mnrow:mxrow)'];end;

end;

dlmwrite(savefile2,sd2,'\t');