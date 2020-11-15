% Demonstrate the ran of A, vs AtA vs AAt

m = 14;
n = 3;

A = randi(25,m,n);

AtA = A'*A;
AAt = A*A';

fprintf('\n A: %gx%g, rank=%g', size(A,1), size(A,2), rank(A));
fprintf('\n AtA: %gx%g, rank=%g', size(AtA,1), size(AtA,2), rank(AtA));
fprintf('\n AAt: %gx%g, rank=%g', size(AAt,1), size(AAt,2), rank(AAt));