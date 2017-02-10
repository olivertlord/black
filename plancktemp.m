function [temp,emmi,delta,nincal] = plancktemp(nin,w,lamp,conl,lam1,lam2,mxlam,mnlam,mxrow,mnrow,col);

x0=[0.01 3000];

c=0;

wx=[ones(col,1),w'];

for i=mnrow:mxrow;
     
      % Calculate unknown radiance for Planck's Law fit
         
      nincal(1:col,i) = nin(1:col,i) .* rot90(lamp(1:col),3);
 
      lmsd = 100000000; 
        
      lpix=round(conl + lam1.*mnlam + lam2.*mnlam.^2)
      if lpix>1024
        lpix=1024;
      end;
      
      hpix=round(conl + lam1.*mxlam + lam2.*mxlam.^2) 
      if hpix>1024
        hpix=1024;
      end;
              
      [x,resids,J] = nlinfit( (w(lpix:hpix))',nincal(lpix:hpix,i), 'planck', x0);
      
      ci = nlparci(x,resids,J);
      
      c=c+1;
        
      temp(i) = x(:,2);
      emmi(i)= x(:,1);
      delta(i)=temp(i)-ci(2,1);
 end;




  
 
  
  
  
  