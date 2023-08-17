% Plotting equation 2.26 from "The Fast Fourier Transform and its
% Applications" page 17
A = 1;
fo = 5; %hz
timevec = -1000:1000;
timevec(timevec == 0) = eps; % Avoid 0, avoid the NaN in h
srate = 1000;
t = timevec / srate;
h = 2*A*fo*(sin(2*pi*fo*t)./(2*pi*fo*t));


figure(1),clf;
plot(t, h);

hx = fft(h);

figure(2),clf;
plot(abs(hx(1:srate/2)));
xlim([0 70]);