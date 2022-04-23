% 1) Perform ZCA from data in the [-1 0] time band
% 2) Perform PCA based compression on data after applying ZCA filter
%    Set the compression to be %variance > 1.0%
% 3) Perform GED on data
%    First filter at 11hz, 4hz FWH for the S matrix
%    R is broadband data (I think as filtered through step 2)
% a clear MATLAB workspace is a clear mental workspace
close all,  clear, clc

% load data
load sampleEEGdata.mat
EEG.data = double(EEG.data);

% Detrend the data
for i = 1:EEG.trials
    EEG.data(:,:,i) = detrend(EEG.data(:,:,i)')';
end

zcaCovariance = zeros(EEG.nbchan, EEG.nbchan);
restingTimeIndexes = dsearchn(EEG.times',[-1000 0]');
for i = 1:EEG.trials
    tmp = EEG.data(:,restingTimeIndexes(1):restingTimeIndexes(2),i);
    zcaCovariance = zcaCovariance + (tmp * tmp' / (length(tmp) - 1));
end

% Average zcaCovariance across trials
zcaCovariance = zcaCovariance / EEG.trials;

% Eigen decomposition of zcaCovariance, sorted
[zcaEigVec, zcaEigVals] = eig(zcaCovariance);
[zcaEigVals, sidx] = sort(diag(zcaEigVals), 'descend');
zcaEigVec = zcaEigVec(:,sidx);

percentVarianceExplained = 100*(zcaEigVals / (sum (zcaEigVals)));
whitenVectors = percentVarianceExplained > 0.1; % Only whiten for percent variance explained > 0.1%
zcaEigVec = zcaEigVec(:,whitenVectors);

whitenedData = zeros(size(EEG.data));

% This is the core of ZCA, instead of using the raw Eigen values we instead
% use the inverse square root of them, this is what flattens out the
% varience
invDsqrt = diag(zcaEigVals(whitenVectors))^(-1/2);

for i = 1:EEG.trials
    whitenedData(:,:,i) = zcaEigVec * invDsqrt * zcaEigVec' * EEG.data(:,:,i);
end

% Perform a PCA on the whitened data and then filter for percent variance
% explained of > 1.0% (This is extreme, just part of this lesson for
% demonstration, in real data you wouldn't normally be this agressive and
% could even skip this step if you used ZCA to whiten the data
pcaCovariance = zeros(EEG.nbchan, EEG.nbchan);
for i = 1:EEG.trials
    tmp = whitenedData(:,:,i);
    pcaCovariance = pcaCovariance + (tmp * tmp' / (length(tmp) - 1));
end
[pcaEigVec, pcaEigVals] = eig(pcaCovariance);
[pcaEigVals, sidx] = sort(diag(pcaEigVals), 'descend');
pcaEigVec = pcaEigVec(:,sidx);
percentVarianceExplained = 100*(pcaEigVals / (sum (pcaEigVals)));

pctVarExpThreshold = 1.0; 
componentsToKeep = percentVarianceExplained > pctVarExpThreshold;
activePcaEigVecs = pcaEigVec(:,componentsToKeep);
componentDataNbrChans = sum(componentsToKeep);
componentData = zeros(componentDataNbrChans, EEG.pnts, EEG.trials);
% Compute the new data matrices to feed into the GED
for i = 1:EEG.trials
    componentData(:,:,i) = activePcaEigVecs' * whitenedData(:,:,i);
end

narrowBandFilterFreq = 11; % Filter frequency
narrowBandFilterFWHM = 4; % Full width at half maximum
fdata = filterFGx(componentData,EEG.srate,narrowBandFilterFreq,narrowBandFilterFWHM,false);

% GED S matrix
gedSmatrix = zeros(componentDataNbrChans, componentDataNbrChans, EEG.trials);
% GED R matrix
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

gedComponentTimeSeries = zeros(EEG.pnts, EEG.trials);

for i = 1:EEG.trials
    gedComponentTimeSeries(:,i) = gedEigVec(:,1)' * componentData(:,:,i);
end
meanGedComponentTimeSeries = mean(gedComponentTimeSeries, 2);
gedComponentMaps = gedEigVec' * gedSmatrixAvg * activePcaEigVecs';

%Adjust sign
for i = 1:componentDataNbrChans
    [~,idx]       = max( abs(gedComponentMaps(i,:)) );
    gedComponentMaps(i,:) = gedComponentMaps(i,:) * sign(gedComponentMaps(i,idx)); 
    meanGedComponentTimeSeries = meanGedComponentTimeSeries * sign(gedComponentMaps(i,idx)); 
end

colormap jet

subplot(2,1,1)
topoplotIndie(gedComponentMaps(1,:),EEG.chanlocs,'numcontour',0);

subplot(2,1,2)
plot(EEG.times, meanGedComponentTimeSeries);
xlabel('Time (ms)'), ylabel('Activity')
set(gca, 'XLim',[-200, 1000], 'fontsize',18)