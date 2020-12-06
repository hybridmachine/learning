% Create a 6 x 6 full rank matrix
m = 6;
M1=randi(100,m,m);
det1 = det(M1);
swapme = M1(1,:);
M1(1,:) = M1(2,:);
M1(2,:) = swapme;

det2 = det(M1);

swapme = M1(3,:);
M1(3,:) = M1(2,:);
M1(2,:) = swapme;
det3 = det(M1);

disp([det1 det2 det3]);

% From the code challenge video, here's how he swaps rows

M1s = M1([2 1 3 4 5 6], :);
M1s2 = M1([2 1 3 5 4 6], :);

disp([det(M1) det(M1s) det(M1s2)]);

% Now lets try column swap
M1cs = M1(:,[2 1 3 4 5 6]);

disp([det(M1) det(M1cs)]);

M1cs2 = M1cs([2 1 3 4 5 6],:);
disp([det(M1) det(M1cs2)]);
