% Load a recorded voice memo and peform signal processing operations on it
% as a learning exercise
[y,Fs] = audioread("voice_memo.m4a");

timeLen = length(y) / Fs;
timeVec = 0:1/Fs:timeLen;
timeVec = timeVec(1:length(timeVec)-1);

timeSeriesAndFrequencyPlot = figure(1);
timeSeriesAndFrequencyPlot.Name = 'Time Series And Frequency Plot';
clf;
subplot(2,1,1);
plot(timeVec, y);
xlabel('Time');
ylabel('Amplitude');
title('Voice Memo Sample');
xlim([0 timeLen]);

% soundsc(y,Fs);

hz = (0:Fs);
freqData = fft(y,length(hz));
frequencyPlotCutoff = 3600; % hz to cut plotting off at, only interested in voice range

subplot(2,1,2);
plot(hz,abs(freqData));
xlim([0 frequencyPlotCutoff]);
xlabel('Hz');
ylabel('Amplitude');
title('Voice Memo Frequency Amplitudes');
