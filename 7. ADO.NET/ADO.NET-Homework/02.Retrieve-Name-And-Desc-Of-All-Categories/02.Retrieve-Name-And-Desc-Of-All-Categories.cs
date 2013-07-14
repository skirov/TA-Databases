using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

class Program
{
    static void Main(string[] args)
    {
        SqlConnection dbCon = new SqlConnection(
            "Server=LOCALHOST; " +
            "Database=Northwind; " +
            "Integrated Security=true");

        dbCon.Open();

        using (dbCon)
        {
            SqlCommand command = new SqlCommand("SELECT CategoryName, Description FROM Categories", dbCon);
            SqlDataReader reader = command.ExecuteReader();

            using (reader)
            {
                Console.WriteLine("Name and Descriptin of all categories:");
                Console.WriteLine();
                while(reader.Read())
                {
                    string categoryName = (string)reader["CategoryName"];
                    string categoryDesc= (string)reader["Description"];

                    Console.WriteLine("Name: {0} | Description: {1}", categoryName.PadRight(14), categoryDesc);
                }
            }
        }
    }
}
