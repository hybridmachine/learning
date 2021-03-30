% Create an mxm (say 5x5) matrix and take it's eigen decomposition
% show that the norm of the outer product of v_i (eigen vector in the ith
% column of the eigen vector matrix) is one.
% Create one layer of A as ʎ * v * v', compute its norm (Show that its norm
% is just ʎ. 
% Reconstrunct by summing over the eigenlayers (outer products)

m = 5;

A = randn(m,m);
A = A'*A; % Make symmetric, keeps eigen vectors in realspace, no complex numbers
A = round(10*A);
[eigvec,eigvals] = eig(A);

recomposeA = zeros(m,m);

for idx = 1:m
    v = eigvec(:,idx);

    % norm of v is v * v', should be one
    normOfV = norm(v*v');

    recomposeA = recomposeA + (eigvals(idx,idx) * (v * v'));
    disp(rank(recomposeA))

end

% Should be within rounding error of 0, IE they should be the same
A - round(recomposeA)
