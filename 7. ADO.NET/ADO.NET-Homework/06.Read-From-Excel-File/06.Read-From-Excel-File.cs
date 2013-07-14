using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

class Program
{
    static void Main(string[] args)
    {
        string path = @"../../scores.xlsx";
        string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=Excel 12.0;";

        OleDbConnection excelCon = new OleDbConnection(connStr);
        excelCon.Open();

        using (excelCon)
        {
            OleDbCommand command = new OleDbCommand(@"SELECT * FROM [Sheet1$]", excelCon);
            OleDbDataReader reader = command.ExecuteReader();

            using (reader)
            {
                Console.WriteLine("All players:");
                Console.WriteLine();
                while (reader.Read())
                {
                    string playerName = (string)reader["Name"];
                    double playerScore = (double)reader["Score"];

                    Console.WriteLine("Player name: {0} | Player score: {1}", playerName.PadRight(15), playerScore);
                }
            }
        }
    }
}
