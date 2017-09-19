function []=crflux(threshold)
% Expected CR flux above thresold (in eV)
% OMH 20/10/09

delta_days = 1; %days
mindeg = 70;
maxdeg = 80;
%surf = 800*200; %TREND-15
%surf = 2700*500; %TREND-50
%surf = 2000*600; % GRANDproto35 
%surf = 220e3*270e3; % GRAND60000
surf = 200000*1e6; % GRAND200000
%surf = 3.14*500*500;  % LHASSO

delta_t = delta_days*3600*24;  %s

index1 = 3.26;  % Below ankle (10^18.6eV)
index2 = 2.65;  % Above ankle (10^18.6eV)
eankle = 10.^18.6;
emax = 10.^19.5;
pi = 3.1415927;
theta_min = mindeg * pi/180;
theta_max = maxdeg * pi/180;  % degrees
th = theta_min:0.0001:theta_max;

disp(sprintf('Erange = %3.1e - %3.1e eV, duration = %3.1f days, ground surface = %3.1f m2',threshold,emax,delta_days,surf))

solid_angle = 2*pi*trapz(th,sin(th))

disp(sprintf('Angular range: %3.1f - %3.1f deg -> solid angle = %3.1f sr, effective area = %3.1f m2sr.',mindeg,maxdeg,solid_angle,surf*solid_angle))
J1 = 1.06e29;  % Computed from http://arxiv.org/pdf/1511.07510.pdf
J2 = 4.5e17;  % Computed from http://arxiv.org/pdf/1511.07510.pdf
if threshold<eankle
  integ_flux1 = J1*delta_t*surf*solid_angle*(threshold^(-index1+1)-eankle^(-index1+1))/(index1-1)
  integ_flux2 = J2*delta_t*surf*solid_angle*(eankle^(-index2+1)-emax^(-index2+1))/(index2-1)
else
  integ_flux1 = 0
  integ_flux2 = J2*delta_t*surf*solid_angle*(threshold^(-index2+1)-emax^(-index2+1))/(index2-1)
end

integ_flux_tot = integ_flux1+integ_flux2

