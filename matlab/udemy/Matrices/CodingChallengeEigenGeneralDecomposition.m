%%% Goal is to compare eig(S,R) with eig(inv(R)*S)
%%% Theoretically they are identical but computationally from a digital
%%% computation, rounding error propogation perspective, they are very
%%% different in effort and risk of rounding error stacking
%%%
%%% Part 1: Perform on a small 2x2 matrix, compare results
%%%
%%% Part 2: With real data matrices in R16
load real_matrices.mat

Ss = randn(2,2);
Rs = randn(2,2);

[eigvecs, eigvals] = eig(Ss,Rs);
[eigvecsInv, eigvalsInv] = eig(inv(Rs)*Ss);

% disp ([eigvals, eigvalsInv])
% disp ([eigvecs, eigvecsInv])

figure(1),clf, hold on
plot([0 eigvecs(1,1)],[0 eigvecs(2,1)], 'k-')
plot([0 eigvecs(1,2)],[0 eigvecs(2,2)], 'k--')
plot([0 eigvecsInv(1,1)],[0 eigvecsInv(2,1)], 'r-')
plot([0 eigvecsInv(1,2)],[0 eigvecsInv(2,2)], 'r--')
axis([-1 1 -1 1]), axis square, grid on

[eigvecs, eigvals] = eig(S,R);
[eigvecsInv, eigvalsInv] = eig(inv(R)*S);

% disp ([eigvals, eigvalsInv])
% disp ([eigvecs, eigvecsInv])

figure(2),clf, hold on
plot(diag(eigvals))
plot(diag(eigvalsInv))