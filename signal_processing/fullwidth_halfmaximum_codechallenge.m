% Smooth and interpolate to more accurately find full width at half maximum
% Adapted from sigprocMXC_FWHM.m asymmetric block section
% @author btabone
% 2021-07-31


% generate asymmetric distribution
[fx,x] = hist(exp(.5*randn(10000,1)),150);

% normalization necessary here!
fxNorm = fx./max(fx);

% plot the function
figure(1), clf, hold on
plot(x,fx,'ks-','linew',3,'markerfacecolor','w')


% find peak point
peakpnt = find( fxNorm==max(fxNorm) );


% find 50% PREpeak point
prepeak = dsearchn(fxNorm(1:peakpnt)',.5);


% find 50% POSTpeak point
pstpeak = dsearchn(fxNorm(peakpnt:end)',.5);
pstpeak = pstpeak + peakpnt - 1; % adjust

% compute empirical FWHM
fwhmE = x(pstpeak) - x(prepeak);



% plot the points
plot(x(peakpnt),fx(peakpnt),'ko','markerfacecolor','r','markersize',15)
plot(x(prepeak),fx(prepeak),'ko','markerfacecolor','g','markersize',15)
plot(x(pstpeak),fx(pstpeak),'ko','markerfacecolor','g','markersize',15)


% plot line for reference
plot(x([prepeak pstpeak]),fx([prepeak pstpeak]),'k--')
plot([1 1]*x(prepeak),[0 fx(prepeak)],'k:')
plot([1 1]*x(pstpeak),[0 fx(pstpeak)],'k:')

title([ 'Empirical FWHM: ' num2str(fwhmE) ])


% Smooth the signal
k = 3; % filter window is actually k*2+1

fig = figure(2);
fftMeanSmooth(k,x,fx,fig);

