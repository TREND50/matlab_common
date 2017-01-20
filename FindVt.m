function[vpeakpeak,tmoy]=FindVt(v2,trig,deltat)

% Trouve dans la fonction d'onde v2 le maximum, le minimum, leur temps, et
% calcule vpeakpeak et la correction ? apporter au temps de l'?v?nement.
% Voir pp.m


[vmax,kmax]=max(v2);
[vmin,kmin]=min(v2);

tmax=trig+(kmax-deltat-1);
tmin=trig+(kmin-deltat-1);
tmoy=(tmax+tmin)/2;
vpeakpeak=vmax-vmin;
