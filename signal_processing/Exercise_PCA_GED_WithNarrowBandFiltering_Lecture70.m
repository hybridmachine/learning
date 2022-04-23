% 	1) Load sampleEEGdata.mat
%   2) Perform PCA
%	3) Compute S as narrowband filter at 11hz and 4hz FWHM (see DRSS_GED_scanning1.m for an example of this type of filtering)
%	4) Compute R as the covariance of the broadband data
%	5) Apply the spatial filter to the broadband data
%		Perform PCA->GED with threshold of 0.0%, then 0.1%, then 1.0% variance explained
%
% Procedure in detail
%
%	1) Perform a standard Eigen decomposition on the covariance matrix of the data matrix
%	2) Pick a threshold for the reduced dimensionality r (the cutoff where eigen values below that cause the eigen value/vector pair to be discarded)
%		a. This is typically done with % variance, convert the eigen values into percent variance explained (sum all of the eigen values up, then divide each by the sum then multiply by 100 to get the % variance explained)
%		b. You can also compute the rank of the data matrix and choose the rank as your cutoff (this ensures you always have a full rank matrix in the end)
%	3) Compute the new data matrix Y as Eigenvectors(:,r)^T * original data matrix X
%〖Y=V(:,r)〗^T∗X
%	Where (:,r) is all of the columns up to threshold r chosen in step 2
%	4) Perform the GED on new data matrix Y
%	5) Computing the maps in original dimensions of X (original data matrix)
%w^T S〖V(1:r)〗^T
%This will get you back to original data matrix dimensions
%
% a clear MATLAB workspace is a clear mental workspace
close all,  clear, clc

%%

% load data
load sampleEEGdata.mat
EEG.data = double(EEG.data);

% mean-center data
meanCenteredData = EEG.data - mean(EEG.data,2);

%	1) Perform a standard Eigen decomposition on the covariance matrix of the data matrix
% We will do a covariance matrix of each trial then average the covariance
% matrices and perform eigen decomposition on that
covPCA = zeros(EEG.nbchan,EEG.nbchan,EEG.trials);

for i = 1:EEG.trials
    tmp = meanCenteredData(:,:,i);
    covPCA(:,:,i) = tmp * tmp' /(EEG.pnts - 1);
end

covPCAAvg = mean(covPCA, 3);

[pcaEigVecs, pcaEigVals] = eig(covPCAAvg);

% 1 Sort eigvec
[ eigValsVec, sidx ] = sort(diag(pcaEigVals),'descend');
pcaEigVecs = pcaEigVecs(:,sidx);
percentVarianceExplainedVec = 100*(eigValsVec / sum(eigValsVec));

% 2 pick a threshold
percentVarianceExplained = 0.1; 
componentsToKeep = percentVarianceExplainedVec > percentVarianceExplained;
activePcaEigVecs = pcaEigVecs(:,componentsToKeep);
componentDataNbrChans = sum(componentsToKeep);
componentData = zeros(componentDataNbrChans, EEG.pnts, EEG.trials);
% 3 Compute the new data matrices to feed into the GED
for i = 1:EEG.trials
    componentData(:,:,i) = activePcaEigVecs' * meanCenteredData(:,:,i);
end

narrowBandFilterFreq = 11; % Filter frequency
narrowBandFilterFWHM = 4; % Full width at half maximum
fdata = filterFGx(componentData,EEG.srate,narrowBandFilterFreq,narrowBandFilterFWHM,false);
%fdata = fdata - mean(fdata,2);

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

% GED component time series (apply GED eigen vectors to original broadband
% data) and GED component maps


gedComponentTimeSeries = zeros(EEG.pnts, EEG.trials);

for i = 1:EEG.trials
    gedComponentTimeSeries(:,i) = gedEigVec(:,1)' * componentData(:,:,i);
end
meanGedComponentTimeSeries = mean(gedComponentTimeSeries, 2);
gedComponentMaps = gedEigVec' * gedSmatrixAvg * activePcaEigVecs';

%Adjust sign
for i = 1:componentDataNbrChans
    [~,idx]       = max( abs(gedComponentMaps(i,:)) );
    %meanGedComponentTimeSeries = meanGedComponentTimeSeries * sign(gedComponentMaps(i,idx));
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

