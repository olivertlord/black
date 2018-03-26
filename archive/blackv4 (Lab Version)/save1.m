[sfile1,spath]=uiputfile('.dat','Wien or Planck Fits ASCII file');

savefile1=strcat(spath,sfile1);

if (ff==1) sd1=[omega(lpix:hpix)',j(lpix:hpix,mnrow:mxrow)];end;

if (ff==2) sd1=[w(1,lpix:hpix)',nincal(lpix:hpix,mnrow:mxrow)];end;

dlmwrite(savefile1,sd1,'\t');
