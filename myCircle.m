function []=myCircle(x0,y0,R,col) 
% Draw circle of radus R at position x0,y0
% OMH 24/03/10

   if ~exist('col')
       col = 'r';
   end
   
   x = x0-R+1:1:x0+R-1;
   yp = y0+(R.^2-(x-x0).^2).^0.5;
   yn = y0-(R.^2-(x-x0).^2).^0.5;
   plot(x,yp,col,'LineWidth',2)
   plot(x,yn,col,'LineWidth',2)
   
%    yp = y0+(50.^2-(x-x0).^2).^0.5;
%    yn = y0-(50.^2-(x-x0).^2).^0.5;
%    plot(x,yp,'k--','LineWidth',2)
%    plot(x,yn,'k--','LineWidth',2)

   if R==50  % corresponding to 100%
      plot(x,yp,'g-','LineWidth',1)
      plot(x,yn,'g-','LineWidth',1)
   end