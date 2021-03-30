% Create a matrix (3x6 to start)
m = 3;
n = 6;
A = randn(m,n);
% Perform the SVD on that matrix , these are the references
% to show our calculations are correct
% Store in Us, Ss, Vs
[Us, Ss, Vs] = svd(A);

% Take the eigendecomp of A'A and store in V and L
[V, L] = eig(A'*A);
[l, sidx] = sort(diag(L), 'descend');

% Re-sort to match what SVD will output
L = diag(l);
V = V(:,sidx);

% Confirm that V = Vs
% While 3 columns match, 3 do not, not sure why yet
% Watched lecture, the reason is that the row space match but the null
% space does not. A is rank (smallest between m and n) 3 in the 3x6 case
% for example. That means the first three columns between V and Vs (V being
% sorted like Vs) will match, but the next 3 columns are in the null space
% and will not necessarily match

% Check the relationship between Ss and L
% The nonzero values of L are the square of the values in Ss

% Create U using only A, V, and L
% Remember that Avi = ui*sigmai where sigmai is the ith singular value, and
% i is the ith column in each respective V and U matrix
U = zeros(m,m);
for idx=1:m
    % Here we assume V and L are sorted highest to lowest
    U(:,idx) = (A * V(:,idx)) / (sqrt(L(idx,idx)));
end
    
% Confirm that U = Us
disp ([ U Us ])