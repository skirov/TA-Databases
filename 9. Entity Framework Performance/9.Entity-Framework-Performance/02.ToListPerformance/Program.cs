using EntityFramework.Data;
using System;
using System.Collections.Generic;
using System.Linq;

namespace _02.ToListPerformance
{
    class Program
    {
        static void Main(string[] args)
        {
            TelerikAcademyEntities context = new TelerikAcademyEntities();

            //var allEmployees = context.Employees.ToList()
            //                          .Select(e => e.Address).ToList()
            //                          .Select(e => e.Town).ToList()
            //                          .Where(e => e.Name == "Sofia");

            var allEmployeesOptimized = context.Employees
                                               .Select(e => e.Address)
                                               .Select(e => e.Town)
                                               .Where(e => e.Name == "Sofia").ToList();
        }
    }
}
