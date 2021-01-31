% Use QR decomposition to compute the inverse. Compare against matrix
% inverse

% The QR inverse works as follows
% 1) Remember that inv(A) = Q'
% 2) A=QR means that inv(A) = inv(QR) = inv(R) * inv(Q) (by the live evil rule) = inv(R) * Q' (from
% step 1 above)
% in summary inv(A) = inv(R) * Q'
% Taking the inverse of R is more stable since it is an upper triangle
% matrix
m = 100;
M1 = randn(m,m);

MinvNative = inv(M1);
[Q,R] = qr(M1);

Rinv = inv(R);
MinvQR = Rinv * Q';

M2 = inv(MinvNative);
[Q,R] = qr(MinvQR);

M2QR = inv(R) * Q';

MinvNative2 = inv(M2);
[Q,R] = qr(M2QR);
MinvQR2 = inv(R)*Q';

M3 = inv(MinvNative2);
[Q,R] = qr(MinvQR2);
M3QR = inv(R) * Q';



