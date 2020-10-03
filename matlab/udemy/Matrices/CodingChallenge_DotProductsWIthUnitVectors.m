% Create two random integer vectors in R4
rng('shuffle');
v1 = randi(1000,4,1);
v2 = randi(1000,4,1);
% Compute the lengths of the individual vectors and magnitude of their dot
% product

v1Len = sqrt(v1'*v1);
v2Len = sqrt(v2'*v2);

v12dot = dot(v1,v2);

% "normalize" the vectors (divide the vectors by their lengths, this makes
% a unit vector

v1unit = v1 / v1Len;
v2unit = v2 / v2Len;

v1unilen = norm(v1unit);
v2unilen = norm(v2unit);

% Take the dot product of the normalized vectors and compute the magnitude of the dot product

v12uniDot = dot(v1unit,v2unit)