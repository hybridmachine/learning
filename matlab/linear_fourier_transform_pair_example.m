% Show that x(t) + y(t) == X(f) + Y(f) 
% Where x and y are time domain functions and
% X and Y are their Fourier pairs (frequency functions)

srate = 1000; %1000 samples per second
seconds = 1;
timevec = 1:(seconds * srate); % ms
frequency = 3; % hz
simpleSine = sin(2*pi*frequency * (timevec/srate));
simpleSquare = [ zeros(1,333) ones(1,333), zeros(1,334)];
figure(1), clf;
%plot(timevec,simpleSine,timevec,simpleSquare,timevec,simpleSine + simpleSquare);
plot(simpleSine + simpleSquare);
ylim([-1.5 3]);

% calculate the FFT of each, add the FFTs then take the iFFT and plot that,
% should be identical to the time domain summing of the signals
simpleSineX = fft(simpleSine);
simpleSquareX = fft(simpleSquare);

simpleSummed = ifft(simpleSineX + simpleSquareX);
figure(2),clf;
plot(simpleSummed);
ylim([-1.5 3]);

