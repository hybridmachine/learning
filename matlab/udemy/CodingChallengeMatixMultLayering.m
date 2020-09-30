% Implement matrix multiplication by layering

% Gen two matrices

M1 = randn(2,2);
M2 = randn(2,2);

for leftCol = 1:size(M1)(2)
  for leftRow = 1:size(M1)(1)
    for rightRow = 1:size(M2)(1)
      for rightCol = 1:size(M2)(2)
        msg = sprintf("left row %d : right col %d",leftRow,rightCol);
        disp(msg);
      endfor
    endfor
  endfor
endfor
