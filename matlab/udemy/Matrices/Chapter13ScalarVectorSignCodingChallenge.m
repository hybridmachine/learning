% test whether the dot product sign is invariant to scalar multiplication

% generate two vectors in r3
vec1 = [3 6 9];
vec2 = [7 22 11];

% generate two scalars
scal1 = 5;
scal2 = -3;

% compute the dot product between vectors

dotProd1 = dot(vec1,vec2);

% compute the dot product between the scaled vectors

dotProd2 = dot((scal1 * vec1), (scal2 * vec2));

disp ([ dotProd1 dotProd2])