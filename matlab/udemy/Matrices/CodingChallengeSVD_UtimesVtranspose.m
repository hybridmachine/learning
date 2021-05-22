% Create a matrix such at U * V' is valid (a square matrix)
m = 5;
A = randn(m);

[U, S, V] = svd(A);

disp(['Norm U ', num2str(norm(U))])
disp(['Norm V ', num2str(norm(V))])
disp(['Norm U*Vt ', num2str(norm(U*V'))])

disp('U*Ut '), U*U'

disp('V*Vt '), V*V'

disp('U*Vt '), U*V'

C = U*V';

C*C'
C'*C

[U2, S2, V2] = svd(U)

