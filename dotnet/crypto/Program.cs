using System;
using System.IO;
using System.Security.Cryptography;

public class EncryptDecryptExample
{
    public static void Main(string[] args)
    {
        //Encryption key used to encrypt the stream.
        //The same value must be used to encrypt and decrypt the stream.
        //byte[] key = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16 };
        byte[] key = { 0x26, 0x00, 0x17, 0x00, 0xb9, 0x00, 0xef, 0x00, 0x80, 0xb7, 0x4a, 0x82, 0x2b, 0x5a, 0x5d, 0x6f };
        try
        {
            //Create a file stream
            using FileStream myStream = new FileStream("TestData.txt", FileMode.OpenOrCreate);

            //Create a new instance of the default Aes implementation class  
            // and configure encryption key.  
            using Aes aes = Aes.Create();
            aes.Key = key;

            //Stores IV at the beginning of the file.
            //This information will be used for decryption.
            byte[] iv = aes.IV;
            myStream.Write(iv, 0, iv.Length);

            //Create a CryptoStream, pass it the FileStream, and encrypt
            //it with the Aes class.  
            using CryptoStream cryptStream = new CryptoStream(
                myStream, 
                aes.CreateEncryptor(),
                CryptoStreamMode.Write);

            //Create a StreamWriter for easy writing to the
            //file stream.  
            using StreamWriter sWriter = new StreamWriter(cryptStream);

            //Write to the stream.  
            sWriter.WriteLine("Hello World!");

            //Inform the user that the message was written  
            //to the stream.  
            Console.WriteLine("The file was encrypted.");
        }
        catch
        {
            //Inform the user that an exception was raised.  
            Console.WriteLine("The encryption failed.");
            throw;
        }


		try
		{
            //Create a file stream
            using FileStream myStream = new FileStream("TestData.txt", FileMode.OpenOrCreate);

            //Create a new instance of the default Aes implementation class  
            // and configure decryption key.  
            using Aes aes = Aes.Create();
            aes.Key = key;

            //Reads IV value from beginning of the file.
            byte[] iv = new byte[aes.IV.Length];
            myStream.Read(iv, 0, iv.Length);


            //Create a CryptoStream, pass it the FileStream, and decrypt
            //it with the Aes class.  
            using CryptoStream cryptStream = new CryptoStream(
                myStream, 
                aes.CreateDecryptor(key, iv),
                CryptoStreamMode.Read);

            using (StreamReader sr = new StreamReader(cryptStream))
            {
                while (sr.Peek() >= 0)
                {
                    Console.WriteLine(sr.ReadLine());
                }
            }

        }
        catch
        {
            //Inform the user that an exception was raised.  
            Console.WriteLine("The decryption failed.");
            throw;
        }
		
    }
}
