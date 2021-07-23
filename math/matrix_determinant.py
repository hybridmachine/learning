# Write code that illustrated that det(Beta*A) = Beta^M*det(A) where A is a matrix in MxM space
# Coding challenge 11.21 - 1 page 326 Linear Algebra by Mike X Cohen
#
import numpy as np

M = 4
A = np.random.randint(0, 10, size=(M, M))
Beta = np.random.randint(-10,-1)

print(A)
print(Beta)

detBetaA = np.linalg.det(Beta*A)
detBetaThenA = (Beta**M)*np.linalg.det(A)

print(detBetaA)
print(detBetaThenA)