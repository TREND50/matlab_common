function [ pp ] = ModelGain( g,f )
% Performs a polynomial modelling of the raw Gain (or PSD) function
% given as g as a function of f
% Returns the poly coefs.
% Valentin March 2011
% OMH 16/06/2011
%
SharedGlobals;

k1 = floor(NFFT/2)+2; % Lower bound ~50 MHz
k2 = floor(NFFT)-3; % Upper bound ~100 MHz
K  = [ k1:k2 ];
J1 = [ 1:(k1-1) ];
J2 = [ (k2+1):NFFT ];

x1 = f( J1 );
x2 = [ f( J2 ),  [ 200:100:1000 ]*1e6 ];
x  = [ x1, f( K ), x2 ];
y  = [ BoardFilterModel( x1 ) + g( k1-1 ) - BoardFilterModel( f( k1-1 ) ), ...
       g( K ), ...
       BoardFilterModel( x2 ) + g( k2+1 ) - BoardFilterModel( f( k2+1 ) ) ];
pp = spline( x, y );


end

