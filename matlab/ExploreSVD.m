% Explore the four subspaces of the matrix using the SVD

m = 5;
n = 3; 
A = randn(m,n);
% Lower the rank of A
A(:,n) = A(:,n-1);

[ U, S, V ] = svd(A);

% U is the column space plus the left null space of A
% S is the weightings of each basis (0 for basis in the null space) for A
% V is the row space plus the null space of A