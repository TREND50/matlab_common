function []=crossPointEnvir()
% Environment for cross point
% OMH 17/01/10

hold on
warning off
%% Road
% road1=line([-200 -200],[330 1000 ]); 
% set(road1,'LineWidth',5,'LineStyle','-','Color','k');
% road2=line([-200 500],[330 330 ]); 
% set(road2,'LineWidth',5,'LineStyle','-','Color','k');

Xro = [-448 -98 0 130 1212 1302 1375 2449 2571 2636 4256];
Yro = [544 367 333 322 356 367 379 645 661 667 567];
Pro = polyfit(Xro',Yro',5);
Xrofit = [-448 -98:130 1212:1375 2449:2636 4256];
Yrofit = zeros(1,size(Xrofit,2));
for i = 1:size(Pro,2)
    Yrofit = Yrofit + Pro(i)*Xrofit.^(size(Pro,2)-i);
end
plot(Xrofit,Yrofit,'-b','LineWidth',2)

%% Power lines
hv1 = line([-300 -20],[171.25 145]); 
set(hv1,'LineWidth',3,'LineStyle','-','Color','r');
hv2=line([-20 1695],[145 470]); 
set(hv2,'LineWidth',3,'LineStyle','-','Color','r');
hv21=line([1775 3260],[430 565]); 
set(hv21,'LineWidth',3,'LineStyle','-','Color','r');
hv3=line([-300 260],[115-(260+300)*(115-40)/(260+195) 115]); 
set(hv3,'LineWidth',3,'LineStyle','-','Color','r');
hv4=line([260 260],[115  -320]); 
set(hv4,'LineWidth',3,'LineStyle','-','Color','r');
hv41=line([265 375],[105 -155]); 
set(hv41,'LineWidth',3,'LineStyle','-','Color','r');
hv42=line([265 208],[105 230]); 
set(hv42,'LineWidth',3,'LineStyle','-','Color','r');
hv43=line([208 -50],[230 300]); 
set(hv43,'LineWidth',3,'LineStyle','-','Color','r');
hv5=line([260 350],[-320  -320]); 
set(hv5,'LineWidth',3,'LineStyle','-','Color','r');
hv6=line([375 1416],[-155  -200]); 
set(hv6,'LineWidth',3,'LineStyle','-','Color','r');
hv7=line([1416 1477],[-200  -205]); 
set(hv7,'LineWidth',3,'LineStyle','-','Color','r');
hv8=line([-195 -195],[40  700]); 
set(hv8,'LineWidth',3,'LineStyle','-','Color','r');
hv9=line([1695 1775],[470  430]); 
set(hv9,'LineWidth',3,'LineStyle','-','Color','r');
hv10=line([3260 3410],[565  560]); 
set(hv10,'LineWidth',3,'LineStyle','-','Color','r');
hv11=line([3345 3345],[563  -100]); 
set(hv11,'LineWidth',3,'LineStyle','-','Color','r');

%% Train
%myCircle(-1000,-1980,2000)
Xtr = [-586 -423 -227 -108 0 179 285 358 643 708 789 871 960 1050 1155 1619 1709 1806 1994 2075 2156 2246 2319 3084 3190 3287 3369 3458 4027];
Ytr = [-211 -200 -211 -233 -289 -389 -456 -522 -822 -867 -911 -933 -955 -945 -922 -733 -711 -700 -700 -689 -679 -645 -611 -189 -144 -122 -111 -111 -167];
Ptr = polyfit(Xtr',Ytr',15);
Xtrfit = [-586:358 643:1155 1619:1806 1994:2319 3084:3458 4027];
Ytrfit = zeros(1,size(Xtrfit,2));
for i = 1:size(Ptr,2)
    Ytrfit = Ytrfit + Ptr(i)*Xtrfit.^(size(Ptr,2)-i);
end
plot(Xtrfit,Ytrfit,'--b','LineWidth',2)

%% Houses
house(350,-300)
house(230,230)
house(-70,300)
house(-250,500)
house(-80,500)


%% Transfos
% plot(270,100,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(1422,-210,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(1510,-210,'pm','MarkerFace', 'm', 'MarkerSize', 12 );

% plot(1416,-200,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(1477,-205,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(1765.9,426.4,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(1690.6,469.8,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(3347.6,356,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(3260.6,564.3,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(3414.3,560.2,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(254,120.6,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(258.8,-131.6,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(-25,146.6,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(-203.8,96.3,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
% plot(-205.7,44,'pm','MarkerFace', 'm', 'MarkerSize', 12 );

plot(1416,-200,'pm','MarkerFace', 'm', 'MarkerSize', 12 );

%plot(1477,-205,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(1476,-206,'pm','MarkerFace', 'm', 'MarkerSize', 12 );

plot(1775,430,'pm','MarkerFace', 'm', 'MarkerSize', 12 );

%plot(1695,470,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(1684,460.5,'pm','MarkerFace', 'm', 'MarkerSize', 12 );

plot(3345,365,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(3260,565,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(3410,560,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(260,115,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(260,-135,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(-20,145,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(-195,95,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(-195,40,'pm','MarkerFace', 'm', 'MarkerSize', 12 );
plot(-180,160,'pm','MarkerFace', 'm', 'MarkerSize', 12 );


%% Residence
plot(1490,-50,'sr','MarkerFace', 'r', 'MarkerSize', 12 );


warning on

