% Implement the fourier transform (this is not the fast version)
% using matrix multiplication

% Build the fouier matrix F_j,_k = omega^m
% Where j and k are the element in the Fourier matrix
% omega = e^(-2pi * i /n) where n is the size of square matrix F
% m = (j-1)(k-1) note this is 1 indexed not 0 indexed

n=10;
F=zeros(n);

for j = 1:size(F,1)
    for k = 1:size(F,2)
        F(j,k) = (exp((-2*pi*i/n))^((j-1)*(k-1)))
    end
end

% NOw test it

%x = randi(99,n,1);
x = [ 1;2;3;4;5;6;7;8;9;10];
X = F*x;

xfft = fft(x);

X - xfft