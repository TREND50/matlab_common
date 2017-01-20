function [theta, phi]=fitplan_3(param)

% La convention adoptee pour l'orientation de l'azimut est celle de CODALEMA:
% azimuth 0 degres au NORD, positif vers l'OUEST jusqu'a
% 360 degres, dans le sens trigonometrique. 
% Le zenith est compris entre 0 degres
% (zenith, ? la verticale) et 90 degres (sol).
%
%
% L'unite des valeurs du tableau des temps est la seconde.
%
% Ce programme est bas? sur COORDONNEES, par F. Haddad & R. Dallier

% Structure param:
% col1: detectorID col2: coordSN col3: -coordWE col4: alt col5: t
v=2.99792458e8;
t=param(:,5)*5.e-9;  %temps en secondes


%param(:,1)
%t=[-20 0 0]'*5e-9  % For test

%changement de plan
u1=param(1,2:4); %a1
u2=param(2,2:4); %a2
u3=param(3,2:4); %a3
%u2-u1 % Vecteur a1a2
%u3-u1  % Vecteur a1a3
n=cross(u2-u1,u3-u1); %produit vectoriel 
n=-n/norm(n);  % vecteur normal au plan de detection

% psi=angle zenithal du plan de d?tection
if (sign(n(3))==1)
    psi=acos(n(3));
else
    psi=acos(n(3))-pi;
end

% omega: angle azimuthal du plan de d?tection
if (sign(n(1))==1),
    omega=atan(n(2)/n(1));
else
    omega=atan(n(2)/n(1))+pi;
end
omega = mod(omega,2*pi);

psi;
omega;
%psi=0 
%omega=0


% construction de la matrice de passage dans le ref des antennes
P=[cos(psi)*cos(omega) cos(psi)*sin(omega) -sin(psi); 
   -sin(omega) cos(omega) 0 ; 
   sin(psi)*cos(omega) sin(psi)*sin(omega) cos(psi) ];
P;
%coco


% calcul des coordonnees des antennes dans le nouveau repere
v1=P*u1';
v2=P*u2';
v3=P*u3';

x2=[v1(1); v2(1); v3(1)]; %x
y2=[v1(2); v2(2); v3(2)]; %y
z2=[v1(3); v2(3); v3(3)]; %z

    %------------------------------------------
    % Construction de la Matrice resultats 
    % de la minimisation du Khi2
    %------------------------------------------

    A(1,1)=sum(x2.^2);
    A(1,2)=sum(x2.*y2);
    A(1,3)=sum(x2);
     
    A(2,1)=sum(x2.*y2);
    A(2,2)=sum(y2.^2);
    A(2,3)=sum(y2);
    
    A(3,1)=A(1,3);
    A(3,2)=A(2,3);
    A(3,3)=3;
    
    A;
    
    B(1)=v*sum(x2.*t);
    B(2)=v*sum(y2.*t);
    B(3)=v*sum(t);
    B;

    
	% Coordonnees du vecteur V normal au plan de la gerbe:
    % V2 = alpha.x + beta.y + gamma.z = c.(t-t0) 
	% alpha=v(1); beta=v(2) et gamma2 = 1-alpha2-beta2 
    
    V2=A\B';
    % means B=A*V2
    gamma2=1-V2(1)^2-V2(2)^2;
    gamma=sqrt(gamma2);
    V2(3)=-gamma;
    
    % Back to true coordinates
    V=P\V2;
    % means V2=P*V
    theta=acos(-V(3))*180/pi;
    if imag(theta)~=0
       theta=90;  % Set theta to 90? if complex, because this may be due to plane approximation (close source)
    end
    % angle azimuth, a la direction sud et dans le sens trigonometrique 
    
    if (sign(V(1))==-1), 
        phi=atan(V(2)/V(1))*180/pi;
    else
        phi=atan(V(2)/V(1))*180/pi+180;
    end
    %phi=real(phi);
        
%phi = mod(phi,360)

