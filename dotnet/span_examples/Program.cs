using System;
using System.Diagnostics;
using System.Collections.Generic;

namespace span_examples
{
    class Program
    {
        struct MutableStruct { public int Value; }
        static void Main(string[] args)
        {
            
            Span<MutableStruct> spanOfStructs = new MutableStruct[1];
            spanOfStructs[0].Value = 42;
            Debug.Assert(42 == spanOfStructs[0].Value);
            var listOfStructs = new List<MutableStruct> { new MutableStruct() };
            //listOfStructs[0].Value = 42; // Error CS1612: the return value is not a variable
        }
    }

}
