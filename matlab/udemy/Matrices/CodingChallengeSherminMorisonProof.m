% Implement the Sherman-Morison proof in Matlab code

% Create random column vectors
a = randn(5,1);
b = randn(5,1);

M1 = eye(5) - a*b';

% Inverse of M1 is (by Sherman Morison)
%I + ab' / (1-a'b)

M1Inv = eye(5) + (a*b')/(1-a'*b);

M1 * M1Inv

% Manually calculated Ident mat

M1Ident = eye(5) - a*b' + (a*b')/(1-a'*b) - a*b'*a*b'/(1-a'*b)

