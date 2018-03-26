[sfile3,spath3]=uiputfile('.dat','Temperature Error Data ASCII file');

savefile3=strcat(spath3,sfile3);

if (em==0) sd3=[xrange(mnrow:mxrow)',delta(mnrow:mxrow)'];end;

if (em>0) sd3=[xrange(mnrow:mxrow)',deltec(amc,mnrow:mxrow)'];end;

dlmwrite(savefile3,sd3,'\t');