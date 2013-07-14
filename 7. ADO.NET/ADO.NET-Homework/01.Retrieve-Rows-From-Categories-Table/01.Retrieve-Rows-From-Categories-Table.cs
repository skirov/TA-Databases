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
            SqlCommand command = new SqlCommand("SELECT COUNT(0) FROM Categories", dbCon);

            int numberOfRowsFromCategory = (int)command.ExecuteScalar();
            Console.WriteLine("The number of rows from the categories table is -> {0}", numberOfRowsFromCategory);
        }
    }
}

