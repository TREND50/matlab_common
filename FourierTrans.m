function [f,X,M]=FourierTrans(x,t,inverse)
% TFOU.M
% Extraction des coefficients de Fourier a une dimension.
%
% Syntaxe : [frequences,spectre,module]=tfou(x,t)
%
% x est la fonction "temporelle", de meme dimension que le vecteur "temps" t
% (une taille en puissance de 2 est souhaitable).
% spectre est la TF complexe, et module le module de spectre. Ce vecteur contient 
% les "coefficients de Fourier" (vecteur dont les extremes correspondent a -fe et + fe).
% f represente la frequence en unites reciproques, de -fe a +fe.
%
% Exemple d'utilisation, pour test :
% t=linspace(0,20,512) ;
% x=sin(4*pi*t)+randn(size(t));
% [f,X,C]=tfou(x,t);
% plot(f,C);
% grid on;
% xlabel('Frequence en unites-1');

if ~exist('inverse')
    inverse=0;
end
% Fabrication du tableau des frequences
n=length(t) ;
fe=(n-1)/(t(n)-t(1)) ;
f=linspace(-fe/2-fe/2/n,fe/2-fe/2/n,n) ;

if inverse==0
    % Transformee de Fourier et recadrage
    X=fftshift(fft(x)) ;
    M=abs(X) ;
else% Transformee de Fourier et recadrage
    X=ifft(fftshift(x));
    %X = ifft(x);
    M=abs(X) ;
end
    

