function [sortie temps] = PassBand(entree,temps,freqmin,freqmax);
% PASSBAND.M - Syntaxe : [sortie] = passband(entree,temps,freqmin,freqmax);
% Permet de realiser un filtrage passe bande a [freqmin,freqmax] du signal "entree"
% au travers d'un filtre porte et de retourner le signal filtre a la fonction
% appelante. Le filtrage s'effectue en appliquant une fonction "porte" bornee
% par freqmin et freqmax au spectre de y obtenu par FFT. Tout ce qui est en
% dehors de la porte est mis a 0, ce qui est dans la porte est conserve. On
% effectue ensuite la FFT inverse pour retrouver le signal temporel filtre.
% 
% BUG : les vecteurs d'entree doivent IMPERATIVEMENT etre constitues d'un
% nombre pair de points!! Sans quoi le resultat de sortie est faux!!!
%
% Syntaxe : [sortie] = passband(entree,temps,freqmin,freqmax);

% Derniere mise a jour : 16/02/04 - R. Dallier

% Verification des entrees
%if (exist('freqmin')==0), freqmin=37e6; end;
%if (exist('freqmax')==0), freqmax=70e6; end;
%if (freqmax <= freqmin), freqmin=37e6; freqmax=70e6; end;

% Synthese du signal temporel 
N=length(entree);
if floor(N/2)~=N/2
    disp 'PassBand.m: problem! Odd number of points. Skipping last one.'
    entree = entree(1:end-1);
    temps = temps(1:end-1);
    N = length(entree);
elseif N<2
    disp 'N too short!'
end

fe=(N-1)/(temps(N)-temps(1));
f=linspace(-fe/2-fe/2/N,fe/2-fe/2/N,N);

% Synthese du filtre
G=zeros(N,1);
i=find((f>=freqmin)&(f<=freqmax));
j=fliplr(N-i+2);
G(i)=ones(size(i));
G(j)=ones(size(j));

% Filtrage et inversion du spectre
Y=fftshift(fft(entree));
%size(Y)
%size(G)
if size(Y,2)~=size(G,2)
    Y = Y';
end
S=Y.*G;
sortie=real(ifft(fftshift(S)));

% Fin de PASSBAND.M