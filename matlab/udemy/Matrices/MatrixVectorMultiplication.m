m = 4;

N = randi([0,10],m,m);
S = round(N'*N/m^2);

w = [-1 0 1 2]';

S*w
(S*w)
%w*S
w'*S'
w'*S
