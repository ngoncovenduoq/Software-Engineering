using System;
using System.Security.Cryptography;
using System.Text;

class Program
{
    static void Main(string[] args)
    {
        string password = "MatKhauMoi"; // Thay bằng mật khẩu bạn muốn chuyển
        string hashedPassword = GenerateSHA512Hash(password);
        
        Console.WriteLine("Mật khẩu gốc: " + password);
        Console.WriteLine("SHA-512 Hash: " + hashedPassword);
    }

    static string GenerateSHA512Hash(string input)
    {
        using (SHA512 sha512 = SHA512.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(input); // Chuyển đổi chuỗi thành mảng byte
            byte[] hashBytes = sha512.ComputeHash(bytes); // Tạo giá trị băm

            // Chuyển byte array thành chuỗi hex
            StringBuilder hashStringBuilder = new StringBuilder();
            foreach (byte b in hashBytes)
            {
                hashStringBuilder.Append(b.ToString("X2")); // X2 để chuyển byte thành dạng hex viết hoa
            }

            return hashStringBuilder.ToString();
        }
    }
}
