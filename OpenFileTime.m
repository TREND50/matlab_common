function [ ft, filename ] = OpenFileTime( nrun, antenna)
% Ouvre le fichier time correspondant ? l'antenne rep?r?e par le
% num?ro antenna, dans le run rep?r? par le num?ro nrun.

SharedGlobals;

if SelectedData
   PATH = SELDATA_PATH;
   filename = sprintf( 'S%06d_A%04d_time.bin', nrun, antenna ); 
else
   PATH = RAWDATA_PATH;
   filename = sprintf('R%06d_A%03d_time.bin',nrun,antenna);
end;
ft = fopen( [ PATH, filename ], 'r' );
%[ PATH, filename ]
% Now check for subdir
if ft == -1
  PATH = [PATH sprintf('R%06d/',nrun)];
  ft = fopen( [ PATH, filename ], 'r' );
end
%[ PATH, filename ]

if ft == -1
    filename = sprintf( 'R%06d_A%04d_time.bin', nrun, antenna );
    ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%04d_u%d_time.bin' ,nrun, antenna );
  ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%05d_%d_time.bin' ,nrun, antenna );
  ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'S%06d_A%04d_time.bin', nrun, antenna );  % Selected data
  ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%02d_%d_time.bin', nrun, antenna );  % Selected data
  ft = fopen( [ RAWDATA_PATH filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%03d_%d_time.bin', nrun, antenna );  % Selected data
  ft = fopen( [ RAWDATA_PATH filename ], 'r' );
end

