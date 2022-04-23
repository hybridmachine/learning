% Implement the six steps of PCA using synthetic data output by
% DRSS_covar_sata.m

% a clear MATLAB workspace is a clear mental workspace
close all; clear, clc

%% simulate data with covariance structure

% Code from DRSS_covar_sata.m to generate simulated data, data(2) is the
% non phase locked
% simulation parameters
N = 1000;     % time points
M =   20;     % channels
nTrials = 50; % number of trials

% time vector (radian units)
t = linspace(0,6*pi,N);

% initialize data matrices
data = cell(1,2);

% relationship across channels (imposing covariance)
chanrel = sin(linspace(0,2*pi,M))';

% loop over "trials" and generate data
for triali=1:nTrials
    
    % simulation 1
    data{1}(:,:,triali) = bsxfun(@times,repmat( sin(t),M,1 ),chanrel) + randn(M,N)/1;
    
    % simulation 2 - NON phase locked -
    data{2}(:,:,triali) = bsxfun(@times,repmat( sin(t+rand*2*pi),M,1 ),chanrel) + randn(M,N)/1;
end

% Code to perform PCA on non phase locked (data(2)) data

%% Step 1 compute covariance matrix of data
% data * data' / (N-1)
% Use appropriate time window
% Mean center
% Remove bad channels
% Optionally do any temporal filtering (low pass, high pass, band pass,
% etc)

covMat = zeros(M,M);

for trialIdx = 1:nTrials
    
    % Extract the data
    trialData = squeeze(data{2}(:,:,trialIdx));
    
    % Mean center
    trialData = bsxfun(@minus, trialData, mean(trialData, 2));
    
    % No bad channels to remove in the simulated data
    % No temporal filtering to do at this time
    
    covMat = covMat + ((trialData * trialData')/(N-1));
end

% The covariance matrix is an average of all individual trial covariance
% matrices
covMat = covMat / nTrials;

% Visualize
% clim = [-1 1]*.7; % colormap
% clf, imagesc(covMat)
% axis square, title('Dataset 2, trial covars')
% set(gca,'clim',clim,'xtick',[],'ytick',[])


%% Step 2 Eigen decomposition of the covariance matrix
[eigvecs, eigvals] = eig(covMat);

%% Step 3 Sort eigvecs and eigvals
[eigvals, soidx] = sort(diag(eigvals), 'desc');
eigvecs = eigvecs(:,soidx);

%% Step 4 component time series (use trial 1)
componentTimeSeries = eigvecs' * data{2}(:,:,1);

%% Step 5 get scalled eigenvalues
seigVal = 100*eigvals/sum(eigvals);

%% Step 6 visualize
figure(1),clf
subplot(2,3,1)
plot(seigVal, '-*');
% set(gca,'ytick',[]), axis tight
ylim([0, 25])
xlabel('Component Number');
ylabel('\lambda');

subplot(2,3,2)
hold on
plot(eigvecs(:,1), '-o');
plot(eigvecs(:,2), '-o');
legend('PC1','PC2')
xlabel('Channel')
ylabel('PC Weight')

subplot(2,3,[4,5,6])
hold on
plot(componentTimeSeries(1,:),'-');
plot(componentTimeSeries(2,:),'-');