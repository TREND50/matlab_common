function [lst,jd]=utdate2lst(date_gregorienne, lgtde);
%exemple d'utilisation utdate2lst([2007 10 26 10 24 00])
%permet d'obtenir l'heure LST le 26 octobre 2007 ? 10H24
%la date gregorienne, est l'heure UTC.


% TIME HAS TO BE GIVEN IN UT (Ulastai-8)


% UTDATE2STL.M
% 
% fonction permettant de convertir une date format dst en Temps Sideral
% Local (lst) par defaut a Nancay.
% 
% Syntaxe : lst=date2lst(date,lgtde);
% 
% par Arnaud, le 29/06/06.

if ~exist('lgtde')
    %lgtde=2.11; %Nancay
    lgtde=86.71; % Ulastai 86°43.04?
    %lgtde=91;
end

sidereal_coeff =   [280.46061837 360.98564736629 0.000387933 38710000];
%sidereal_coeff =   [100.46061837 36000.770053608 0.000387933 38710000];

J2000 = 2451545.0;
Dtohr=24.0/360.0;

 
switch size(date_gregorienne,2)
    case {6}
        sec=date_gregorienne(:,6);
        min=date_gregorienne(:,5);
        hour=date_gregorienne(:,4);
        jour=date_gregorienne(:,3);
        month=date_gregorienne(:,2);   
        year=date_gregorienne(:,1);
    case {5}
        min=date_gregorienne(:,5);
        hour=date_gregorienne(:,4);
        jour=date_gregorienne(:,3);
        month=date_gregorienne(:,2);   
        year=date_gregorienne(:,1);
    case {4}
        hour=date_gregorienne(:,4);
        jour=date_gregorienne(:,3);
        month=date_gregorienne(:,2);   
        year=date_gregorienne(:,1);
    case {3}
        jour=date_gregorienne(:,3);
        month=date_gregorienne(:,2);   
        year=date_gregorienne(:,1);
    case {2}
        month=date_gregorienne(:,2); 
        year=date_gregorienne(:,1);
    case {1}
        year=date_gregorienne(:,1);
end
%hour=hour-8; % To be in UT time. OK even if negative
jour=jour+hour./24+min./(24*60)+sec./(24*3600);

year(find(month<=2))=year(find(month<=2))-1;
month(find(month<=2))=month(find(month<=2))+12;
 
a = (floor(year./100.));
b = 2 - a + a/4;

jd = floor(365.25*(year+4716))+floor(30.6001*(month+1))+jour+b-1524.5;

%  longitude stays in degrees here and is positive eastwards
 dt = jd-J2000;
 dt0 = dt / 36525.;
 theta = sidereal_coeff(1) + dt .* sidereal_coeff(2) + dt0 .* dt0 .* ( sidereal_coeff(3) - dt0 ./ sidereal_coeff(4) ); 
%   original J. Meeus: longitude is positive westwards  *lst = mod(theta-longitude,360.) * kSTC::Dtohr;
%   with the new convention for longitudes (positive eastwards) :

lst = mod(theta+lgtde,360.) *Dtohr;
heure_LST=floor(lst);
mins = (lst-heure_LST)*60;
minutes=floor(mins);
secondes= (mins-minutes)*60;

