namespace StockManagement.ORM.DBModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Order")]
    public partial class Order
    {
        [Key]
        [Column(Order = 0)]
        public Guid OrderID { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime OrderDate { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string Seller { get; set; }

        public DateTime? PredictedArrivalDate { get; set; }

        public DateTime? ArrivalDate { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Status { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid OrderResponsiblePerson { get; set; }

        public Guid? ArrivalResponsiblePerson { get; set; }

        public Guid? ReplenishID { get; set; }

        public string Reason { get; set; }
    }
}
