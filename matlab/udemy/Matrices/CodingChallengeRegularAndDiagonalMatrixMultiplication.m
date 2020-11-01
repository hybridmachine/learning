% Create two matrices, one "full" (non zero off the diagonal) and diagonal
% (zeros off the diagonal)

FULL1 = randi(10,4);
DIAG1 = diag(randi(10,4,1));
     
     
 FULL1 * FULL1
 FULL1 .* FULL1
 
 DIAG1 * DIAG1
 DIAG1 .* DIAG1