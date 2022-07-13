function PlotAll

c=hgload('MLPDist.fig');
k=hgload('MLMDist.fig');
t=hgload('CiaoDist.fig');
m=hgload('YMDist.fig');
z=hgload('GBDist.fig');
% Prepare subplots
figure
h(1)=subplot(3,2,1);
h(2)=subplot(3,2,2);
h(3)=subplot(3,2,3);
h(4)=subplot(3,2,4);
h(5)=subplot(3,2,5);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));
copyobj(allchild(get(t,'CurrentAxes')),h(3));
copyobj(allchild(get(m,'CurrentAxes')),h(4));
copyobj(allchild(get(z,'CurrentAxes')),h(5));
% Add legends
l(1)=legend(h(1));
l(2)=legend(h(2));
l(3)=legend(h(3));
l(4)=legend(h(4));
l(5)=legend(h(5));
% Add tittles
title(h(1),'ML-100K');
title(h(2),'ML-1M');
title(h(3),'Ciao');
title(h(4),'YM');
title(h(5),'GB');
% Add xlabels
xlabel(h(1),'Items');
xlabel(h(2),'Items');
xlabel(h(3),'Items');
xlabel(h(4),'Items');
xlabel(h(5),'Items');


% Add ylabels
ylabel(h(1),'Blockbuster Score');
ylabel(h(3),'Blockbuster Score');
ylabel(h(5),'Blockbuster Score');


return
end
