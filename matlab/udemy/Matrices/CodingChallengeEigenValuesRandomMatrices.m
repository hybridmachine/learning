% Generate random 40x40 matrices, take eigen values, plot values

n = 20;
count = 300;
eigValsMatrix = zeros(count,n);
figure(1), clf, hold on

for idx = 1 : count
    M = randn(n,n)/sqrt(n);
    %eigValsMatrix(idx,:) = eig(M);
    plot(eig(M),'s')
end