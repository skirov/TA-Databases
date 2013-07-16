using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _00.EntityFramework.Data;

class Program
{
    static void Main()
    {
        using (NorthwindEntities northwindEntities1 = new NorthwindEntities())
        {
            using (NorthwindEntities northwindEntities2 = new NorthwindEntities())
            {
                Customer customerByFirstDataContext = northwindEntities1.Customers.Find("CHOPS");
                customerByFirstDataContext.Region = "SW";

                Customer customerBySecondDataContext = northwindEntities2.Customers.Find("CHOPS");
                customerBySecondDataContext.Region = "SSWW";

                northwindEntities1.SaveChanges();
                northwindEntities2.SaveChanges();
            }
        }

        Console.WriteLine("Changes successfully made!");
    }
}
