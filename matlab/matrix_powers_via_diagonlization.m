% Show that you can take the power of a matrix by first diagonalizing it
% using eigen decomposition, then taking the power of the eigenvalues
% diagonal matrix then recombining to form the matrix to whatever power you
% wanted. Note that this is valuable because for the diagonal matrix, the
% power of that matrix is just the diagonal values to that same power

A = randn(4);
A = A*A'; % Symmetric means we'll get real values, keeps it simpler

% For reference
A^2

[ EigVecA, EigValA ] = eig(A);

Asquared = EigVecA * EigValA^2 * inv(EigVecA);

Asquared