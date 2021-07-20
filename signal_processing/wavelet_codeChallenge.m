% Code challenge to match filtering of reference signals from professor using
% a FIR filter then a Morlet Wavelet
load wavelet_codeChallenge.mat

% Setup plotting figures
figFilterKernels = figure(3), clf;
set(figFilterKernels,'name','Filter Kernels');
clf(figFilterKernels);

figSignals = figure(1), clf;
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
figFiltered = figure(2), clf; 
hold on;
numpts = length(signalFIR);
subplot(4,1,1);
plot((1:numpts),signalFIR,(1:numpts),signalMW);
xlim([0 numpts]);
title('Reference Filtered Signal');
legend('FIR','MW');



% First implement a FIR filter to match
% High pass first
fcutoff = 10.0;
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
fcutoff = 15.0;
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



subplot(4,1,4);
plot(hz,sigFiltLowPassX);
xlim([0 30]);
title('Calculated Filter Kernel');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Morley wavelet 

% parameters
ffreq = 12.7;
fwhm = .14; 
wavTimeVec = -3:1/srate:3;

% Transpose into column vector to match signal format in .mat format
morWavelet = (cos(2*pi*ffreq*wavTimeVec) .* exp((-4*log(2)*wavTimeVec.^2) / fwhm.^2))';


% Remember that the length of convolution plus the length of the filter
% kernel minus 1
nConv = numpts + length(wavTimeVec) - 1;
convWingWidth = floor(length(wavTimeVec)/2)+1; % Used to trim of the wings of convolution
waveHz = linspace(0,srate,nConv);
morwavX = fft(morWavelet,nConv);
% Normalize to avoid amplification

morwavX = 1.0 * morwavX ./ max(morwavX); % Two filtere passes

morwavFilteredFrequencyDomain = morwavX .* fft(signal,nConv);
morwavFilteredTimeDomain = ifft(morwavFilteredFrequencyDomain);

morwavFilteredTimeDomain = real(morwavFilteredTimeDomain(convWingWidth:end-convWingWidth+1));

revFiltTimeDomain = flip(morwavFilteredTimeDomain);
revFiltFreqDomain = morwavX .* fft(revFiltTimeDomain,nConv);

% Filtering shifts the phase, unshift by flipping, filtering, re-flipping
% back
zeroPhaseTimeDomain = real(ifft(revFiltFreqDomain));
zeroPhaseTimeDomain = zeroPhaseTimeDomain(convWingWidth:end-convWingWidth+1);
zeroPhaseTimeDomain = flip(zeroPhaseTimeDomain);

figure(figFiltered)

subplot(4,1,2);
plot((1:numpts),sigFiltLowPass,(1:numpts),zeroPhaseTimeDomain);
xlim([0 numpts]);
title('Calculated Filtered Signal');
legend('FIR','MW');

subplot(4,1,4);
plot(waveHz,abs(morwavX(1:length(waveHz))));
xlim([0 30]);
title('Calculated Morlet Wavelet Frequency Response');

subplot(4,1,3);
signalX = abs(fft(signalFIR,numpts));
signalMWX = abs(fft(signalMW,numpts));
morwavFilteredTimeDomainX = abs(fft(zeroPhaseTimeDomain,numpts));
hz = linspace(0,srate,numpts);
plot(hz,signalX,hz,signalMWX,hz,morwavFilteredTimeDomainX);
xlim([0 30]);
xlabel('hz');
title('Filtered Frequency Amplitude');
