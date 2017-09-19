function [pos_ant pos_sci] = LayoutProto(  )
% Plot layout for R&D proto TREND-inclined
% OMH 19/11/2012

SharedGlobals;

already = 0 % Antennas installed at present, with full array if 1; alone if 2
elevation = 0
yS13 = 385

figure(1)
xmin = -600;
xmax = 600;
ymin = 200;
ymax = 2500;
set(1, 'Name', 'GRANDproto layout','NumberTitle','off');
%axis([xmin,xmax,ymin,ymax])

if elevation
  [x,y,z] = getMap('map.bin',[xmin,xmax,ymin,ymax]);
  contourf(x,y-yS13,z,40)
  colormap bone
  colorbar
  %axis equal
end
xlabel( 'Easting [ m ]', labelOpts{:} );
ylabel( 'Northing [ m ]', labelOpts{:} );
hold on    

%% Pods
% Load position file
pods = load('pods.txt');
id_pod = pods(:,1)-140;  % Only displaying SN pods here
xpos_pod = pods(:,2);
ypos_pod = pods(:,3)-yS13;
zpos_pod = pods(:,4);
%
px=3.031;
py=2.57;
xpod=[-3*px -3*px 0 3*px 3*px 0 -3*px];
ypod=[3*py -3*py -6*py -3*py 3*py 6*py 3*py];
for i=1:length(xpos_pod)
  if ypos_pod(i)>0
    if already <2
        plot(xpos_pod(i),ypos_pod(i),'dk','MarkerSize',8,'MarkerFaceColor','w');
    else  % Only present antennas
        plot(xpod+xpos_pod(i),ypod+ypos_pod(i),'k'); % Plot full shape
    end
    sign = 1-4*(i/2-floor(i/2));
    if id_pod(i)<=20 & id_pod(i)>0
      text( xpos_pod(i)+10, ypos_pod(i), sprintf('S%02d',id_pod( i )), 'FontSize', 8, 'FontWeight', 'bold', 'Color','g' );
    elseif id_pod(i)>20
      text( xpos_pod(i)+10, ypos_pod(i), sprintf('N%02d',id_pod( i )-20), 'FontSize', 8, 'FontWeight', 'bold', 'Color','g' );
    end
    %text( xpos_pod(i)-10+sign*40, ypos_pod(i), num2str( id_pod( i ) ), 'FontSize', 8, 'FontWeight', 'bold', 'Color','g' );
   end
end

%% Antennas
for i = 1:4 % lines
    stepx = 200;
    stepy = 400;
    offx = -400;
    offy = 2380;
    for j = 1:5  % rows
        ypos_ant(5*(i-1)+j)=  offy - (i-1)*stepy;   %going down
        xpos_ant(5*(i-1)+j) = offx + (j-1)*stepx;
    end
end
for i = 5:7 % rows
    stepx = 150;
    stepy = 250;
    offx = -300;
    offy = ypos_ant(5*(4-1)+1)-300;   % last line
    for j = 1:5  % 5 lines
        ypos_ant(5*(i-1)+j)=  offy - (i-5)*stepy;   %going down
        xpos_ant(5*(i-1)+j) = offx + (j-1)*stepx;
    end
end

if elevation
  zpos_ant = getElevation(xpos_ant,ypos_ant);
  [xpos_ant; ypos_ant; zpos_ant]'
  %pause
end
xpos_ant(end-4:end) = xpos_ant(end-4:end)+50; 
ypos_ant = ypos_ant-yS13;
[xpos_ant; ypos_ant;]'

%% Scints
for i = 1:4 %6 rows
    for j = 1:4  % 4 lines
        ypos_sci(4*(i-1)+j)= 2200 - (i-1)*400;
        xpos_sci(4*(i-1)+j) = -300 + (j-1)*200;
    end
end
for i = 5:6 % rows
    stepx = 150;
    stepy = 250;
    offx = -200;
    offy = ypos_sci(4*(4-1)+1);   % last line
    for j = 1:4  % 4 ro lines
        ypos_sci(4*(i-1)+j)=  offy - (i-4)*stepy;   %going down
        xpos_sci(4*(i-1)+j) = offx + (j-1)*stepx;
    end
end

pos = load('posGRANDproto35.txt');
id = pos(:,1);  % Only displaying SN pods here
xpos = pos(:,2);
ypos = pos(:,3);
apos = [xpos(id>0) ypos(id>0)];
spos = [xpos(id<0) ypos(id<0)];

if elevation 
   zpos_sci = getElevation(xpos_sci,ypos_sci);
   pos_sci = [xpos_sci' ypos_sci' zpos_sci'];
end
ypos_sci = ypos_sci-yS13;
[xpos_sci' ypos_sci']

%% Plot
if already<2
%   plot(xpos_ant,ypos_ant,'^k','MarkerSize',8)
%   hold on
%   plot(xpos_sci,ypos_sci,'sr','MarkerSize',8)
  plot(apos(:,1),apos(:,2),'^k','MarkerSize',8,'MarkerFaceColor','y')
  hold on
  plot(spos(:,1),spos(:,2),'sr','MarkerSize',8,'MarkerFaceColor','r')
end

%% Already installed ants
dets = [1:6 111:116]; 
aera = [1 3 6];
aeraname = [127 105 126];

if already>0
  [pos_ant,podN,machines,delay,cable,isSci]=SetupCharacteristics_GRANDproto(dets,6985);
  for i = 1:size(pos_ant,1)
        if isSci(i) == 0
          plot(pos_ant(i,1),pos_ant(i,2),'^k','MarkerSize',8,'MarkerFaceColor','y')
          ind = find(aera==dets(i))
          if size(ind,2)>0
            plot(pos_ant(i,1),pos_ant(i,2),'^b','MarkerSize',10,'MarkerFaceColor','b')
            text( pos_ant(i,1)+20, pos_ant(i,2), ['A' num2str( aeraname( ind ) )], 'FontSize', 12, 'FontWeight', 'bold', 'Color','k' );
          else
            text( pos_ant(i,1)+20, pos_ant(i,2), ['A' num2str( dets( i ) )], 'FontSize', 12, 'FontWeight', 'bold', 'Color','k' );
          end
          display(sprintf('Antenna %d at position (%3.1f, %3.1f, %3.1f)m: cable length = %3.1f m)', dets(i),pos_ant(i,1), pos_ant(i,2), pos_ant(i,3),cable(i)))          
        else
          plot(pos_ant(i,1),pos_ant(i,2),'sr','MarkerSize',8,'MarkerFaceColor','r')
          text( pos_ant(i,1)+20, pos_ant(i,2), ['S' num2str( dets(i) )], 'FontSize', 12, 'FontWeight', 'bold','Color','k' );
          display(sprintf('Scintillator %d at position (%3.1f, %3.1f, %3.1f)m: cable length = %3.1f m)', dets(i),pos_ant(i,1), pos_ant(i,2), pos_ant(i,3),cable(i)))
        end
        hold on
   end
   grid on
   %axis([-200 200 360 760]) 
end
title('GRANDproto35', labelOpts{:})
grid on
%axis equal
%axis([xmin,xmax,ymin,ymax])
%crossPointEnvir()