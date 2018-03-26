clear m x gn

for m=1:31;
    m;
    x(m)=m*2;
    
    
    t(m)=[temp(m+119)];
    et(m)=[delta(m+119)];
    ex(m)=0;
    
end;

%figure('position',[300 200 500 300],'Color',[1 1 1]),
subplot('position',[0.15 0.15 0.8 0.75])
%errorbar(temps(:,15),errtemp(:,15));


errorbar(x,t,et,et,'k');
hold on;
plot(x,t,'k','linewidth',2)


xlabel('microns','Fontsize',12,'FontName','Arial','FontWeight','bold'), 
ylabel('Temperature (K)','Fontsize',12,'FontName','Arial','FontWeight','bold');
set(gca,'FontName','Arial','FontWeight','bold')