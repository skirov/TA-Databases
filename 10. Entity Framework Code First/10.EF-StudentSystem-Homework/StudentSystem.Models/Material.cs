using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace StudentSystem.Models
{
    public class Material
    {
        public Material()
        {
        }

        [Key]
        public int MaterialID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }
    }
}
