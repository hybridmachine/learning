% A = U *S *V'
%
% A'A = (U*S*V')' * U*S*V'
% A'A = V*S'*U' * U * S * V'
% A'A = V*S'*I*S*V'
% A'A = V*S'*S*V'
% A'A = V*S^2*V' (S'*S is S^2 because S is diagonal and A diag times its
% tranpose is the matrix squared
% M=A'A 
% M = V*S^2*V'
% This is the eigendecomposition of M
% MV = V*S^2. This allows us to find V using the eigendcomposition of A'A
% We can use AA' in the same way to find U
% Matrix A
A = [ 3 0 5; 8 1 3 ];
[U, S, V] = svd(A);

figure(1),clf;
subplot(141), imagesc(A);
axis square, axis off, title('A');

subplot(142), imagesc(U);
axis square, axis off, title('U');

subplot(143), imagesc(S);
axis square, axis off, title('\Sigma');

subplot(144), imagesc(V');
axis square, axis off, title('V''');

