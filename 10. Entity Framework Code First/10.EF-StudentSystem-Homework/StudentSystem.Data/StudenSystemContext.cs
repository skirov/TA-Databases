using System;
using System.Data.Entity;
using StudentSystem.Models;
using System.Linq;

namespace StudentSystem.Data
{
    public class StudentSystemContext : DbContext
    {
        public StudentSystemContext()
            : base("StudentSystemDB")
        {

        }

        public DbSet<Course> Courses { get; set; }

        public DbSet<Homework> Homeworks { get; set; }

        public DbSet<Material> Materials { get; set; }

        public DbSet<Student> Students{ get; set; }
    }
}
