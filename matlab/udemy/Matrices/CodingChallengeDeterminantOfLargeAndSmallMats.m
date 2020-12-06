% Singular (reduced rank) matrices have a determinant of 0
% Test this out in code, see what happens when matrices are large

M2by2 = randi(100, 2,2);
M2by2(:,1) = M2by2(:,2);

m = 20;
Mmbym = randi(100, m,m);
Mmbym(2,:) = Mmbym(1,:);

disp({det(M2by2), det(Mmbym)})
