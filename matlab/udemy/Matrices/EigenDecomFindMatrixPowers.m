% Use the Eigendecompisition and equality rule to find the power of a
% matrix

A = rand(4);

A4 = A^4; % Let matlab do it, we'll compare to the value we get from eigen decomp

[eivec, eival] = eig(A);

A4e = eivec * eival^4 * inv(eivec);

A4 - A4e