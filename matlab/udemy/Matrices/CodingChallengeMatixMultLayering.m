% Implement matrix multiplication by layering

% Gen two matrices

M1 = randn(2,2);
M2 = randn(2,2);

for layer = 1:size(M2)(1)
  for leftCol = 1:size(M1)(2)
    for leftRow = 1:size(M1)(1)      
      for rightCol = 1:size(M2)(2)
        msg = sprintf("left row,col %d,%d : layer,col %d,%d", leftRow,leftCol,layer,rightCol);
        disp(msg);
      endfor
    endfor
  endfor
endfor
