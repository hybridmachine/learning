using System;
using System.IO;
using System.Text;
using System.Security.Cryptography;

public class EncryptDecryptExample
{
    public static int Main(string[] args)
    {
        if (args.Length != 3)
        {
            Console.WriteLine ("Usage: crypto.exe -e|-d <path to file to encrypt|decrypt> <password>");
            return -1;
        }

        // The encryption key is a SHA256 of the password, allowing any length password to be used
        byte[] key = SHA256.HashData(Encoding.UTF8.GetBytes(args[2]));
        
        if (args[1] == "-e")
        {
            try
            {
                //Create a file stream
                using FileStream inStream = new FileStream(args[0], FileMode.OpenOrCreate);
                using FileStream outStream = new FileStream($"{args[0]}.crypt", FileMode.OpenOrCreate);

                //Create a new instance of the default Aes implementation class  
                // and configure encryption key.  
                using Aes aes = Aes.Create();
                aes.Key = key;

                //Stores IV at the beginning of the file.
                //This information will be used for decryption.
                byte[] iv = aes.IV;
                outStream.Write(iv, 0, iv.Length);

                //Create a CryptoStream, pass it the FileStream, and encrypt
                //it with the Aes class.  
                using CryptoStream cryptStream = new CryptoStream(
                    outStream, 
                    aes.CreateEncryptor(),
                    CryptoStreamMode.Write);

                //Create a StreamWriter for easy writing to the
                //file stream.  
                using StreamWriter sWriter = new StreamWriter(cryptStream);

                //Write to the stream.  
                using (StreamReader fileReader = new StreamReader(inStream))
                {
                    sWriter.Write(fileReader.ReadToEnd());
                }

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
        }
        else
        {
            try
            {
                //Create a file stream
                using FileStream myStream = new FileStream($"{args[0]}.crypt", FileMode.OpenOrCreate);

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
                Console.WriteLine("The decryption failed, check your password and try again.");
            }
            
        }

        return 0;
    }
}
