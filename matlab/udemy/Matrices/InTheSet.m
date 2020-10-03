%%
% Course: Linear Algebra
% Test in the set

% set to test
s = [ [2 6 -3]' [0 -2 9]'];

% is this vector in the set?
vec = [1 2 3];

% Plot to see
figure(6), clf, hold on;
plot3([0 s(1,1)],[0 s(2,1)], [0 s(3,1)], 'g', 'linew', 3);
plot3([0 s(1,2)],[0 s(2,2)], [0 s(3,2)], 'g', 'linew', 3);

% plot the vector to see if it falls in the span above
plot3([0 vec(1)], [0 vec(2)], [0 vec(3)], 'b', 'linew', 3);

rotate3d on;