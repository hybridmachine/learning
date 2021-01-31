% Show that A'A == R'R (from QR decomposition)
% 1) Generate random A
% 2) Compute QR (using qr method is fine)
% 3) Test the claim, compare A'A and R'R

m = 7;
n = 12;
A = randn(m,n);

[Q, R] = qr(A);

AtA = A'*A;
RtR = R'*R;

round(AtA - RtR,5)