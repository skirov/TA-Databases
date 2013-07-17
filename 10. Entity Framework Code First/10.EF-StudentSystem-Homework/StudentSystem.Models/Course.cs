using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace StudentSystem.Models
{
    public class Course
    {
        private ICollection<Student> students;
        private ICollection<Material> materials;
        private ICollection<Homework> homeworks;

        public Course()
        {
            this.students = new HashSet<Student>();
            this.materials = new HashSet<Material>();
            this.homeworks = new HashSet<Homework>();
        }

        [Key]
        public int CourseID { get; set; }

        [Required]
        public string Name { get; set; }

        public string Description { get; set; }

        public virtual ICollection<Material> Materials
        {
            get { return this.materials; }
            set { this.materials = value; }
        }

        public virtual ICollection<Student> Students
        {
            get { return students; }
            set { students = value; }
        }

        public virtual ICollection<Homework> Homeworks
        {
            get { return this.homeworks; }
            set { this.homeworks = value; }
        }
    }
}
