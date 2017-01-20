%%  Draw houses
function []=house(x,y)
w1=line([x-20,x+20],[y+20,y+20]);
set(w1,'LineWidth',1,'LineStyle','-','Color','g');
w2=line([x+20,x+20],[y-20,y+20]);
set(w2,'LineWidth',1,'LineStyle','-','Color','g');
w3=line([x-20,x+20],[y-20,y-20]);
set(w3,'LineWidth',1,'LineStyle','-','Color','g');
w4=line([x-20,x-20],[y-20,y+20]);
set(w4,'LineWidth',1,'LineStyle','-','Color','g');
w5=line([x-20,x+20],[y-20,y+20]);
set(w5,'LineWidth',1,'LineStyle','-','Color','g');
w6=line([x-20,x+20],[y+20,y-20]);
set(w6,'LineWidth',1,'LineStyle','-','Color','g');

