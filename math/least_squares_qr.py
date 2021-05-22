# Perform least squares solving using QR decomposition
# XB = y can be written as X'XB = X'y then using QR decomp
# (QR)'(QR)B = (QR)'y
# Which then becomes
# R'Q'QRB = R'Q'y
# R'RB = R'Q'y
# B = inv(R'R)R'Q'y
# inv(R'R) is numerically stable to compute vs standard left inverse of X
import numpy as np

# Design matrix
X = np.random.randint(100, size=(10, 3))
print(X)

# observations matrix
y = np.random.randint(100, size=(10, 1))
print(y)

Q,R = np.linalg.qr(X)
print(Q)
print(R)
print(R.transpose())
#print(np.dot(Q,R))

RtQt = np.dot(R.transpose(),Q.transpose())
beta1 = np.dot(np.dot((np.linalg.inv(np.dot(R.transpose(),R))),RtQt),y)

XtX = np.dot(X.transpose(),X)
XtXinv = np.linalg.inv(XtX)
beta2 = np.dot(np.dot(XtXinv,X.transpose()),y)

print(beta1)
print(beta2)