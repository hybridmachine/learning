% create 2 4x6 matrices of random numbers
% use a for loop to compute dot products between corresponding columns

rowCount = 400;
columnCount = 600;

matrix1 = randn(rowCount, columnCount);
matrix2 = randn(rowCount, columnCount);

results = columnCount:1;

for col = 1:columnCount
    vec1 = matrix1(:,col);
    vec2 = matrix2(:,col);
    results(col) = dot(vec1,vec2);
end

disp(results);