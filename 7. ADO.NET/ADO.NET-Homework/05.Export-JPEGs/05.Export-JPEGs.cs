using System;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

class Program
{
    static void Main(string[] args)
    {
        //The pictures are stored in the bin folder of the project

        int OLE_METAFILEPICT_START_POSITION = 78;
        SqlConnection dbCon = new SqlConnection(
               "Server=LOCALHOST; " +
               "Database=Northwind; " +
               "Integrated Security=true");

        dbCon.Open();

        using (dbCon)
        {
            SqlCommand command = new SqlCommand("SELECT CategoryName, Picture FROM Categories", dbCon);
            SqlDataReader reader = command.ExecuteReader();

            using (reader)
            {
                Console.WriteLine("All products in a category:");
                Console.WriteLine();
                while (reader.Read())
                {
                    string categoryName = ((string)reader["CategoryName"]);
                    if (categoryName.Contains("/") == true)
                    {
                        categoryName = categoryName.Replace('/', ' ');
                    }
                    byte[] pictureBytes = reader["Picture"] as byte[];

                    MemoryStream stream = new MemoryStream(
                        pictureBytes, OLE_METAFILEPICT_START_POSITION,
                        pictureBytes.Length - OLE_METAFILEPICT_START_POSITION);

                    Image image = Image.FromStream(stream);
                    using (image)
                    {
                        image.Save(categoryName + ".jpg", ImageFormat.Jpeg);
                    }
                }      
            }
        }
    }
}
