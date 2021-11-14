% Code challenge for Complete Linear Algebra

% Explore the relationship between Eigen decomposition and Singular Value
% Decomposition for square symmetric matrices

% Create a square symmetric matrix
m = 5;
A = randn(m,m);
A = A'*A;

[ W, L ] = eig(A);
[d, sidx] = sort(diag(L), 'descend');
L = diag(d); % sorted
W = W(:,sidx);

[ U, S, V] = svd(A);

figure(1), clf;

subplot(231), imagesc(W), title('W (eig)'), axis square;
subplot(232), imagesc(L), title('\Lambda (eig)'), axis square;

subplot(234), imagesc(U), title('U (svd)'), axis square;
subplot(235), imagesc(S), title('S (svd)'), axis square;
subplot(236), imagesc(V), title('V (svd)'), axis square;