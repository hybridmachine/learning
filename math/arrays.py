# create array
import numpy as np
from numpy import array
from numpy import empty
from numpy import zeros
from numpy import ones
from numpy import array
from numpy import vstack
from numpy import hstack

print("Create array")
# create array
l = [[1.0, 2.0, 3.0],[4.0, 1.5, 3.3]]
a = array(l)
# display array
print(a)
# display array shape
print(a.shape)
# display array data type
print(a.dtype)

print("-------------------------------------------------------------------")
print("Create array with empty")

a = empty([3,3])
print(a)

print("-------------------------------------------------------------------")
print("Create array with zeros")

a = zeros([3,5])
print(a)

print("-------------------------------------------------------------------")
print("Create array with ones")

a = ones([3,5])
print(a)

print("-------------------------------------------------------------------")
print("Create array with vstack")

# create array with vstack
# create first array
a1 = array([1,2,3])
print(a1)
# create second array
a2 = array([4,5,6])
print(a2)
# vertical stack
a3 = vstack((a1, a2))
print(a3)
print(a3.shape)

print("-------------------------------------------------------------------")
print("Create array with hstack")
# create first array
a1 = array([1,2,3])
print(a1)
# create second array
a2 = array([4,5,6])
print(a2)
# create horizontal stack
a3 = hstack((a1, a2))
print(a3)
print(a3.shape)
print("-------------------------------------------------------------------")
print("Create array with array then concatenate")
arr1 = np.array([1, 2, 3])
arr2 = np.array([4, 5, 6])
arr = np.concatenate((arr1, arr2))
print(arr) 

print("-------------------------------------------------------------------")
print("Create array with random")
x = np.random.randint(100, size=(3, 5))
print(x) 

print("-------------------------------------------------------------------")
print("Create array")
# create one-dimensional array
from numpy import array
# list of data
data = [11, 22, 33, 44, 55]
# array of data
data = array(data)
print(data)
print(type(data))

print("-------------------------------------------------------------------")
# create two-dimensional array
from numpy import array
# list of data
data = [[11, 22],
[33, 44],
[55, 66]]
print("Type for data before numpy conversion")
print(type(data))
# array of data
data = array(data)
print(data)
print("Type for data after numpy conversion")
print(type(data))
print("-------------------------------------------------------------------")
print("Indexing example")
#index a one-dimensional array
from numpy import array
# define array
data = array([11, 22, 33, 44, 55])
# index data
print(data[0])
print(data[4])
print("-------------------------------------------------------------------")
print("Negative indexing example")
# negative array indexing
from numpy import array
# define array
data = array([11, 22, 33, 44, 55])
# index data
print(data[-1])
print(data[-5])
print("-------------------------------------------------------------------")
print("index two-dimensional array")
from numpy import array
# define array
data = array([
[11, 22],
[33, 44],
[55, 66]])
# index data
print(data[1,1])
print("-------------------------------------------------------------------")
print("index row of two-dimensional array")
# index row of two-dimensional array
from numpy import array
# define array
data = array([
[11, 22],
[33, 44],
[55, 66]])
# index data
print(data[0,])

print("-------------------------------------------------------------------")
print("slice a subset of a one-dimensional array")
# Array slicing
# slice a subset of a one-dimensional array
from numpy import array
# define array
data = array([11, 22, 33, 44, 55])
print(data[-2:])
print(data[1:4])

print("-------------------------------------------------------------------")
print("split input and output data")
# define array
data = array([
[11, 22, 33],
[44, 55, 66],
[77, 88, 99]])
# separate data
X, y = data[:, :-1], data[:, -1]
print(X)
print(y)