

function [lamp] = lampcal(w,lam,E)

% loop to locate wavelengths used for interpolation

for i=1:1024;
    
    x=w(i);
    
    for j=1:58;
        
    
        if x > lam(j);
            if x < lam(j+1);
              j0=j;
            break;
            end;
        end;
       
    end;
  

% interpolation of spectral radiance using Legrange's formula

    D=0;
    
    for k=0:3;
        xk = (lam(j0-1))+ k*10;
        pt=1;
        
        for l=0:3;
           xl=(lam(j0-1))+l*10;
           if l~=k;
             p=(x-xl)./(xk-xl);
             pt=pt.*p;
           end;
        end;
        Ek=pt.*E((j0-1)+k);
        D=D+Ek;
    end;
    lamp(i)=D;
end;