% Demonstrates the mnemonic (LIVE)'=(E'V'I'L')
% Where the transpose of the multiplication of L I V E is equal to 
% The reverse of order of operations, transpose of the individual matrices
% first

m = 5;
L = randi([0,10],m,m);
I = randi([0,10],m,m);
V = randi([0,10],m,m);
E = randi([0,10],m,m);

RES1 = (L * I * V * E)';
RES2 = (E' * V' * I' * L');

%Test for equality, should result in a zero matrix (if using floats, near 0
%due to rounding)
RES2 - RES1 %#ok<NOPTS>