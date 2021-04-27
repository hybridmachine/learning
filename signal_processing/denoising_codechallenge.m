% Denoise the signal code challenge
load denoising_codeChallenge.mat

figure(1),clf;
subplot(2,1,1);
plot(origSignal);
subplot(2,1,2);
hist(origSignal,40);

% Step 1 apply median filter for values above 5 (as visually noted in histogram above)
