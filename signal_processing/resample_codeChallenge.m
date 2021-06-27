% Code challenge to re-sample data with missing blocks, not a number (nan)
% data elements and multi rate sampling

% Fill in the NaN elements (interpolate perhaps)
% Remove and interpolate across the noise bursts
% resample to regularly spaced data

load resample_codeChallenge.mat;

% See the original data vs the sampled data
plot(time,signal, 'ks-', 'linew', 3);
hold on;
plot(origT, origS, 'r', 'linew', 3);

% These are the good signal values so the range is not inclusive
noiseOneStartX = 0.288;
noiseOneEndX = 0.311;

noiseTwoStartX = 1.288;
noiseTwoEndX = 1.31;

nanIndexes = find(isnan(signal));

% Remove NaN values, we'll use interpolation to fill back in
signal(nanIndexes) = [];
time(nanIndexes) = [];