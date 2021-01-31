% Imagine you work as a data analyst in a company that sells widgets online. 
% The company gives you a dataset of information from 1000 sales, 
% which includes the time of the sale (listed in hours of the day
% using a 24-hour clock, e.g., 15 = 3pm), the age of the buyer (in years), 
% and the number of widgets sold. The data are included in the 
% ”widget data.mat” file.

% 1. Explain and write down a mathematical model that is appropriate to 
% test with this dataset.

% Ans: Given the data dimensions of time and age relating to number sold
% for that combination, an equation would look like
% Time*b1 + Age*b2 = WidgetsSold. 

% 2. Cast equation from 1 into matrix form
% Design matrix X is a column matrix of 1000x2 form (1000 sales, two data
% points (time and age). The coefficients vector is a 2x1 column vector for
% the weightings to be solved for
% The results vector is a 1000x1 column vector of the observed data for
% each time & age combination
% Xb = y

load("widget_data.mat")

% Remember to include the intercept since the average isn't 0
X = [ones(1,1000); data(1,:); data(2,:)]';
y = data(3,:)';

XLeftInverse = (X'*X)\X';

b = XLeftInverse*y;
bN = [b(2)/std(X(:,1)); b(3)/std(X(:,2))]; % Normalized against std deviation of corresponding indepenedant variable;

%Produce scatter plots that visualize the relationship between the independent and dependent
%variables.

figure('Name','Independant vs Dependant')
subplot(1,2,1)
plot(data(1,:),data(3,:),'ks','markersize',7,'markerfacecolor','b')
xlabel(rowLabels(1)), ylabel(rowLabels(3))

subplot(1,2,2)
plot(data(2,:),data(3,:),'ks','markersize',7,'markerfacecolor','b')
xlabel(rowLabels(2)), ylabel(rowLabels(3))


% Compute R2 for the model to see how well it fits the data
% R2 = 1 - (sum(error residule^2))/(sum(yi-yavg)^2)

residuleErrorSquaredSum = 0;
dataDistanceFromAverageSquaredSum = 0;

avgNumWidgetsData = mean(data(3,:));

% Here's a more effecient way letting matlab handle the vectors , no need
% to loop
yHat = X*b; % This is a vector of predictions based on the model
rSquared = 1 - sum((yHat-y).^2) / sum((y-mean(y)).^2);

% Below was my rSquared calc, which used a loop, above is the professors
% method which gives the same value but lets matlab do what it does best, 
% handle the vectors and matrices in place
% for idx=1:length(data(1,:))
%     timeOfDay = data(1,idx);
%     buyersAge = data(2,idx);
%     numWidgetsData = data(3,idx);
%     
%     numWidgetsPrediction = b(1) + timeOfDay * b(2) + buyersAge*b(3);
%     
%     residuleError = numWidgetsData - numWidgetsPrediction;
%     distanceFromAvg = numWidgetsData - avgNumWidgetsData;
%     
%     residuleErrorSquaredSum = residuleErrorSquaredSum + residuleError^2;
%     dataDistanceFromAverageSquaredSum = dataDistanceFromAverageSquaredSum + distanceFromAvg^2;
% end
% 
% rSquared = 1 - (residuleErrorSquaredSum/dataDistanceFromAverageSquaredSum);