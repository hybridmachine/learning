% Show what happens when you have repeated eigen values, and how that can
% map to an eigen plane instead of a single eigen vector , for the related
% eigenvalue

% a matrix
A = [ 5 -1 0;
     -1  5 0;
     1/3 -1/3 4];
 
% get the eigen decompisition
[V,D] = eig(A);
% sort eigenvalues
[D, sort_idx] = sort(diag(D));
V = V(:,sort_idx);

% plot eigenvectors
figure(2),clf, hold on
plot3([0 V(1,1)],[0 V(2,1)], [0 V(3,1)],'k','linew',3)
plot3([0 V(1,2)],[0 V(2,2)], [0 V(3,2)],'r','linew',3)
plot3([0 V(1,3)],[0 V(2,3)], [0 V(3,3)],'b','linew',3)
