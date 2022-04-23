% 	1) Load sampleEEGdata.mat
%   2) Perform PCA
%	3) Compute S as narrowband filter at 11hz and 4hz FWHM (see DRSS_GED_scanning1.m for an example of this type of filtering)
%	4) Compute R as the covariance of the broadband data
%   5) Perform GED on the S,R matrix pair
%	6) Apply the spatial filter to the broadband data
%
% a clear MATLAB workspace is a clear mental workspace
close all,  clear, clc

%%

% load data
load sampleEEGdata.mat
EEG.data = double(EEG.data);

% mean-center data
% meanCenteredData = EEG.data - mean(EEG.data,2);

% Instead lets detrend the data
for i = 1:EEG.trials
    EEG.data(:,:,i) = detrend(EEG.data(:,:,i)')';
end

meanCenteredData = EEG.data;
% Perform a standard Eigen decomposition on the covariance matrix of the data matrix
% We will do a covariance matrix of each trial then average the covariance
% matrices and perform eigen decomposition on that
covPCA = zeros(EEG.nbchan,EEG.nbchan,EEG.trials);

for i = 1:EEG.trials
    tmp = meanCenteredData(:,:,i);
    covPCA(:,:,i) = (tmp * tmp') / (EEG.pnts - 1);
end

covPCAAvg = mean(covPCA, 3);

[pcaEigVecs, pcaEigVals] = eig(covPCAAvg);

% Sort eigvec
[ eigValsVec, sidx ] = sort(diag(pcaEigVals),'descend');
pcaEigVecs = pcaEigVecs(:,sidx);
percentVarianceExplainedVec = 100*eigValsVec / sum(eigValsVec);

% Pick a threshold in percent variance explained
percentVarianceExplained = 1.0; 
componentsToKeep = percentVarianceExplainedVec > percentVarianceExplained;
activePcaEigVecs = pcaEigVecs(:,componentsToKeep);
componentDataNbrChans = sum(componentsToKeep);
componentData = zeros(componentDataNbrChans, EEG.pnts, EEG.trials);

% Compute the new data matrices to feed into the GED
for i = 1:EEG.trials
    componentData(:,:,i) = activePcaEigVecs' * meanCenteredData(:,:,i);
end

narrowBandFilterFreq = 11; % Filter frequency
narrowBandFilterFWHM = 4; % Full width at half maximum
fdata = filterFGx(componentData,EEG.srate,narrowBandFilterFreq,narrowBandFilterFWHM,false);
fdata = fdata - mean(fdata,2); % Mean center the frequency filtered data

% GED S & R matrix
gedSmatrix = zeros(componentDataNbrChans, componentDataNbrChans, EEG.trials);
gedRmatrix = zeros(componentDataNbrChans, componentDataNbrChans, EEG.trials);
for i = 1:EEG.trials
    tmp = fdata(:,:,i);
    gedSmatrix(:,:,i) = (tmp * tmp')/(EEG.pnts-1);

    tmp = componentData(:,:,i);
    gedRmatrix(:,:,i) = (tmp * tmp')/(EEG.pnts-1);
end
gedSmatrixAvg = mean(gedSmatrix,3);
gedRmatrixAvg = mean(gedRmatrix,3);


[ gedEigVec, gedEigVal ] = eig(gedSmatrixAvg, gedRmatrixAvg);
[ gedSortedEigVal, sidx ] = sort(diag(gedEigVal), 'descend');
gedEigVec = gedEigVec(:,sidx);

% GED component time series (apply GED eigen vectors to original broadband
% data) and GED component maps
gedComponentTimeSeries = zeros(componentDataNbrChans, EEG.pnts, EEG.trials);

for i = 1:EEG.trials
    gedComponentTimeSeries(:,:,i) = gedEigVec'*componentData(:,:,i);
end
meanGedComponentTimeSeries = mean(gedComponentTimeSeries, 3);

% Place the component maps back in the data space 
gedComponentMaps = gedEigVec' * gedSmatrixAvg * activePcaEigVecs';

%Adjust sign
for i = 1:componentDataNbrChans
    [~,idx]       = max( abs(gedComponentMaps(i,:)) );
    meanGedComponentTimeSeries(i,:) = meanGedComponentTimeSeries(i,:) * sign(gedComponentMaps(i,idx));
    gedComponentMaps(i,:) = gedComponentMaps(i,:) * sign(gedComponentMaps(i,idx)); 
end

colormap jet

subplot(2,1,1)
topoplotIndie(gedComponentMaps(1,:),EEG.chanlocs,'numcontour',0);

subplot(2,1,2)
plot(EEG.times, meanGedComponentTimeSeries(1,:));
xlabel('Time (ms)'), ylabel('Activity')
set(gca, 'XLim',[-200, 1000], 'fontsize',18)

