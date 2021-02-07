% Generate a diagonal matrix (start with 2x2)
% Get the Eigenvalues of that matrix and see what's special about
% diaganal matrices

m = 3;
A = randn(m,m);
symA = A' * A;

[symA eig(symA)]

symSum = sum(diag(symA))
eigValSum = sum(eig(symA))

eigDiag = diag(randn(1,3));
[eigDiag eig(eigDiag)]
upperDiag = triu(A);
lowerDiag = tril(A);

[upperDiag eig(upperDiag)]
[lowerDiag eig(lowerDiag)]

