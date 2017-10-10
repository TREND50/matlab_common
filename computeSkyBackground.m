function [] = computeSkyBackground(fmin,fmax)
% Determine bckgrnd noise level from sky 
% in frequency rane [fmin,fmax] assuming full sky coverage
% fmin & fmax in Hz
% OMH 13/12/15

SharedGlobals;

c= 3e8;
kb = 1.38e-23;   %J/K
eps_0 = 8.8e-12;
% Crane 1971 data
fMHz = [10.05 14.1 18.3 20.0 30.0 48.5 55.0 85.0 153.0];
T = [3.8e5 1.3e5 7.5e4 5.5e4 1.7e4 5.1e3 4.0e3 1.2e3 240];


f = fMHz*1e6; %Hz
I = 2*kb*f.^2.*T/c^2;  % Sky brightness (Rayleigh-Jeans approx) W/m²/sr/Hz
par = FitLin(f(f>=30e6),log10(I(f>=30e6)),[1 1 ],0);
fth = (20:5:300)*1e6;
Ith = 10.^(par(1).*fth+par(2));
P = trapz(fth(fmin<=fth & fth<=fmax),Ith(fmin<=fth & fth<=fmax))*2*pi  %W/m²/s
E_eff = sqrt(2*P/(eps_0*c))
par(1)

figure(1)
subplot(2,1,1)
semilogy(fMHz,T)
grid on
xlabel('Frequency [MHz]', labelOpts{:})
ylabel('Sky temperature  [K]', labelOpts{:});
subplot(2,1,2)
semilogy(fMHz,I)
hold on
grid on
semilogy(fth*1e-6,Ith,'g','LineWidth',3)
xlabel('Frequency [MHz]', labelOpts{:})
ylabel('Sky brightness  [W/m²/sr/Hz]', labelOpts{:})



