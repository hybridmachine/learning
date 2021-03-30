% Eigendecompisition (also known as Diagonalization)

A = round(10*randn(4));
A = A'*A; % Make it a symmetric matrix

% Perform the Eigendecompisition
[eivecs, eivals] = eig(A);

% Test reconstruction
Ap = eivecs * eivals * inv(eivecs);

%plot
figure(4), clf
subplot(121),imagesc(A)
axis square, axis off, title('A')

subplot(122),imagesc(Ap)
axis square, axis off, title('V*Λ*V^-1')

A - Ap
