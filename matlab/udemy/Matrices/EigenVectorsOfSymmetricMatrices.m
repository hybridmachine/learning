% Lecture follow along to show that independant eigen vectors of a diagonal
% matrix are orthoginal

% Random matrix
m = 5;
A = randn(m);

% Make it symmetric (use the additive method)
A = A + A';

% Diagonalize it (Eigen decomposition)
[evecs, evals] = eig(A);

% Get the magnitude of each eigenvector
% Note:um(A,1) operates on successive elements in the columns of A and returns a row vector of the sums of each column.
sqrt(sum(evecs.^2,1))