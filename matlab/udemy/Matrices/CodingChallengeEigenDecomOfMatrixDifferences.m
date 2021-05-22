% (A-B)v = λv
% From this (from the FOIL expansion of (A-B)^2)
% (A^2 - AB - BA + B^2)v = λ^2v
% C = (A-B)
% C^2 = (A^2 - AB - BA + B^2)
% Matrix form
% CV = VΛ where V is the matrix form of Eigen vectors, and Λ is the matrix
% form of eigen values (note the order is important on the right side, the
% scalar equation is written in reverse by convention)
% C = VΛV^-1
% C^2 = V*Λ*V^-1*V*Λ*V^-1
% V^-1*V is the identity matrix
% C^2 = V*Λ*Λ*V^-1
% (A^2 - AB - BA + B^2) = V*Λ*Λ*V^-1

% Now to demonstrate
m = 5;
A = randn(m);
A = A'*A; % Make it symmetric, removes the complex values from eigene values
B = randn(m);
B = B'*B;

[eivec,eival] = eig(A-B);

matlabRes = (A^2 -B*A-A*B+B^2); % Let matlab do the nasty math
eigRes = eivec * eival^2 * inv(eivec); % Compute it the simpler way

matlabRes - eigRes

figure(1),clf
subplot(121)
imagesc(matlabRes)
axis square, xlabel('(A^2-B*A-A*B+B^2)')

subplot(122)
imagesc(eigRes)
axis square, xlabel('eivec * eival^2 * inv(eivec)')