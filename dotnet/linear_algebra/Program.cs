using System;
using MathNet.Numerics.LinearAlgebra;
using MathNet.Numerics.LinearAlgebra.Double;
using linear_algebra.Examples;

namespace linear_algebra
{
    class Program
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            LeftOrthFromEig exampl1 = new LeftOrthFromEig();

            exampl1.Run();
        }
    }
}
