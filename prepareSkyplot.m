function []=prepareSkyplot(skyplot)
% Set an empty skyplot
% OMH 18/09/09

figure(skyplot);
set(skyplot, 'Name', 'Skyplot');
set(skyplot, 'PaperUnits', 'centimeters');
set(skyplot, 'PaperType','A4');
set(skyplot,'Color','white');
set(skyplot,'DefaultTextRotation',0,'DefaultTextFontSize',12,'DefaultTextFontWeight','bold');
set(skyplot,'DefaultTextColor','black');
set(skyplot,'DefaultTextHorizontalAlignment','center','DefaultTextVerticalAlignment','middle')
set(skyplot,'DefaultLineLineWidth',2.);

maxz=100;
polar(0,maxz);
set(gca,'YDir','reverse')

hold('on');
set(gca,'DataAspectRatio',[1,1,1])
text(-maxz-20,0,'South');
text(maxz+20,0,'North');
text(0,+maxz+30,'West');
text(0,-maxz-30,'East');
view([-90 90]);