using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace StudentSystem.Models
{
    public class Student
    {
        private ICollection<Course> courses;
        private ICollection<Homework> homeworks;

        public Student()
        {
            this.courses = new HashSet<Course>();
            this.homeworks = new HashSet<Homework>();
        }

        [Key]
        public int StudentID { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string FacultyNumber { get; set; }

        public virtual ICollection<Homework> Homeworks
        {
            get{ return this.homeworks; }
            set { this.homeworks = value; }
        }

        public virtual ICollection<Course> Courses
        {
            get { return courses; }
            set { courses = value; }
        }
    }
}
