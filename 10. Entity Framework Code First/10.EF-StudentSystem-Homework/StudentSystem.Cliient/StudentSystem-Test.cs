using System;
using System.Linq;
using StudentSystem.Data;
using StudentSystem.Models;
using System.Data.Entity;
using StudentSystem.Data.Migrations;

namespace StudentSystem.Cliient
{
    class StudentSystemTest
    {
        static StudentSystemContext context = new StudentSystemContext();

        static void ParseCommand(string command)
        {
            switch (command)
            {
                case "1":
                    ListAllStudents(); break;
                case "2":
                    ListAllCourses(); break;
                case "3":
                    LisAllCoursesAndStudents(); break;
                default: 
                    Console.WriteLine("Error reading command.");
                    break;
            }
        }

        private static void LisAllCoursesAndStudents()
        {
            var allCourses = context.Courses.ToList();

            foreach (var course in allCourses)
            {
                Console.WriteLine("{0}-{1}", course.Name, course.Description);
                Console.WriteLine("     Students in this course:");
                foreach (var student in course.Students)
                {
                    Console.WriteLine("     -{0} - {1}", student.Name, student.FacultyNumber);
                }
            }
        }

        private static void ListAllStudents()
        {
            var allStudents = context.Students.ToList();

            foreach (var student in allStudents)
            {
                Console.WriteLine("{0} - {1}", student.Name, student.FacultyNumber);
            }
        }

        private static void ListAllCourses()
        {
            var allCourses = context.Courses.ToList();

            foreach (var course in allCourses)
            {
                Console.WriteLine("{0}-{1}", course.Name, course.Description);
            }
        }

        static void Main()
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<StudentSystemContext, Configuration>());
            context.Database.Initialize(true);

            Console.WriteLine("{0}", new string('*', Console.WindowWidth));
            Console.WriteLine("Commands:");
            Console.WriteLine("List all students - 1");
            Console.WriteLine("List all courses - 2");
            Console.WriteLine("List all courses with their students - 3");
            Console.WriteLine("{0}", new string('*', Console.WindowWidth));

            Console.Write("Enter a command number: ");
            string commandNumber = Console.ReadLine().Trim();

            ParseCommand(commandNumber);
        }
    }
}
