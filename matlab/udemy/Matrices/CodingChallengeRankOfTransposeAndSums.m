% Refresher: rank of A*B is <= min {rank(A), rank(B)}
%            rank of A+B is <= rank(A) + rank(B)
%
% generate two rectangular matrices (A and B) 2x5 for example
% compute AtA and BtB
% Find rank of A and B and AtA and BtB
m = 2;
n = 5;

A = randi(25,m,n);
B = randi(25,m,n);

AtA = A' * A;
BtB = B' * B;

disp ({'A', 'B', 'AtA', 'BtB'});
disp ({rank(A), rank(B), rank(AtA), rank(BtB)});

disp ({rank(AtA * BtB)})
disp ({rank(AtA + BtB)})