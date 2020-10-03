% Is the dot product commutative?
% a'*b == b'*a ?

%1) Generate two 100 element random row vectors compute dot product a with
% b and b with a
vec1 = rand(1,100);
vec2 = rand(1,100);

dotProd1 = vec1*vec2';
dotProd2 = vec2*vec1';

display([ dotProd1 dotProd2 ]);

vecInt1 = [ -3 6 ];
vecInt2 = [ 7 12 ];

dotProd1 = vecInt1*vecInt2';
dotProd2 = vecInt2*vecInt1';

display([ dotProd1 dotProd2 ]);