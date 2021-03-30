% Use matrix rank to determine if a given vector is in the span of a given
% set of vectors

v = [1 2 3 4]';

S = [[4 3 6 2]' [0 4 0 1]'];
T = [[1 2 2 2]' [0 0 1 2]'];


rank(S)
rank([T v])