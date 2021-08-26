namespace StockManagement.ORM.DBModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CompactDisc")]
    public partial class CompactDisc
    {
        [Key]
        public Guid SerialCode { get; set; }

        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        [Required]
        [StringLength(50)]
        public string Brand { get; set; }

        [Required]
        [StringLength(50)]
        public string Artist { get; set; }

        [StringLength(50)]
        public string Region { get; set; }

        public DateTime PublicationDate { get; set; }
    }
}
