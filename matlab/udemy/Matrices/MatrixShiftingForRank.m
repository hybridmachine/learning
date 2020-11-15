m = 30;

A = randn(m);
A = round(10*A'*A);

A(:,1) = A(:,2);

l = 0.1;

imagesc(A);