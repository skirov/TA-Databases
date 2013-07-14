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
            SqlCommand command = new SqlCommand(@"
                                                    SELECT c.CategoryName, p.ProductName FROM Products p 
                                                        JOIN Categories c ON c.CategoryID = p.CategoryID
                                                    ORDER BY c.CategoryName
                                                 ", dbCon);
            SqlDataReader reader = command.ExecuteReader();

            using (reader)
            {
                Console.WriteLine("All products in a category:");
                Console.WriteLine();
                while (reader.Read())
                {
                    string categoryName = (string)reader["CategoryName"];
                    string categoryDesc = (string)reader["ProductName"];

                    Console.WriteLine("Cat name: {0} | Product name: {1}", categoryName.PadRight(15), categoryDesc);
                }
            }
        }
    }
}
