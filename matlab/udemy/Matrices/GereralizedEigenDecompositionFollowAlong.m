% https://www.udemy.com/course/linear-algebra-theory-and-implementation/learn/lecture/10521168#overview
S = [3 2; 1 3];
R = [1 1; 4 1];

% Generalized eigen decomp. Note the two matrices passed to eig
% Order is important
% Sv = ʎ*R*v;
% v is the Eigen vectors, ʎ is the Eigen values
[eigvecs, eigvals] = eig(S,R);