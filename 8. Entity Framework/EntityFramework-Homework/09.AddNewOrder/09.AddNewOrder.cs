using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _00.EntityFramework.Data;
using System.Transactions;

class Program
{
    static void InsertOrder(
        string shipName, string shipAddress,
        string shipCity, string shipRegionm,
        string shipPostalCode,string shipCountry,
        string customerID = null, int? employeeID = null,
        DateTime? orderDate = null, DateTime? requiredDate = null,
        DateTime? shippedDate = null, int? shipVia = null,
        decimal? freight = null)
    {
        using (NorthwindEntities context = new NorthwindEntities())
        {
            Order newOrder = new Order
            {
                ShipAddress = shipAddress,
                ShipCity = shipCity,
                ShipCountry = shipCountry,
                ShipName = shipName,
                ShippedDate = shippedDate,
                ShipPostalCode = shipPostalCode,
                ShipRegion = shipRegionm,
                ShipVia = shipVia,
                EmployeeID = employeeID,
                OrderDate = orderDate,
                RequiredDate = requiredDate,
                Freight = freight,
                CustomerID = customerID
            };

            context.Orders.Add(newOrder);

            context.SaveChanges();

            Console.WriteLine("Row is inserted.");
        }
    }

    static void InsertMultiple()
    {
        for (int i = 0; i < 5; i++)
        {
            InsertOrder(null, null, null, null, null, null, null, null, null, null, null, null, null);
        }
    }

    static void Main(string[] args)
    {
        using (TransactionScope scope = new TransactionScope())
        {
            using(NorthwindEntities context = new NorthwindEntities())
            {
                InsertMultiple();
            }
            scope.Complete();
        }
    }
}
