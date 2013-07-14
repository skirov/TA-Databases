using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

class Program
{
    private static void InsertProduct(string ProductName, int SupplierID, int CategoryID, string QuantityPerUnit, decimal UnitPrice,
                               int? UnitsInStock, int UnitsOnOrder, int ReorderLevel, bool Discontinued, SqlConnection dbCon)
    {
        SqlCommand insertProduct = new SqlCommand(@"INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
                                                                          UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
                                VALUES (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, 
                                         @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued)", dbCon);
        insertProduct.Parameters.AddWithValue("@ProductName", ProductName);
        insertProduct.Parameters.AddWithValue("@SupplierID", SupplierID);
        insertProduct.Parameters.AddWithValue("@CategoryID", CategoryID);
        insertProduct.Parameters.AddWithValue("@QuantityPerUnit", QuantityPerUnit);
        insertProduct.Parameters.AddWithValue("@UnitPrice", UnitPrice);
        insertProduct.Parameters.AddWithValue("@UnitsInStock", UnitsInStock);
        insertProduct.Parameters.AddWithValue("@UnitsOnOrder", UnitsOnOrder);
        insertProduct.Parameters.AddWithValue("@ReorderLevel", ReorderLevel);
        insertProduct.Parameters.AddWithValue("@Discontinued", Discontinued);

        insertProduct.ExecuteNonQuery();
    }
    //
    static void Main(string[] args)
    {
        SqlConnection dbCon = new SqlConnection(
            "Server=LOCALHOST; " +
            "Database=Northwind; " +
            "Integrated Security=true");

        dbCon.Open();

        using (dbCon)
        {
            InsertProduct("Chalga Video Kaseti", 1, 2, "Mnogo na vednuj", 100.00M, 10, 0, 15, true, dbCon);
            Console.WriteLine("Row is inserted.");
        }
    }
}
