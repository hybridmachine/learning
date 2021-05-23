% Coding challenge to implement filter on x to match Professors output in y

% Load and plot source signal and target output to match
load filtering_codeChallenge.mat;

time = 1:length(x);
npnts = length(time);
hz = linspace(0,fs,length(time));

% create figures
figTimeSeries = figure(1);
figTimeSeries.Name = 'Time Series';
clf(figTimeSeries);

figFilterKernels = figure(2);
figFilterKernels.Name = 'Filter Kernels';
clf(figFilterKernels);

figure(figTimeSeries);
subplot(3,1,1);
plot(time,x,time,y);
title('Unfiltered vs Reference Timeseries');

xPow = fft(x);
yPow = fft(y);


% Looking at the target result, it looks like three filters
% 1) A low pass filter with a cutoff around 35 hz (maybe a little earlier)
% 2) A high pass filter 5hz and above
% 3) A notch filter knocking out 17 to 24 hz


% First the low pass filter (code borrowed from sigprocMXC_lowpass.m)

fcutoff = 30;
transw  = .25;
order   = round( 19*fs/fcutoff );

shape   = [ 1 1 0 0 ];
frex    = [ 0 fcutoff fcutoff+fcutoff*transw fs/2 ] / (fs/2);

% filter kernel
lowpassFiltkern = firls(order,frex,shape);

% its power spectrum
lowpassFiltkernX = abs(fft(lowpassFiltkern,npnts)).^2;

figure(figFilterKernels);
subplot(321)
plot((-order/2:order/2)/fs,lowpassFiltkern,'k','linew',3)
xlabel('Time (s)')
title('Low pass filter kernel')

subplot(322), hold on
plot(frex*fs/2,shape,'r','linew',1)
plot(hz,lowpassFiltkernX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Low pass filter kernel spectrum')

xFilt = filtfilt(lowpassFiltkern,1,x);
xFiltPow = fft(xFilt);



% high pass 5hz and up

fcutoff = 5;
order   = round( 15*fs/fcutoff );

highPassKern = fir1(order,5/(fs/2),'high'); 
highPassKernX = abs(fft(highPassKern,npnts)).^2;

figure(figFilterKernels);
subplot(323)
plot((-order/2:order/2)/fs,highPassKern,'k','linew',3)
xlabel('Time (s)')
title('High pass filter kernel')

subplot(324), hold on
plot(hz,highPassKernX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('High pass filter kernel spectrum')

xFiltHigh = filtfilt(highPassKern,1,xFilt);
xFiltHighPow = fft(xFiltHigh);

% Last up, notch filter

fcutoff = 15;
notchLen = 7;
transw  = .35;
order   = round( 18*fs/fcutoff );

shape   = [ 1 1 0 0 1 1 ];
fcutoffTransw = fcutoff+fcutoff*transw;
notchEnd = fcutoff+notchLen;
notchEndTransw = notchEnd+fcutoff*transw;
frex    = [ 0 fcutoff fcutoffTransw notchEnd notchEndTransw fs/2 ] / (fs/2);

% filter kernel
filtkernNotch = firls(order,frex,shape);

% its power spectrum
filtkernNotchX = abs(fft(filtkernNotch,npnts)).^2;

figure(figFilterKernels);
subplot(325)
plot((-order/2:order/2)/fs,filtkernNotch,'k','linew',3)
xlabel('Time (s)')
title('Notch filter kernel')

subplot(326), hold on
plot(frex*fs/2,shape,'r','linew',1)
plot(hz,filtkernNotchX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Notch filter kernel spectrum');

notchFiltHigh = filtfilt(filtkernNotch,1,xFiltHigh);
notchFiltHighPow = fft(notchFiltHigh);

figure(figTimeSeries);
subplot(3,1,2);
plot(time,y,time,notchFiltHigh);
title('Reference vs Calculated');
legend('Reference','Calculated');
subplot(3,1,3);
plot(hz,abs(xPow),hz,abs(yPow),hz,abs(notchFiltHighPow));
legend('Unfiltered','Reference','Calculated');
xlim([0 fs/2]);
title('Power Spectrum');