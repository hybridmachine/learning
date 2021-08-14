% Start with the code from the sigprocMXC_SNR (signal to noise) example
% And filter the data with successively higher frequency low pass filters
% to determine the effect on the signal to noise ratio on the timepoint at
% 375 from the SNRdata.mat data file.

load SNRData.mat;

% pick time point
timepoint = 375;
basetime  = [-500 0];

% average over repetitions
erp = mean(eegdata,3);
npts = length(timevec);
sampleRate = round(npts/(max(timevec)-min(timevec))*1000);

results = zeros(2,30);

for hz = 1:30
    
    fcutoff = hz;
    transw  = .20;
    order   = round( (10*sampleRate)/fcutoff);

    if (order > npts/4)
        order = round(npts/4);
    end
    shape   = [ 1 1 0 0 ];
    frex    = [ 0 fcutoff fcutoff+fcutoff*transw sampleRate/2 ] / (sampleRate/2);
        
    for chan = 1:2

        % filter kernel
        lowpassFiltkern = firls(order,frex,shape);
        lp_erp = filtfilt(lowpassFiltkern,1,double(erp(chan,:)));

        % SNR components
        snr_num = lp_erp(dsearchn(timevec',timepoint));
        snr_den = std( lp_erp(dsearchn(timevec',basetime(1)):dsearchn(timevec',basetime(2))) ,[],2);
        
        results(chan,hz) = snr_num./snr_den;

        % display SNR in the command window
%         i = 1;
%         disp([ 'SNR at ' num2str(timepoint) 'ms in channel ' num2str(i) ' = ' num2str(snr_num(i)./snr_den(i)) ])
        
    end
end

hz = 1:30;
plot(hz,results(1,:),hz,results(2,:))