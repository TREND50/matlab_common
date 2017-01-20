function [ std_theta, std_phi ] = ComputeScintDirError(Struct, theta, phi )
% Taken from coputeDirError (Valentin)
% Compute reconstruction error for scintillator data
% OMH 14/09/2011

SharedGlobals;

thetar = theta*pi/180.0;
phir   = phi*pi/180.0;

u_t = [ -cos(thetar)*sin(phir),  cos(thetar)*cos(phir), -sin(thetar) ];
u_p = [ -sin(thetar)*cos(phir), -sin(thetar)*sin(phir),            0 ];

SetupStruct = Struct.Setup;
X = [SetupStruct.Det.X];
Y = [SetupStruct.Det.Y];
Z = [SetupStruct.Det.Z];
DetectorType = [Struct.Setup.Det.isScint];

X = [X(DetectorType==1)' Y(DetectorType==1)' Z(DetectorType==1)'];  % Scintillators positions
L = size( X, 1 );
X = [ mean( X, 1 ); X ];

a_t = zeros( L+1, L+1 );
a_p = zeros( L+1, L+1 );

for i=1:L
  for j=i+1:L+1
    a_t( i, j ) = ( X( i, : ) - X( j, : ) )*u_t';
    a_p( i, j ) = ( X( i, : ) - X( j, : ) )*u_p';
    a_t( j, i ) = a_t( i, j );
    a_p( j, i ) = a_p( i, j );       
  end
end

tt   =  a_t( 2:end, 2:end ).*a_t( 2:end, 2:end );
pp   =  a_p( 2:end, 2:end ).*a_p( 2:end, 2:end );
tp   =  a_t( 2:end, 2:end ).*a_p( 2:end, 2:end );
b_tt = 0.5*sum( tt( : ) );
b_pp = 0.5*sum( pp( : ) );
b_tp = 0.5*sum( tp( : ) );

delta = b_tt*b_pp - b_tp^2;
dtdt  = L/delta*( a_t( 2:end, 1 )*b_pp - a_p( 2:end, 1 )*b_tp );
dpdt  = L/delta*( a_p( 2:end, 1 )*b_tt - a_t( 2:end, 1 )*b_tp );

deltat = ErrorTrigScint*C0/FSAMPLING;
std_theta = sqrt( sum( dtdt.^2 ) )*deltat*180/pi;
std_phi   = sqrt( sum( dpdt.^2 ) )*deltat*180/pi;

%disp( sprintf( 'Typical error: theta = %3.1f pm %3.1f deg, phi = %3.1f pm %3.1f deg',theta, std_theta, phi, std_phi ) );
