function []=crflux(threshold)
% Expected CR flux above thresold (in eV)
% OMH 20/10/09

proton = 1
delta_days = 365; %days
mindeg = 65;
maxdeg = 85;
%surf = 800*200; %TREND-15
%surf = 2700*500; %TREND-50
%surf = 2000*600; % GRANDproto35 
surf = 4*1e6; %GRANDproto300 dense
%surf = 300*1e6; %GRANDproto300 sparse
%surf = 220e3*270e3; % GRAND60000
%surf = 10000*1e6; % GRAND10k
%surf = 200000*1e6; % GRAND200k
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

apperture = 2*pi*trapz(th,sin(th).*cos(th)*surf);
disp(sprintf('Angular range: %3.1f - %3.1f deg -> aperture = %3.1f km2.sr',mindeg,maxdeg,apperture/1e6))
J1 = 1.06e29;  % [eV-1.m-2.sr-1.s-1] computed from http://arxiv.org/pdf/1511.07510.pdf
J2 = 4.5e17;  % Computed from http://arxiv.org/pdf/1511.07510.pdf

yr = 3600*24*365;  
eexp =log10(threshold):0.01:21;
ee = 10.^eexp; %eV
flux1=J1*ee.^(-index1)*1e6*yr;
flux2=J2*ee.^(-index2)*1e6*yr;

E = [1e-13    0.5000    0.7000    0.8000    1.0000    2.0000    3.0000    5.0000    7.0000   10.0000   20.0000   30.0000]; %units = 1e17
fluxbef = 3.6e6*(E*1e8).^-3.; 
flux = 2.3*10^8.6*(E*1e8).^-3.3; 
%fluxbef = 3.6e6*((ee/1e17)*1e8).^-3. 
%flux = 2.3*10^8.6*((ee/1e17)*1e8).^-3.3 
fluxtot = [fluxbef(E<1) flux(E>=1)];

figure(17)
loglog(ee(ee<10^18.6),flux1(ee<10^18.6),'LineWidth',2)
hold on
grid on
loglog(ee(ee>=10^18.6),flux2(ee>=10^18.6),'LineWidth',2)
loglog(E*1e17,fluxbef*1e6*yr*1e-9,'--','LineWidth',2)
loglog(E*1e17,flux*1e6*yr*1e-9,'--','LineWidth',2)
xlabel('Energy (eV)')
ylabel('J(E) (eV-1.km-2.sr-1.yr-1)')


if (proton ==1) % 100%proton
  exponocuts = 1e6*[0         0    0.0042    0.0184    0.0422    0.3355    0.9768    1.8599    2.8844    3.4933    4.3464    5.0667];
  exponocutserr = 1e5*[0         0    0.0320    0.0959    0.1594    0.9108    1.8722    3.2481    4.7541    4.0852    4.7377    5.5614];
  expoideal=[0 65187 275813 389024 821112 2611884 5311879 7517272 8953226 9741657 12036321 14256592];
  expoidealerr=[0 16667 37803 50634 78773 278586 436583 657432 887724 698874 847564 1037412];
else % Mixed 50% proton - 50% iron 
  exponocuts =  1.0e+006 *[0 0   0.002670194210854   0.012318860322185   0.034330649768991   0.350541709261532   0.916552544511205   1.800620442842769  2.727427214673336   3.536252447289700   4.303124911175575   5.350327734245754];
  exponocutserr =  1.0e+005 *[0 0   0.022579753183177   0.064739727943288   0.137952050902698   0.990635937106108   1.804937654673849   3.142901000853733   4.440327266258902   4.615710737709737   4.833428845761360   5.875693154969537];
  expoideal =  1.0e+007 *[0   0.004865200000000   0.021606750000000   0.035372900000000   0.070523700000000   0.253558400000000   0.500757700000000   0.753707550000000   0.894004600000000   1.025063150000000   1.200166500000000   1.432410450000000];
  expoidealerr =  1.0e+006 *[0   0.012453500000000   0.033840000000000   0.049711500000000   0.071199500000000   0.291776000000000   0.426897000000000   0.693389000000000   0.837785000000000   0.789041000000000   0.870281500000000   1.040767500000000];
end

figure(42)
errorbar(E,exponocuts,exponocutserr)
hold on
errorbar(E,expoideal,expoidealerr)

dt=251*3600*24;
EGeV=E*1e17./1e9;
figure(32)
subplot(211)
loglog(EGeV,fluxtot)
subplot(212)
loglog(EGeV,expoideal.*fluxtot)
hold on
loglog(EGeV,exponocuts.*fluxtot)
totIdeal=trapz(EGeV,expoideal.*fluxtot*dt)
totNoCuts=trapz(EGeV,exponocuts.*fluxtot*dt)
pause

if threshold<eankle
  evt1 = J1*delta_t*apperture*(threshold^(-index1+1)-eankle^(-index1+1))/(index1-1)
  evt2 = J2*delta_t*apperture*(eankle^(-index2+1)-emax^(-index2+1))/(index2-1)
  integ_flux1 = J1*(threshold^(-index1+1)-eankle^(-index1+1))/(index1-1)*yr*1e6
  integ_flux2 = J2*(eankle^(-index2+1)-emax^(-index2+1))/(index2-1)*yr*1e6
else
  evt1 = 0
  evt2 = J2*delta_t*apperture*(threshold^(-index2+1)-emax^(-index2+1))/(index2-1)
  integ_flux1 = 0
  integ_flux2 = J2*(eankle^(-index2+1)-emax^(-index2+1))/(index2-1)*yr*1e6
end

integ_flux_tot = integ_flux1+integ_flux2
evt_tot = evt1+evt2
