% The sum of the Eigenvalues is equal to the trace of the matrix
% The product of the Eigenvalues is equal to the determinant of the matrix
% This exercise shows these in action

m = 7;
n = 5;
A = randn(m,n) * randn(n,m); % Reduced rank

A = A' * A; % Make it symmetric to stay within the realm of real numbers

[eigvecs, eigvals] = eig(A);

detA = det(A);
traceA = trace(A);

detAEig = prod(diag(eigvals));
traceAEig = sum(diag(eigvals));

disp(detA / detAEig)
disp(traceA / traceAEig)