function [ data ] = GetPSD( nrun,sec, Antennas )
% Get the PSD at closest time to seccond sec
% for antennas Antennas.
% OMH 09/06/2011

SharedGlobals;

N = length(Antennas);
i = 0;
while length(bad)>1
    for k = 1:length(bad)
        strfile = [PSD_PATH sprintf('PSD%05d_%d_data.bin', nrun+i, Antennas(k) )];
        fid(k) = fopen( strfile );
        strfile = [PSD_PATH sprintf('PSD%05d_%d_data.bin', nrun+i, Antennas(k) )];
        fid(k) = fopen( strfile );
    end
end


