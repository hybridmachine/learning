% Code challenge to match filtering of reference signals from professor using
% a FIR filter then a Morlet Wavelet
load wavelet_codeChallenge.mat

% Setup plotting figures
figFilterKernels = figure(3);
set(figFilterKernels,'name','Filter Kernels');
clf(figFilterKernels);

figSignals = figure(1);
numpts = length(signal);
subplot(2,1,1);
plot(signal);
xlim([0 numpts]);
title('Signal');

subplot(2,1,2);
signalX = abs(fft(signal,numpts));
hz = linspace(0,srate,numpts);
plot(hz,signalX);
xlim([0 srate/2]);
xlabel('hz');
title('Frequency Amplitude');

% SignalFIR & signaMW
figFiltered = figure(2); 
hold on;
numpts = length(signalFIR);
subplot(4,1,1);
plot((1:numpts),signalFIR,(1:numpts),signalMW);
xlim([0 numpts]);
title('Reference Filtered Signal');
legend('FIR','MW');

subplot(4,1,3);
signalX = abs(fft(signalFIR,numpts));
signalMWX = abs(fft(signalMW,numpts));
hz = linspace(0,srate,numpts);
plot(hz,signalX,hz,signalMWX);
xlim([0 30]);
xlabel('hz');
title('Filtered Frequency Amplitude');

% First implement a FIR filter to match
% High pass first
fcutoff = 8;
order   = round( 15*srate/fcutoff );
% 
highPassKern = fir1(order,fcutoff/(srate/2),'high'); 
highPassKernX = abs(fft(highPassKern,numpts)).^2;
% 
figure(figFilterKernels);
subplot(321)
plot(highPassKern,'k','linew',3)
xlabel('Time (s)')
title('High pass filter kernel')

subplot(322), hold on
plot(hz,highPassKernX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('High pass filter kernel spectrum')

sigFiltHighPass = filtfilt(highPassKern,1,signal);
sigFiltHightPassX = fft(sigFiltHighPass);

% Low pass next
fcutoff = 17;
order   = round( 15*srate/fcutoff );

lowPassKern = fir1(order,fcutoff/(srate/2),'low'); 
lowPassKernX = abs(fft(lowPassKern,numpts)).^2;

figure(figFilterKernels);
subplot(323)
plot(lowPassKern,'k','linew',3)
xlabel('Time (s)')
title('Low pass filter kernel')

subplot(324), hold on
plot(hz,lowPassKernX(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Low pass filter kernel spectrum')

sigFiltLowPass = filtfilt(lowPassKern,1,sigFiltHighPass);
sigFiltLowPassX = abs(fft(sigFiltLowPass));

figure(figFiltered)

subplot(4,1,2);
plot((1:numpts),sigFiltLowPass);
xlim([0 numpts]);
title('Calculated Filtered Signal');

subplot(4,1,4);
plot(hz,sigFiltLowPassX);
xlim([0 30]);
title('Calculated Filter Kernel');
