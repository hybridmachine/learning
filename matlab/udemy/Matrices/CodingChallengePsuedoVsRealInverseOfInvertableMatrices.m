% Compute the inverse and psuedoinverse of an invertable matrix, see if
% they are the same

M1 = rand(5,5);
M1_inv = inv(M1);
M1_pinv = pinv(M1);

M1_inv

M1_pinv

M1_inv - M1_pinv

M1 * M1_pinv