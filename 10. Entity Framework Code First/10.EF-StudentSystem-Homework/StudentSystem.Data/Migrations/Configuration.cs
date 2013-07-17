namespace StudentSystem.Data.Migrations
{
    using StudentSystem.Models;
    using System;
    using System.Data.Entity.Migrations;
    using System.Linq;

    public sealed class Configuration : DbMigrationsConfiguration<StudentSystemContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = true;
        }

        protected override void Seed(StudentSystemContext context)
        {
            context.Courses.AddOrUpdate(
            c => c.Name,
                    new Course { Name = "Databases", Description = "Telerik Academy Databases course" },
                    new Course { Name = "C#", Description = "Telerik Academy C# course" }
                );

            context.Students.AddOrUpdate(
            s => s.Name,
                    new Student { Name = "Kiro", FacultyNumber = "11111111" },
                    new Student { Name = "Mitio", FacultyNumber = "22222222" },
                    new Student { Name = "Pesho", FacultyNumber = "33333333" }
                );

            context.Students
                .Where(x => x.FacultyNumber == "11111111")
                .First()
                .Courses.Add(context.Courses.Where(c => c.Name == "C#").First());

            context.Students
                .Where(x => x.FacultyNumber == "11111111")
                .First()
                .Courses.Add(context.Courses.Where(c => c.Name == "Databases").First());

            context.Students
                .Where(x => x.FacultyNumber == "22222222")
                .First()
                .Courses.Add(context.Courses.Where(c => c.Name == "C#").First());

            context.Students
                .Where(x => x.FacultyNumber == "33333333")
                .First()
                .Courses.Add(context.Courses.Where(c => c.Name == "Databases").First());

            context.SaveChanges();
        }
    }
}
