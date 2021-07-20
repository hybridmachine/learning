% Code challenge to re-sample data with missing blocks, not a number (nan)
% data elements and multi rate sampling

% Fill in the NaN elements (interpolate perhaps)
% Remove and interpolate across the noise bursts
% resample to regularly spaced data

load resample_codeChallenge.mat;

% See the original data vs the sampled data

% Remove NaN values, we'll use interpolation to fill back in
nanIndexes = find(isnan(signal));
signal(nanIndexes) = [];
time(nanIndexes) = [];

figure(1);
plot(time,signal, 'ks-', 'linew', 3);
hold on;
plot(origT, origS, 'r', 'linew', 3);

% These are the good signal values so the range is not inclusive,
% identified using visual inspection of signal near noise areas
noiseOneStartX = 0.2880;
noiseOneEndX = 0.311;

noiseTwoStartX = 1.288;
noiseTwoEndX = 1.31;

noiseOneStartIdx = find(abs(time - noiseOneStartX) < 0.0001);
noiseOneEndIdx = find(abs(time - noiseOneEndX) < 0.0001);


signal(noiseOneStartIdx:noiseOneEndIdx) = [];
time(noiseOneStartIdx:noiseOneEndIdx) = [];

noiseTwoStartIdx = find(abs(time - noiseTwoStartX) < 0.0001);
noiseTwoEndIdx = find(abs(time - noiseTwoEndX) < 0.0001);

signal(noiseTwoStartIdx:noiseTwoEndIdx) = [];
time(noiseTwoStartIdx:noiseTwoEndIdx) = [];




% Interpolate the known signals then we'll use spectral interpolation for
% the missing data sections (noise areas)

% use griddedInterpolant

interpolater = griddedInterpolant(time, signal, 'spline');
srate = 1000;
npts = srate * 3;
timevec = (0:npts-1)/srate; % three seconds)
interpolatedSignal = interpolater(timevec);

plot(timevec,interpolatedSignal, 'b', 'linew', 3);


% 
% fftLen = noiseOneEndIdx - noiseOneStartIdx;
% fftLeft = fft(interpolatedSignal(noiseOneStartIdx-fftLen+1:noiseOneStartIdx));
% fftRight = fft(interpolatedSignal(noiseTwoEndIdx:noiseTwoEndIdx+fftLen-1));
% fftAvg = (fftLeft + fftRight) /2;
% freqInterSig = ifft(fftAvg);
% freqInterSigDetrend = detrend(freqInterSig);
% 
% interpolatedSignal(noiseOneStartIdx:noiseOneEndIdx)
