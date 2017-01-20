function [x y z]=Convert2Cart(rho,theta,phi)

SharedGlobals;

minutes = 0;
if minutes
% Transform minutes in decimals
theta_m=(theta-floor(theta))*100;
theta=floor(theta)+theta_m*1/60;
phi_m=(phi-floor(phi))*100;
phi=floor(phi)+phi_m*1/60;
end
x=-double(rho.*sind(theta).*sind(phi))+REFWE;
y=double(rho.*sind(theta).*cosd(phi))+REFSN;
z=double(rho.*cosd(theta)+REFALT);


end