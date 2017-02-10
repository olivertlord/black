%calculates temperature using wien's formulation

function [temp,j,etemp,delta] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col,unkdata);

omx=[ones(col,1),omega'];

for i=mnrow:mxrow;
     
     % Calculate unknown radiance for Wien's Law fit
     
	 unir(1:col,i) = nin(1:col,i) .* rot90(lamp(1:col),3);
     j(1:col,i) = log(unir(1:col,i) .* divby(1:col));     
      

     % Determine the best linear fit for a over selected wavelength range 
     
      lmsd = 100000000;   
      
      lpix=round(conl + lam1.*mnlam + lam2.*mnlam.^2);
      hpix=round(conl + lam1.*mxlam + lam2.*mxlam.^2); 
      
      if hpix>1024
          hpix=1024;
      end;
      
      if numel(find(isnan(unkdata(:,i)))) < length(unkdata(:,i))/100;
        
         [b,bint,stats]=regress(j(lpix:hpix,i),omx(lpix:hpix,:));
          
         temp(i)=-1/b(2);
         etemp(i)=-1/(bint(2));
         delta(i)=temp(i)-etemp(i);
         
         if delta(i) > 50
            [temp(i),etemp(i),delta(i),j(lpix:hpix,i),omega(lpix:hpix,i)] = deal(NaN);
         end
      
      else
         [temp(i),etemp(i),delta(i),j(lpix:hpix,i),omega(lpix:hpix,i)] = deal(NaN);
      end
end;