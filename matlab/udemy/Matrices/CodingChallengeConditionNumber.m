% Method to set condition number on a matrix
% Condition number is Omega max / Omega min (for non-singular matrices)

m=5;
A = randn(m);

[U,S,V] = svd(A);

targetCondition = 36.3;

% For testing
currentCondition = S(1,1) / S(m,m); % singular values are always sorted high to low on the diagonal
multiplier = targetCondition / currentCondition;

S(1,1) = multiplier * S(1,1); % Scale the largest singular value by multiplier

Ac = U * S * V'; % Get a new matrix with updated singular values

% Here's the way the professor did it

m = 6;
n = 5;

[U, ignored] = qr(randn(m)); % Get an orthogonal random U
[V, ignored2] = qr(randn(n)); % Get an orthogonal random V

s = linspace(targetCondition, 1, min(m,n));
S = zeros(m,n);

for i=1:length(s)
    S(i,i) = s(i);
end

Acond = U * S * V';

disp(['Condition of Acond is ', num2str(cond(Acond))]); 

figure(1), clf
subplot(231), imagesc(U), axis square, axis off, title('U')
subplot(232), imagesc(S), axis square, axis off, title('S')
subplot(233), imagesc(V), axis square, axis off, title('V')
subplot(235), imagesc(Acond), axis square, axis off
title(['A with condition of ' , num2str(cond(Acond))])

    
