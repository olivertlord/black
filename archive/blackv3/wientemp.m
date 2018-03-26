%calculates temperature using wien's formulation

function [temp,j,etemp,delta] = wientemp(nin,divby,omega,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);

omx=[ones(col,1),omega'];

for i=mnrow:mxrow;
     
     % Calculate unknown radiance for Wien's Law fit
     
	 unir(1:col,i) = nin(1:col,i) .* rot90(lamp(1:col),3);
     j(1:col,i) = log(unir(1:col,i) .* divby(1:col));     
      

     % Determine the best linear fit for a over selected wavelength range 
     
      lmsd = 100000000; 
        
      lpix=round(conl + lam1.*mnlam + lam2.*mnlam.^2);
      hpix=round(conl + lam1.*mxlam + lam2.*mxlam.^2);      
     
      %[p,s] = polyfit(rot90(omega(1,lpix:hpix),3),j(lpix:hpix,i),1);
     % [y,delta]=polyval(p,rot90(omega(1,lpix:hpix),3),s);
      %sd=sum(delta);
      %msd(i)=sd;
      
       
        [b,bint,stats]=regress(j(lpix:hpix,i),omx(lpix:hpix,:));
      
      
      
      
      temp(i)=-1/b(2);
      etemp(i)=-1/(bint(2));
      delta(i)=temp(i)-etemp(i);
      
 end;
  
  %legend(file)
     
 	
    
  
  %avetemp=mean(temp)
  %stdtemp=std(temp)
  %maxtemp=max(temp)
  


  
 
  
  
  
  