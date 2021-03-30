% What is the relationship between eig and svd for a square symmetric
% matrix

% create a symmetric matrix (5x5)
% Calculate the eig of this matrix (store in W and L variables)
% Calculate the svd of this matrix (store in U,S, and V variables)

% Take images of all matrices
% Compare U and V and between U and W

A = randn(5,5);
A = A'* A; % make symmetric

[W,L] = eig(A);
[U,S,V] = svd(A);

figure(1), clf, hold on

subplot(231)
imagesc(abs(W))
title('Eig Vectors'), axis square

subplot(232)
imagesc(L)
title('Eig Values'), axis square

subplot(234)
imagesc(abs(U)A)
title('Col Orth Basis'), axis square

subplot(235)
imagesc(S)
title('Singular Values'), axis square

subplot(236)
imagesc(V)
title('Row Orth Basis'), axis square