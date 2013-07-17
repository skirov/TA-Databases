using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using EntityFramework.Data;

namespace _01.TryInclude
{
    class Program
    {
        static TelerikAcademyEntities context = new TelerikAcademyEntities();

        static void GetInfoWithoutInclude()
        {
            foreach (var employee in context.Employees)
            {
                Console.WriteLine("{0} {1}", employee.FirstName, employee.LastName);
                Console.WriteLine("{0}", employee.Department);
                Console.WriteLine("{0}", employee.Address.Town.Name);
                Console.WriteLine();
            }
            Console.WriteLine(context.Employees.Count());
        }

        static void GetInfoWithInclude()
        {
            foreach (var employee in context.Employees.Include("Address"))
            {
                Console.WriteLine("{0} {1}", employee.FirstName, employee.LastName);
                Console.WriteLine("{0}", employee.Department);
                Console.WriteLine("{0}", employee.Address.Town.Name);
                Console.WriteLine();
            }
        }

        static void Main(string[] args)
        {
            GetInfoWithInclude();
            //GetInfoWithoutInclude();
        }
    }
}
