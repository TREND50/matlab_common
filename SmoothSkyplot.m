function smap = SmoothSkyplot(theta,phi,figid,thrange,phirange,weight)
% OMH 27/06/2013

%% Setup skymap matrix
nl = 500;
nc = 500;
ix = 1:nl;
iy = 1:nc;
sky = 0;
th_cut = 80;

if ~exist('thrange')
    thrange = 0:th_cut;
end
thmin = thrange(1);
thmax = thrange(end);

if ~exist('phirange')
    phirange = 0:360;
end
phimin = phirange(1);
phimax = phirange(end);


if ~exist('weight')
    weight = ones(size(theta));
end
if ~exist('figid')
    figid = 3;
end

smap = 0.1*ones(nl,nc);  %Skymap matrix
if sky ==1
    x = 2/(nl-1)*(ix-1)-1;  % x axis values
    y = 2/(nc-1)*(iy-1)-1;  % y-axis value
    %horiz = sind(th_cut);
else
    x = 180/(nl-1)*(ix-1)-90;  % x axis values
    y = -180/(nc-1)*(iy-1)+90;  % y-axis value
    %horiz = thmax;
end

%% Skyplot
for k = 1:length(phi)
  phie = phi(k);
  the = theta(k);
  
  % PSF
  %[ sig_th, sig_ph ] = computeDirError( 3600, the, phie );  % To be completed
    sig_th = 3+0.5e-5*the^3;
    sig_ph = 2;
    sig_x = sqrt((cosd(the)*sind(phie)*sig_th)^2+(sind(the)*cosd(phie)*sig_ph)^2);
    sig_y = sqrt((cosd(the)*cosd(phie)*sig_th)^2+(sind(the)*sind(phie)*sig_ph)^2);
    sig_i = (nl-1)/2*sig_x;
    sig_j = (nc-1)/2*sig_y;
    %     
    if sky == 1
        sig = sqrt(sig_i^2+sig_j^2);
        xe = sind(the)*sind(phie);
        ye = sind(the)*cosd(phie);
    else
        sig = sqrt(sig_th^2+sig_ph^2)*nc/180*30;
        xe = the*sind(phie);
        ye = the*cosd(phie);
    end
    disp(sprintf('Candidate %d: th = %3.1f pm %3.1f deg, phi = %3.1f pm %3.1f deg. Sig tot = %3.1f pixels.',k,the,sig_th,phie,sig_ph,sig))
    [a indx] = min(abs(x-xe));
    [a indy] = min(abs(y-ye));

    [R,C] = ndgrid(1:nl, 1:nc);
    smap = smap + weight(k).*gaussC(R,C, sig, [indx,indy]);
end

for i = 1:nl
    for j=1:nc
      if sqrt(x(i)^2+y(j)^2)>thmax | sqrt(x(i)^2+y(j)^2)<thmin
          smap(i,j)=-0.1;
      end
      %atand(x(i)/y(j))
      if (atand(x(i)/y(j)))>phimax | (atand(x(i)/y(j)))<phimin | y(j)<0
          smap(i,j)=-0.1;
      end  
    end
end

% Plot
%smap = smap/max(max(smap));
figure(figid)
h = surf(smap);
colorbar;
hold on
plot3(nl/2,nc/2,1.01,'k+','MarkerSize',20)
%colormap('bone')
axis equal
grid off
if sky == 1
    view([90 -90]);
else
    view([90 90]);
end
set(h,'FaceColor','interp','EdgeColor','interp')


function val = gaussC(x, y, sigma, center)
xc = center(1);
yc = center(2);
exponent = ((x-xc).^2 + (y-yc).^2)./(2*sigma);
val       = (exp(-exponent));    
