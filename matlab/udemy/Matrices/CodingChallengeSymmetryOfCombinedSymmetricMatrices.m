% Create two symmetric matrices

M1 = randi(10, 3,3);
M2 = randi(10, 3,3);

% Make symmetric matrices from the source matrices
SM1 = M1*M1';
SM2 = M2*M2';

SUM1 = SM1 + SM2;
MULT1 = SM1 * SM2;
HMULT1 = SM1 .* SM2;

SUM1 - SUM1'
MULT1 - MULT1'
HMULT1 - HMULT1'