%calculates temperature using wien's formulation

function [temp,emmi,delta,nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);

x0=[0.01 3000];

for i=mnrow:mxrow;
     
     % Calculate unknown radiance for Planck's Law fit
     
	% unir(1:col,i) = nin(1:col,i) .* rot90(lamp(1:col),3);
        
      

     % Determine the best linear fit for a over selected wavelength range 
     
      lmsd = 100000000; 
        
      lpix=round(conl + lam1.*mnlam + lam2.*mnlam.^2);
      hpix=round(conl + lam1.*mxlam + lam2.*mxlam.^2);      
     
      %[p,s] = polyfit(rot90(omega(1,lpix:hpix),3),j(lpix:hpix,i),1);
     % [y,delta]=polyval(p,rot90(omega(1,lpix:hpix),3),s);
      %sd=sum(delta);
      %msd(i)=sd;
    
      
     nincal(1:col,i) = nin(1:col,i) .* rot90(lamp(1:col),3);

       
        %[b,bint,stats]=regress(j(lpix:hpix,i),omx(lpix:hpix,:));
        
        [x,resids,J] = nlinfit( w(lpix:hpix), nincal(lpix:hpix,i), 'planck', x0);
      
        ci = nlparci(x,resids,J);
      
      
      temp(i) = x(2,:);
      emmi(i)= x(1,:);
      delta(i)=temp(i)-ci(2,1);
      
 end;
  
  %legend(file)
     
 	
    
  
  %avetemp=mean(temp)
  %stdtemp=std(temp)
  %maxtemp=max(temp)
  


  
 
  
  
  
  