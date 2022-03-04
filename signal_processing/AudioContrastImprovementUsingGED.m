% Experiment using synthetic background noise ('A major chord') mixed with
% voice then FFTd , generating covariance matrix from baseline and mixed
% data, then using GED to increase contrast of signal against background
% then taking component of that and doing inverse FFT to get audio
%
% @author btabone
% @date 2022-02-22

% Only way to be sure, nuke it from orbit
close all; clear, clc

% First generate A major chord
% An A major chord (in third octave) is constructed with an A, C#, E, with corresponding frequencies 220.5, 138.5, 164.5
% From https://music.stackexchange.com/questions/42694/what-is-a-chord-in-terms-of-frequencies
% Notes in radians per second
Note1 = 220.5 * 2 * pi; 
Note2 = 138.5 * 2 * pi;
Note3 = 164.5 * 2 * pi;
Signal = 350 * 2 * pi;

Note1Amp = 1;
Note2Amp = 1;
Note3Amp = 1;
SignalAmp = 2;

SampleRate = 2400; % Sampling hz
Nyquist = SampleRate / 2 ;
NumFrequencyChan = Nyquist; % One channel per hz
Frequencies = linspace(0,Nyquist,NumFrequencyChan);

PlaySeconds = 3; % We'll use 3 for baseline and mix in voice for the last 3 seconds
SignalLength = SampleRate * PlaySeconds;
TimeVec = linspace(0,SignalLength,SignalLength);

AudioData = (Note1Amp * sin(Note1*(TimeVec/SampleRate))) + (Note2Amp * sin(Note2*(TimeVec/SampleRate))) + (Note3Amp * sin(Note3*(TimeVec/SampleRate)));
SignalInjectionTime = 2*SampleRate;
AudioData(1,SignalInjectionTime:end) = AudioData(1,SignalInjectionTime:end) + (SignalAmp * sin(Signal*(TimeVec(1,SignalInjectionTime:end)/SampleRate))); 

AudioDataFFT = fft(AudioData);
AllPower = abs(AudioDataFFT/SignalLength);
NyquistPower = AllPower(1:((SignalLength/2)+1));
NyquistPower(2:end-1) = 2*NyquistPower(2:end-1); % To account for positive and negative energies in signal
Frequency = SampleRate*(0:(SignalLength/2))/SignalLength;
figure(1)
plot(Frequency,NyquistPower);
xlim([0 500])

figure(2)
plot(TimeVec/SampleRate, AudioData)
sound(AudioData,SampleRate)
