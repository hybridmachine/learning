% Coding challenge to implement filter on x to match Professors output in y

% Load and plot source signal and target output to match
load filtering_codeChallenge.mat;

time = 1:length(x);
npnts = length(time);

subplot(2,1,1);
plot(time,x,time,y);

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
filtkern = firls(order,frex,shape);

% its power spectrum
filtkernX = abs(fft(filtkern,npnts)).^2;

figure(2), clf
subplot(321)
plot((-order/2:order/2)/fs,filtkern,'k','linew',3)
xlabel('Time (s)')
title('Filter kernel')

subplot(322), hold on
plot(frex*fs/2,shape,'r','linew',1)
plot(hz,filtkernX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Filter kernel spectrum')

xFilt = filtfilt(filtkern,1,x);
xFiltPow = fft(xFilt);



% high pass 5hz and up

fcutoff = 5;
order   = round( 15*fs/fcutoff );

highPassKern = fir1(order,5/(fs/2),'high'); 
highPassKernX = abs(fft(highPassKern,npnts)).^2;

figure('name','High Pass Filter'), clf
subplot(321)
plot((-order/2:order/2)/fs,highPassKern,'k','linew',3)
xlabel('Time (s)')
title('Filter kernel')

subplot(322), hold on
plot(hz,highPassKernX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Filter kernel spectrum')

xFiltHigh = filtfilt(highPassKern,1,xFilt);
xFiltHighPow = fft(xFiltHigh);

% Last up, notch filter

fcutoff = 15;
notchLen = 7;
transw  = .3;
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

figure('name', 'Notch Filter'), clf
subplot(321)
plot((-order/2:order/2)/fs,filtkernNotch,'k','linew',3)
xlabel('Time (s)')
title('Notch filter kernel')

subplot(322), hold on
plot(frex*fs/2,shape,'r','linew',1)
plot(hz,filtkernNotchX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Notch filter kernel spectrum');

notchFiltHigh = filtfilt(filtkernNotch,1,xFiltHigh);
notchFiltHighPow = fft(notchFiltHigh);

figure(1);
subplot(2,1,2);
hz = linspace(0,fs,length(time));
plot(hz,abs(xPow),hz,abs(yPow),hz,abs(xFiltHighPow),hz,abs(notchFiltHighPow));
xlim([0 fs/2]);