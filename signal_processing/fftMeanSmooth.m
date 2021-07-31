% Function to run a mean smoothing on a signal given a specific window
% uses the FFT to run the smoothing
% Optionally will plot original vs smoothed signal if a figure handle is
% passed in
function smoothedSignal = fftMeanSmooth(window, timeVec, signal, drawPlotHandle)
    arguments
        window double
        timeVec (1,:) {mustBeNumeric}
        signal(1,:) {mustBeNumeric}
        drawPlotHandle = []
    end
    signalLength = length(signal);
    cnvKernelWidth = (window*2)+1;
    fftPadding = cnvKernelWidth+signalLength-1; % Account for the extra width due to convolution, this will get stripped out below and re align the phase


    cnvKernel = ones(1,cnvKernelWidth) * 1/cnvKernelWidth;
    cnvKernelFFT = fft(cnvKernel, fftPadding);
    signalFFT = fft(signal,fftPadding);
    smoothedFFT = cnvKernelFFT .* signalFFT;
    smoothedSignal = ifft(smoothedFFT);
    smoothedSignal = smoothedSignal(window+1:end-window); % Strip off the padding, this aligns the phase
    
    if (isa(drawPlotHandle,'matlab.ui.Figure'))
        drawPlotHandle.Name='fftMeanSmooth - Smoothed vs Original Signal';

        % plot the noisy and filtered signals
        figure(drawPlotHandle), clf, hold on
        plot(timeVec,signal,'ks-','linew',2,'markerfacecolor','r','markersize',5);
        plot(timeVec,smoothedSignal,'ks-','linew',2,'markerfacecolor','g','markersize',5);
    end
end