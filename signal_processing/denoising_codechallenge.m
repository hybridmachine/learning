% Denoise the signal code challenge
load denoising_codeChallenge.mat

plotRows = 5;
plotCols = 1;
plotIdx = 0;

figure(1),clf;
plotIdx = plotIdx + 1;
subplot(plotRows,plotCols,plotIdx);
plot(origSignal);
title('Original Signal');
n = length(origSignal);

plotIdx = plotIdx + 1;
subplot(plotRows,plotCols,plotIdx);
histogram(origSignal,40);
title('Histogram of values in signal');

% Step 1 apply median filter for values above 4 (as visually noted in histogram above)
% visual-picked threshold
threshold = 4;


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

plotIdx = plotIdx + 1;
subplot(plotRows,plotCols,plotIdx);
plot(filtsig);
str_title = sprintf('Median filtered signal with cutoff at %d and window at %d',threshold,k);
title(str_title);

meanFiltered = zeros(size(filtsig));

% implement the running mean filter. Updated from example online where
% lower and upper bound was set to avoid clipping at end of signal
k = 150; % filter window is actually k*2+1
for i=1:n
    lower_bound = max(1,i-k);
    upper_bound = min(n,i+k);
    meanFiltered(i) = mean(filtsig(lower_bound:upper_bound));
    % each point is the average of k surrounding points
end

plotIdx = plotIdx + 1;
subplot(plotRows,plotCols,plotIdx);
plot(meanFiltered);
str_title = sprintf('Moving mean filtered signal with window %d',k);
title(str_title);
axis([0 4000 -1 1]);

plotIdx = plotIdx + 1;
subplot(plotRows,plotCols,plotIdx);
plot(cleanedSignal);
title('Professor''s Cleaned signal example for reference');
axis([0 4000 -1 1]);
