% Load a recorded voice memo and peform signal processing operations on it
% as a learning exercise
[y,Fs] = audioread("voice_memo.m4a");

timeLen = length(y) / Fs;
timeVec = 0:1/Fs:timeLen;
timeVec = timeVec(1:length(timeVec)-1);

timeSeriesPlot = figure(1);
timeSeriesPlot.Name = 'Time Series Plot';
clf;
plot(timeVec, y);
xlabel('Time');
ylabel('Amplitude');
title('Voice Memo Sample');

% soundsc(y,Fs);

hz = (0:Fs);
freqData = fft(y,length(hz));
frequencyPlotCutoff = 5000; % hz to cut plotting off at, only interested in voice range

frequencyPlot = figure(2);
frequencyPlot.Name = 'Frequency Plot';
clf;
plot(hz,abs(freqData));
xlim([0 frequencyPlotCutoff]);
