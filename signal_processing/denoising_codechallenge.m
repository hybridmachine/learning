% Denoise the signal code challenge
load denoising_codeChallenge.mat

figure(1),clf;
subplot(6,1,1);
plot(origSignal);
title('Original Signal');
n = length(origSignal);

subplot(6,1,2);
hist(origSignal,40);
title('Histogram of values in signal');
% Step 1 apply median filter for values above 5 (as visually noted in histogram above)
% visual-picked threshold
threshold = 5;


% find data values above the threshold
suprathresh = find( abs(origSignal)>threshold );

% initialize filtered signal
filtsig = origSignal;

% loop through suprathreshold points and set to median of k
k = 20; % actual window is k*2+1
for ti=1:length(suprathresh)
    
    % find lower and upper bounds
    lowbnd = max(1,suprathresh(ti)-k);
    uppbnd = min(suprathresh(ti)+k,n);
    
    % compute median of surrounding points
    filtsig(suprathresh(ti)) = median(origSignal(lowbnd:uppbnd));
end

meanFiltered = zeros(size(filtsig));

% implement the running mean filter
k = 100; % filter window is actually k*2+1
for i=k+1:n-k-1
    % each point is the average of k surrounding points
    meanFiltered(i) = mean(filtsig(i-k:i+k));
end

% Gaussian filter
% full-width half-maximum: the key Gaussian parameter
fwhm = 65; % in au

% normalized time vector in ms
k = 45;
gtime = (-k:k);

% create Gaussian window
gauswin = exp( -(4*log(2)*gtime.^2) / fwhm^2 );

% initialize filtered signal vector
filtsigG = filtsig;

% implement the running mean filter
for i=k+1:n-k-1
    % each point is the weighted average of k surrounding points
    filtsigG(i) = sum( filtsig(i-k:i+k).*gauswin );
end

subplot(6,1,3);
plot(filtsig);
str_title = sprintf('Median filtered signal with cutoff at %d and window at %d',threshold,k);
title(str_title);

subplot(6,1,4);
plot(meanFiltered);
str_title = sprintf('Mean filtered signal with window %d',k);
title(str_title);

subplot(6,1,5);
plot(filtsigG);
str_title = sprintf('Gaussian filtered signal with full width half maximum of %d',fwhm);
title(str_title);

subplot(6,1,6);
plot(cleanedSignal);
title('Cleaned signal example for reference');