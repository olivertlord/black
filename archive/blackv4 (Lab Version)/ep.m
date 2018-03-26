figure('position',[300 200 500 300],'Color',[1 1 1]),
subplot('position',[0.15 0.15 0.8 0.75])



x=[700 650 620 610 600 590 580 570 550 530]

plot(x,errave(2:11),'ok')


xlabel('minimum nm','Fontsize',12,'FontName','Arial','FontWeight','bold'), 
ylabel('Ave T Error (K)','Fontsize',12,'FontName','Arial','FontWeight','bold');
set(gca,'FontName','Arial','FontWeight','bold')