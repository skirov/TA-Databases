using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _00.EntityFramework.Data;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Data.SqlClient;

class Program
{
    static void Main(string[] args)
    {
        IObjectContextAdapter context = new NorthwindEntities();
        string cloneNorthwind = context.ObjectContext.CreateDatabaseScript();

        string createNorthwindCloneDB = "CREATE DATABASE NorthwindTwin ON PRIMARY " +
        "(NAME = NorthwindTwin, " +
        "FILENAME = 'E:\\NorthwindTwin.mdf', " +
        "SIZE = 5MB, MAXSIZE = 10MB, FILEGROWTH = 10%) " +
        "LOG ON (NAME = NorthwindTwinLog, " +
        "FILENAME = 'E:\\NorthwindTwin.ldf', " +
        "SIZE = 1MB, " +
        "MAXSIZE = 5MB, " +
        "FILEGROWTH = 10%)";

        SqlConnection dbConForCreatingDB = new SqlConnection(
            "Server=LOCALHOST; " +
            "Database=master; " +
            "Integrated Security=true");

        dbConForCreatingDB.Open();

        using (dbConForCreatingDB)
        {
            SqlCommand createDB = new SqlCommand(createNorthwindCloneDB, dbConForCreatingDB);
            createDB.ExecuteNonQuery();
        }

        SqlConnection dbConForCloning = new SqlConnection(
            "Server=LOCALHOST; " +
            "Database=NorthwindTwin; " +
            "Integrated Security=true");

        dbConForCloning.Open();

        using (dbConForCloning)
        {
            SqlCommand cloneDB = new SqlCommand(cloneNorthwind, dbConForCloning);
            cloneDB.ExecuteNonQuery();
        }
    }
}