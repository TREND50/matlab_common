function [rho theta phi]=Convert2Sph(x,y,z)

    SharedGlobals;
    x = x-REFWE;
    y = y-REFSN;
    z = z-REFALT;
    
    rho=(x.^2+y.^2+z.^2).^0.5; 
    rho_xy = (x.^2+y.^2).^0.5; 
    theta=acos(z./rho)*RAD2DEG(1);
    xp=find(x>=0);
    phi(xp) = 360-acos(y(xp)./rho_xy(xp))*RAD2DEG(1);
    xn=find(x<0);
    phi(xn) = acos(y(xn)./rho_xy(xn))*RAD2DEG(1)';
    phi = mod(phi,360);
    theta = mod(theta,360);
    theta(union(find(imag(theta)),find(imag(phi))))=0;
    phi(union(find(imag(theta)),find(imag(phi))))=0;
    % Column vectors
    if size(theta,1)==1
        theta = theta';
    end
    if size(phi,1)==1
        phi = phi';
    end    
end