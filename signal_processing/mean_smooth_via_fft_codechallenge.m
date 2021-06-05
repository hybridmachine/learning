%%
% Adapted from
%     COURSE: Signal processing problems, solved in MATLAB and Python
%    SECTION: Time-domain denoising
%      VIDEO: Mean-smooth a time series
% Instructor: sincxpress.com
%
% This challenge is to implement the mean smooth via FFT by first finding
% the equivalent convolution kernel then taking its FFT and multiplying it
% times the signal FFT then take the iFFT of that and match against the
% original
%%

% create signal
srate = 1000; % Hz
time  = 0:1/srate:3;
n     = length(time);
p     = 15; % poles for random interpolation

% noise level, measured in standard deviations
noiseamp = 5; 

% amplitude modulator and noise level
ampl   = interp1(rand(p,1)*30,linspace(1,p,n));
noise  = noiseamp * randn(size(time));
signal = ampl + noise;

% initialize filtered signal vector
filtsig = zeros(size(signal));

% implement the running mean filter
k = 20; % filter window is actually k*2+1
for i=k+1:n-k-1
    % each point is the average of k surrounding points
    filtsig(i) = mean(signal(i-k:i+k));
end

% First find the equivalent convolution kernel
% THe median is just the 1/npts * Sum(value of each point)
% This would be a square wave kernel with height 1/npts and width of npts
cnvKernelWidth = (k*2)+1;
fftPadding = cnvKernelWidth+signalLength-1; % Account for the extra width due to convolution, this will get stripped out below and re align the phase

signalLength = length(signal);
cnvKernel = ones(1,cnvKernelWidth) * 1/cnvKernelWidth;
cnvKernelFFT = fft(cnvKernel, fftPadding);
signalFFT = fft(signal,fftPadding);
smoothedFFT = cnvKernelFFT .* signalFFT;
smoothedSignal = ifft(smoothedFFT);
smoothedSignal = smoothedSignal(k+1:end-k); % Strip off the padding, this aligns the phase

cnvSmoothed = conv(signal, cnvKernel,'same');
% compute window size in ms
windowsize = 1000*(k*2+1) / srate;


% plot the noisy and filtered signals
figure(1), clf, hold on
% Plot with a little offset in each for easy visual comparison
plot(time,signal, time,filtsig, time,cnvSmoothed .* 1.01 ,time,smoothedSignal .* 1.02,'linew',2)

% draw a patch to indicate the window size
tidx = dsearchn(time',1);
ylim = get(gca,'ylim');
patch(time([ tidx-k tidx-k tidx+k tidx+k ]),ylim([ 1 2 2 1 ]),'k','facealpha',.25,'linestyle','none')
plot(time([tidx tidx]),ylim,'k--')

xlabel('Time (sec.)'), ylabel('Amplitude')
title([ 'Running-mean filter with a k=' num2str(round(windowsize)) '-ms filter' ])
legend({'Signal';'Filtered';'Conv Smoothed';'FFT Smoothed';'Window';'window center'})

zoom on

%% done.
