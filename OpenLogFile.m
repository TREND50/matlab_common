function [nspikeb ntrigb lsb tmn] = OpenLogFile( nrun, antenna, dis )
% Read log file for antenna ant in nrun ant
% Taken from AnaLog
% OMH 14/03/2014

SharedGlobals;

nspikeb = 0;
ntrigb = 0;
lsb = 0;
tmn = 0;

filename = sprintf( 'R%06d_A%04d_log.txt', nrun, antenna ); 
filename = [LOG_PATH, filename];
if fopen(filename)<0
    disp(sprintf('Could not find file %s',filename))
    return
end
logfile=load(filename);
%time_step = 2^28*5e-9; % time to write a buffer
tloop = logfile(:,1); % Time at begining of reading loop
% tidle =  logfile(:,2); % Waiting time after reading 1/2 buffer 
% tanat0 =  logfile(:,3); % Time to scan for spikes (T0) 
% tanat1 =  logfile(:,4); % Time to scan for coincs (T1)
% twrite =  logfile(:,5); % Time to write data to file
% tprocess = tanat0 + tanat1 + twrite;
% ttot = tidle + tprocess;
% iloop = logfile(:,6);
% irqs =  logfile(:,7);
% irqe =  logfile(:,8);
nspikeb = logfile(:,9);
ntrigb = logfile(:,10);
lsb = logfile(:,11);
tmn = (tloop-tloop(1))/60;

%spikerate = nspikeb/time_step;
%trigrate = ntrigb/time_step;

%check = irqe-irqs;
%nlate = length(find(check>=1));
%nverylate = length(find(check>2));
%durlate = time_step*sum(nlate)/60; % minutes
    
%ns = nspiket(end);
%nt = ntrigt(end);
%r = nt/tmn(end)/60;
%f = nt/ns*100;

%disp(sprintf('Run %d Antenna %d - %3.1f mins', nrun, antenna, tmn(end)))
%disp(sprintf('%d spikes (av rate = %3.1f Hz) & %d events recorded (av rate = %3.1f Hz). Ratio = %3.2f pc.',ns,mean(spikerate),nt,mean(trigrate),f))
%disp(sprintf('Out of scync for %d buf(s) ( = %3.2f mn, %3.2f pc of acq time)',nlate,  durlate, durlate/tmn(end)*100))


