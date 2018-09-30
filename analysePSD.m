function [] = analysePSD(run,antenna,col,film,figid)

%clear all;
%close all;

if ~exist('film')
    film = 0;
end
if ~exist('col')
    %col = 'ks';
    col = 'k-';
end
if ~exist('figid')
    figid = 1;
end
%film = 0;
scrsz = get( 0, 'ScreenSize' );
d = ReadPSD( run, antenna );
if size(d,1)==0
    disp(sprintf('No data found for antenna %d', antenna))
    return
end

[y m day h mn s] = UnixSecs2Date(d.tdeb);
ut = (h*3600+mn*60+s+d.t)/3600; % [h]
loct = ut+8;
loct = mod(loct,24); % Hour in UT
lstdeb = utdate2lst([y m day h mn s]);
lst = lstdeb+d.t/3600;  % 
lst = mod(lst,24);
bw = find( d.f>=0e6 & d.f<=100e6);
Fbp = d.f(bw);
Pbp = d.psd(bw);
G = mean( d.psd( d.f > 35e6 & d.f < 95e6, : ), 1 );
Glin = 10.^(G/10);
Vrms = sqrt(Glin*40e6)*1e3;  % [mV]

%% Plot
figure( antenna );
set(antenna, 'Name', sprintf('Antenna %d',antenna),'NumberTitle','off','Position',[1 scrsz(2) scrsz(3)/3 scrsz(4)]);
subplot(2,1,1)
if 0
    %length(run)==1 % periodogram
    imagesc( lst, d.f/1e6, d.psd );
    set( gca, 'YDir', 'normal' );
    xlim([0 24])
    xlabel( 'LST time  [ hours ]', 'FontSize', 20 );
    ylabel( 'Frequency  [ MHz ]', 'FontSize', 20 );
    title( 'Amplitude [ dB ref  V / Hz^{1/2} ]', 'FonTSize', 20 );
    colorbar;
    set( gca, 'FontSize', 16 );
else
    plot( d.t/60, 20*log10( d.sigma/min( d.sigma ) ), 'r.', 'LineWidth', 2 );
    hold on;
    plot( d.t/60, G - min( G ), 'ks', 'LineWidth', 2, 'MarkerFace', 'k', 'MarkerSize', 3 );
    hold off; 
    grid on;
    title(sprintf('Antenna %d',antenna), 'FontSize', 20)
    %xlim([0 24])
    %xlabel( 'Local Time  [HH:MM]', 'FontSize', 20 );
    xlabel( 'Duration since start  [min]', 'FontSize', 20 );
    ylabel( '\Delta \sigma,   \Delta GBW(55-95 MHz)  [ dB ]', 'FontSize', 20 );
    set( gca, 'FontSize', 16 );
end

subplot(2,1,2)
plot( lst, 20*log10( d.sigma/min( d.sigma ) ), 'r.', 'LineWidth', 2 );
hold on;
plot( lst, G - min( G ), 'ks', 'LineWidth', 2, 'MarkerFace', 'k', 'MarkerSize', 3 );
hold off; 
grid on;
title(sprintf('Antenna %d',antenna), 'FontSize', 20)
xlim([0 24])
xlabel( 'LST time  [ hours ]', 'FontSize', 20 );
ylabel( '\Delta \sigma,   \Delta GBW(55-95 MHz)  [ dB ]', 'FontSize', 20 );
set( gca, 'FontSize', 16 );
%close( antenna)
pause
timev = d.t;
[yi, mi, di, hi, mni, si] = UnixSecs2Date(timev);

dd = datenum(yi,mi,di,hi,mni,si);
figure(antenna+1000)
%plot(dd,20*log10( d.sigma/min( d.sigma ) ), 'r.', 'LineWidth', 2 );
hold on;
%plot( dd, G - min( G ), 'ks', 'LineWidth', 2, 'MarkerFace', 'k', 'MarkerSize', 3 );
plot(  d.t/60, Vrms, 'ks', 'LineWidth', 2, 'MarkerFace', 'k', 'MarkerSize', 3 );
%hold off; 
grid on;
%datetick('x','dd-mm HH','keeplimits','keepticks')
%title(sprintf('Antenna %d',antenna), 'FontSize', 20)
%xlim([0 24])
xlabel( 'Run duration (min)', 'FontSize', 20 );
ylabel( 'V_{DAQ}^{rms} (mV)', 'FontSize', 20 );
set( gca, 'FontSize', 16 );
%pause
%figure( antenna+100 );

figure(figid)
hold on
%set(antenna+100, 'Name', sprintf('Antenna %d',antenna),'NumberTitle','off');
grid on;
xlabel( 'Frequency  [ MHz ]', 'FontSize', 20 );
ylabel( 'Amplitude [ dB ref  V / Hz^{1/2} ]', 'FonTSize', 20 );
set( gca, 'FontSize', 16 );
if film
    step = 1;
else
    step = length( d.t )+1;
end
%step=1;
film
for k = 1:step:length( d.t )
%for k = length( d.t ):length( d.t )
    if film==0
        plot( d.f(3:end)/1e6, 10.^(d.psd( 3:end, length( d.t ) )/10), col, 'LineWidth', 2 );
        xlabel( 'Frequency (MHz)', 'FontSize', 20 );
        ylabel( 'PSD (V^{2}/Hz)', 'FonTSize', 20 );
        set( gca, 'FontSize', 16 );
        pause
    else
        if  k>1
            plot( d.f/1e6, d.psd( :, k-step ), 'y', 'LineWidth', 2 );
        end
        hold off
        plot( d.f/1e6, d.psd( :, k ), col, 'LineWidth', 2 );
        grid on
        xlabel( 'Frequency (MHz)', 'FontSize', 20 );
        ylabel( 'PSD (V^{2}/Hz)', 'FonTSize', 20 );
        set( gca, 'FontSize', 16 );
        %
        [y m day h mn s] = unixSecs2Date(d.tdeb+d.t(k)+8*3600);  % Local time: UT+8h
        disp(sprintf('Point %d: \n%02d/%02d/%d %02d:%02d local time',k,m,day,y,h,mn))
        disp(sprintf('LST time: %3.2f hours',lst(k)))
        %pause( 0.001 );
        disp(sprintf('Elapsed time since begining of run : %3.1f minutes', d.t(k)/60)); 
        figure( antenna)
        subplot(2,1,2)
        lili=line([lst(k) lst(k)],[0 max(20*log10( d.sigma/min( d.sigma )))]);
        set(lili,'Color','r')
        figure(figid)
        pause
    end
end

%
return;

figure;
plot( d.t/60, d.mu, 'k-' );
grid on;

figure;
plot( d.t/60, d.flag, 'k-' );
grid on;

figure( 3 );
subplot( 1, 2, 1 );
plot( T/60, mu, 'k', 'LineWidth', 2 );
grid on;
title(sprintf('Antenna %d',antenna))
xlabel( 'Time  [ min ]', 'FontSize', 20 );
ylabel( '\mu [ LSB ]', 'FontSize', 20 );
set( gca, 'FontSize', 16 );
subplot( 1, 2, 2 );
plot( T/60, sig, 'ks', 'LineWidth', 2 );
grid on;
xlabel( 'Time  [ min ]', 'FontSize', 20 );
ylabel( '\sigma [ LSB ]', 'FontSize', 20 );
set( gca, 'FontSize', 16 );
