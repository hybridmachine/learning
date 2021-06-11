% Code challenge to match filtering of reference signals from professor using
% a FIR filter then a Morlet Wavelet
load wavelet_codeChallenge.mat

figure(1);
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
figure(2); hold on;
numpts = length(signalFIR);
subplot(2,1,1);
plot((1:numpts),signalFIR,(1:numpts),signalMW);
xlim([0 numpts]);
title('Filtered Signal');
legend('FIR','MW');

subplot(2,1,2);
signalX = abs(fft(signalFIR,numpts));
signalMWX = abs(fft(signalMW,numpts));
hz = linspace(0,srate,numpts);
plot(hz,signalX,hz,signalMWX);
xlim([0 30]);
xlabel('hz');
title('Filtered Frequency Amplitude');
