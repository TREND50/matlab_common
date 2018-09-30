function data = ReadPSD( nrun, antenna, varargin )
% Read PSD files
% VN March 2011
% Adaptated 08/06/2011 OMH
% Change files path 14/07 TS


% Parse inputs
%===
NPAR = 2*ones( size( antenna ) );
if ~isempty( varargin )
if length( varargin{ 1 } ) == 1
  if strcmp( varargin{ 1 }, 'old' )
    NPAR = 0*ones( size( antenna ) );    
  end      
else
  for k = 1:length( antenna )
    if strcmp( varargin{ 1 }{ k }, 'old' )
      NPAR( k ) = 0;    
    end  
  end
end
end

data = [];
dataAllRuns = [];
for k = 1:length( antenna )
  for l = 1:length(nrun)
     datanew = ReadPSD1( nrun(l), antenna( k ), NPAR( k ) ) ; 
     % Chain data (if exists) for all runs
     if size(datanew,1)>0
         if l==1
             dataAllRuns = datanew;
         else
             dataAllRuns.psd = [ dataAllRuns.psd datanew.psd];
             dataAllRuns.t = [ dataAllRuns.t datanew.t];
             dataAllRuns.ttot = [ dataAllRuns.ttot datanew.ttot];
             dataAllRuns.mu = [ dataAllRuns.mu datanew.mu];
             dataAllRuns.sigma = [ dataAllRuns.sigma datanew.sigma];
         end
     end
  end
  data = [data dataAllRuns];
end


  
function data = ReadPSD1( nrun, antenna, NPAR )

  % Settings
  %===
  SharedGlobals;
  N         = NFFT + NPAR;
  % Read data
  %===
  %strfile = [PSD_PATH sprintf('R%06d/R%06d_A%04d_PSD_data.bin',nrun,nrun,antenna)];
  strfile = [PSD_PATH sprintf('R%06d_A%04d_PSD_data.bin',nrun,antenna)];
  
  fid = fopen( strfile );
  if fid < 0  %Old format
     %disp(sprintf( 'Error in READ_PSD\n could not find file %s', strfile ) )
     strfile = [PSD_PATH sprintf('PSD%05d/PSD%05d_%d_data.bin', nrun,nrun, antenna )];
     fid = fopen( strfile );
  end  
  if fid <= 0
    data = [];
    disp( sprintf( 'Error in READ_PSD\n could not find file %s', strfile ) );
    return
  end
  d = fread( fid, inf, 'float32' );
  fclose( fid );

  d = reshape( d, N, [] );

  df = 0.5*FSAMPLING/N;
  F  = [ 1:NFFT ]*df;
  P  = 10*log10( d( 1:NFFT, : )*SCALE^2/df/0.3743 ); %0.3743 arrises from Hann window  [V^2/Hz]dB
  if NPAR > 0
    mu  = d( NFFT+1, : );
    sig = d( NFFT+2, : );
  else
    mu  = [];
    sig = [];
  end

  % Read time
  %===
  %strfile = [PSD_PATH sprintf('R%06d/R%06d_A%04d_PSD_time.bin', nrun, nrun, antenna )];
  strfile = [PSD_PATH sprintf('R%06d_A%04d_PSD_time.bin', nrun, antenna )];
  fid = fopen( strfile );
  if fid < 0  %Old format
     strfile = [PSD_PATH sprintf('R%06d/PSD%05d_%d_time.bin', nrun, nrun, antenna )];
     fid = fopen( strfile );
  end  
  if fid >= 0
    d = fread( fid, [ 4, inf ], 'int32' );
    fclose( fid );
    Tdeb = min(d(1,:));
    T   = d( 1, : ) - Tdeb;
    flg = d( 3, : ) - d( 2, : );
  else
    T = [];
    flg = [];
    Tdeb = 0;
  end
  
  % Clean
  %===
  if length( T ) > 0
    nmin = min( [ size( P, 2 ), length( T ) ] );
    P = P( :, 1:nmin );
    T = T( 1:nmin );
    flg = flg( 1:nmin );
    if length( mu > 0 )
      mu = mu( 1:nmin );
      sig = sig( 1:nmin );
    end
  end
 
  % Pack results
  %===
  data.id = antenna;
  data.psd   = P;
  data.f     = F;
  data.t     = T;
  data.ttot     = Tdeb+T; %[s]
  data.tdeb  = Tdeb;
  data.flag  = flg;
  data.mu    = mu;
  data.sigma = sig;
