function [ ft, filename ] = OpenFileData( nrun, antenna,coincid)
% Ouvre le fichier time correspondant ? l'antenne rep?r?e par le
% num?ro antenna, dans le run rep?r? par le num?ro nrun.

SharedGlobals;
if SelectedData
        PATH = SELDATA_PATH;
        filename = sprintf( 'S%06d_A%04d_data.bin', nrun, antenna );
else
        PATH = RAWDATA_PATH;
        filename = sprintf('R%06d_A%03d_data.bin',nrun,antenna);
end;
ft = fopen( [ PATH, filename ], 'r' );
if ft == -1
  filename = sprintf( 'R%d_%d_data.bin', nrun, antenna );
  ft = fopen( [ PATH, filename ], 'r' );
end
% Now check for subdir
PATH = [PATH sprintf('R%06d/',nrun)];
if ft == -1
  filename = sprintf( 'R%06d_A%04d_data.bin', nrun, antenna );
  ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%04d_u%d_data.bin' ,nrun, antenna );
  ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%05d_%d_data.bin' ,nrun, antenna );
  ft = fopen( [ PATH, filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%02d_%d_data.bin', nrun, antenna );  % Selected data
  ft = fopen( [ RAWDATA_PATH filename ], 'r' );
end
if ft ==-1
  filename = sprintf( 'R%03d_%d_data.bin', nrun, antenna );  % Selected data
  ft = fopen( [ RAWDATA_PATH filename ], 'r' );
end
if exist('coincid')
    PATH = sprintf('../data/raw/');
    filename = sprintf( 'R%06d_A%04d_C%d_data.bin',nrun, antenna,coincid )
    ft = fopen( [ PATH, filename ], 'r' );
end