% Create a reduced rank matrix using multiplication

% Create a 10x10 matrix with rank 4 (use matrix multiplication to get
% there)

% Generalize the procedure to create an MxN matrix with rank r

m = 10;
n = 9;
r = 4;

RankedMatrix = randi(25,m,4) * randi(25,4,n);

calRank = rank(RankedMatrix);

disp({ RankedMatrix, calRank });