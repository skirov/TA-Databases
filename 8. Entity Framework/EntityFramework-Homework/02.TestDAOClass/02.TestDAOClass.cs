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
        //DAO.InsertCustomer("ABVWW", "Na Bai Kolio Firmata", "Kolio");
        //DAO.UpdateCustomer("ABVWW", "Firmata na 4i4o Kolio", "Kiko");
        DAO.DeleteCustomer("ABVCS");
    }
}
