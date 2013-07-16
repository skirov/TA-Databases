using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _00.EntityFramework.Data;

class Program
{
    static void Main(string[] args)
    {
        Employee extended = new Employee();

        NorthwindEntities context = new NorthwindEntities();

        extended = context.Employees.Find(1);

        foreach (var item in extended.EntityTerritories)
        {
            Console.WriteLine("Teritory description - {0}",item.TerritoryDescription);
        }
    }
}
