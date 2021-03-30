using MathNet.Numerics.LinearAlgebra;
using MathNet.Numerics.LinearAlgebra.Double;
using System;
namespace linear_algebra.Examples
{
    /// <summary>
    /// Coding challenge from https://www.udemy.com/course/linear-algebra-theory-and-implementation/learn/lecture/14670146#overview
    /// Compute the left orthogonal basis matrix of the SVD using the eigendecomp of A' * A 
    /// </summary>
    public class LeftOrthFromEig
    {

        public void Run()
        {
            // Create a 3x6 matrix
            int m = 3;
            int n = 6;
            Matrix<double> A = Matrix<double>.Build.Random(m, n);
            Matrix<double> AtA = A.Transpose() * A;

            var svdA = A.Svd(true);
            var eigAtA = AtA.Evd();

            Console.WriteLine(A.ToString());

            Console.WriteLine(svdA.U.ToString());
            Console.WriteLine($"SVD S = {svdA.W.ToString()}");
            Console.WriteLine($"EIG Vals = {eigAtA.EigenValues}");
            Console.WriteLine($"SVD VT = {svdA.VT.Transpose().ToString()}");
            Console.WriteLine($"EIG Vecs = {eigAtA.EigenVectors}");
        }
    }
}