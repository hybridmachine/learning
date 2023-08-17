% If (A-B)v = lv
% Show that (A^2 -AB -BA +B^2)v = l^2v
%
% First A-B can be set to single matrix W (A-B) == W
% Then by the rules of algebra, we show that that W^2 == (A^2-AB-BA+B^2)
% using the F.O.I.L. multiplication of (A-B)(A-B)
% Then W^2v = l^2v by the rules of diagonlization and powers for
% eigendecomposable matrices
% And since W = (A-B) then W^2 == (A^2-AB-BA+B^2) from which we show that
% (A^2-AB-BA+B^2)v = l^2v

M = 5;
A = randn(5);
B = randn(5);
A = A*A'; % Make symmetric to avoid complex numbers
B = B*B';
W = (A-B);

[V,L] = eig(A-B);

ABS = (A^2-A*B-B*A+B^2);
WS = W^2;
ABV = ABS*V;
VLS = V*(L^2);

ABV-VLS