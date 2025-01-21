    maxpix = 1024;
    lsteps = 45;
    wsteps = lsteps;
    min_step = 20;
    min_width = 124;
    
        spix = repmat([0:min_step:maxpix-min_width]',[1 wsteps+1])
            size(spix)
    epix = spix+repmat([min_width:(maxpix-min_width)/wsteps:maxpix],[wsteps+1 1])
    
    
    

    
    spix(spix==0)=1;
    epix(epix>1024)=NaN;
    spix(isnan(epix))=NaN;
    
    