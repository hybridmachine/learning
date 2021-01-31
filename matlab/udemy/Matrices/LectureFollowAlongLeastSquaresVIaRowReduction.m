% Least squares via row reduction

m = 10; % Number of samples
n = 3; % Number of regressors

% Create random sample data
X = randn(m,n); % Design Matrix
y = randn(m,1); % outcome measures (observed data)

rref([X y]); % To show this wont produce anything useful

% Use the normal form X'X beta = X'y Then use row reduction to find beta
Xsol = rref([X'*X X'*y]);
beta1 = Xsol(:,end);

beta2 = (X'*X)\(X'*y); % Use the left inverse method

