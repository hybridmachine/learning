% Coding challenge to see if scalar multiplication changes the rank of a
% matrix

m = 5;
r = 3;
l = 8;
F = randi(25, m,m);
R = randi(25,m,r) * randi(25,r,m);

disp
({'rank(F)', 'rank(l*F)', 'rank(R)', 'rank(l*R)', 'l*rank(R)'})
disp ({rank(F), rank(l*F), rank(R), rank(l*R), l*rank(R)})
