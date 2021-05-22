% 1) Create a matrix with a known condition number
% 2) Compute the explicit inverse using inv()
% 3) Multiply the two matrices to get the Ident matrix
% 4) Compute the difference between the computed ident matrix and eye()
% 5) Repeat for matrices of size 2 to 70 and 10 to 10^12 
% 6) Store the results and show in a matrix image

conditionList = linspace(10,10^12, 68);
results = zeros(68);
matSizes = 2:70
for matrixSize = 1:length(matSizes)
    for condition = 1:length(conditionList)
        % Get orthoginal U anv V matrices, the remainder ignored is
        % ....ignored
        [U, ignored] = qr(randn(matSizes(matrixSize)));
        [V, ignored] = qr(randn(matSizes(matrixSize)));
        s = linspace(conditionList(condition), 1, matSizes(matrixSize));
        S = zeros(matSizes(matrixSize));

        for i=1:length(s)
            S(i,i) = s(i);
        end
        A = U * S * V';
        Ainv = inv(A);
        IdentA = A * Ainv;
        normIdent = norm(abs(IdentA - eye(matSizes(matrixSize))));
        results(matrixSize, condition) = normIdent;
    end
end

%imagesc(results)

pcolor(conditionList, 2:70, results);
xlabel('Condition number');
ylabel('Matrix size');
set(gca,'clim',[0 max(results(:))*.6])
colorbar