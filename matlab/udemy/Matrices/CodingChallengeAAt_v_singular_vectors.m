m = 4;
A = randn(m,m);
AtA = A' * A;
AAt = A * A';

[U, S, V] = svd(AtA);

diffs = zeros(m,1);
for i=1:m
    % These should negate to 0, IE both sides should be the same (within
    % rounding error)
    diffs(i) = sum((AAt*A*V(:,i) - A*U(:,i)*S(i,i)).^2);
end

diffs