% Show and prove the conditions that make <Av,w> = <v,Aw> v != w
% A is a matrix
% v & w are matrices with same row count as A col count
% < > means dot product of arguments
% Conditions
% A must be symmetric (meaning it must also be square)
% v & w must have same row count as A column count

A = randi(25,3,3);
A = A' * A; % Make a a symmetric matrix
v = randi(25,3,1);
w = randi(25,3,1);

d1 = dot(A*v,w);
d2 = dot(v,A*w);

disp(["d1" "d2"]);
disp([d1 d2]);


