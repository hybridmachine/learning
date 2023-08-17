%{
In this code challenge, you will explore the relationship between
Equations 15.47 and 15.52 in the section on generalized eigendecomposition.

Create two matrices A and B. Then perform (1)
generalized eigendecomposition of both matrices, and (2) "regular"
eigendecomposition on the matrix B^-1*A; inspect whether
the eigenvalues are the same. Try this for 2×2 matrices, and
then again for larger matrices like 10×10 or 50×50. Do you also
need to compare the eigenvectors or is it sufficient to compare
the eigenvalues?


Interpretation of generalized eigendecomposition
(B^-1*A)v = lambda*v (15.52)
Cv = lambda*v , C = B−1A

Av = lambda*Bv (15.47)

%}

m = 2;

A = randn(m);
B = randn(m);
BinvA = inv(B) * A;

[ gevecs, gevals ] = eig(A,B);
[ evecs, evals ] = eig(BinvA);

sortedGevals = sort(diag(gevals));
sortedEvals = sort(diag(evals));

dot(sortedGevals - sortedEvals,sortedGevals - sortedEvals)




