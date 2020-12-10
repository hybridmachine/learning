% Generate a square random matrix (say 20x20)
% impose a linear dependence (reduce rank matrix)
% "shift" the matrix (0 -> 0.1 * identity matrix). 
% compute the abs(determinent) of the shifted matrix
% repeat the above 1000 times for each shift value, take an average of the
% abs(determinent)
% plot the avg abs det vs shift amount 

% Generate a square random matrix (say 20x20)
sz = 20;

keyset = 0:0.005:0.1;
keysetSize = size(keyset);
valset = zeros(1,keysetSize(2));

% "shift" the matrix (0 -> 0.1 * identity matrix). 
shiftIdx = 1;
for shift = keyset
    runIdx = 0;
    determinentVal = 0;
    for run = 1:1000
        % Generate a square random matrix (say 20x20)
        M1 = randi(100, sz,sz);

        % impose a linear dependence (reduce rank matrix)
        M1(:,1) = M1(:,2); % Copy column 2 to column 1 to reduce rank
        
        % "shift" the matrix (0 -> 0.1 * identity matrix).
        M1 = M1 + eye(sz) * shift;
        
        % compute the abs(determinent) of the shifted matrix
        determinentVal = determinentVal + abs(det(M1));
        runIdx = runIdx + 1;
    end
    % take an average of the abs(determinent)
    determinentVal = determinentVal / runIdx;
    valset(shiftIdx) = determinentVal;
    shiftIdx = shiftIdx + 1;
end

% plot the avg abs det vs shift amount 
plot(keyset,valset,'s-')
xlabel("Fraction of identity matrix for shifting")
ylabel("Determinent")
