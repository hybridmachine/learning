% Least squares example 1
% Find the average of a set of numbers using left inverse approach to
% finding least squares

data = [-4, 0, -3, 1, 2, 8, 5, 8]'; % Put into column form for easier use
N = length(data);

% Equation describing this system
% -4 = b1
%  0 = b1
% -3 = b1.....

% Matrix form
% Simplest design matrix
%designMatrix = ones(N,1);

% Noting increasing trend in data, try sligntly more complex design matrix
%designMatrix = (1:N)';

% Put in the mean offset to get the predictions closer
%designMatrix = [ ones(N,1) (1:N)' ];

% Try adding a non linear term (quadratic term) 
%designMatrix = [ ones(N,1) (1:N)'.^2 ];

% Try adding another non-linear term (3rd power) 
%designMatrix = [ ones(N,1) (1:N)'.^2 -(1:N)'.^3 ];

% Try adding another non-linear term (4th power) 
designMatrix = [ ones(N,1) (1:N)'.^2 -(1:N)'.^3 (1:N)'.^4 ];

% designMatrix * b = data
% So b = (designMatrix' * designMatrix)^-1 * designMatrix' * data

b = (designMatrix' * designMatrix) \ designMatrix' * data;

calculatedMean = mean(data);
% yHat is the predicted data based on the model
yHat = designMatrix * b;

% plot the data
figure(3), clf
plot(1:N,data,'bs--','MarkerFaceColor','k','linew',2,'markersize',14)
hold on
plot(1:N,yHat,'ro--','MarkerFaceColor','m','linew',2,'markersize',14)

set(gca,'xlim',[.5, N+.5])
xlabel('Data Point'), ylabel('Data value')
legend({'Observed data';'Predicted data'})
