% Create a design matrix and obvserved data vector
% Design matrix
X = randn(10,3);

% Observations
y = randn(10,1);

% Try QR decom to get inverse
[Q, r] = qr(X);

% Remember that X = Qr so X^-1 = [Qr]^-1 and by l.i.v.e e.v.i.l. rule,
% [Qr]^-1 = r^-1 * Q^-1 

% Q is orthoginal so Q^-1 = Q'

qrInverse = r\Q';

% Left inverse
Xinv = (X'*X)\X';

betaQr = qrInverse * y;
betaXinv = Xinv * y;
betaLessonApproach = (r'*r)\(Q*r)'*y;
