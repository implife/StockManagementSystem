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
        public Guid OrderID { get; set; }

        public DateTime OrderDate { get; set; }

        [Required]
        [StringLength(50)]
        public string Seller { get; set; }

        public DateTime? PredictedArrivalDate { get; set; }

        public DateTime? ArrivalDate { get; set; }

        public int Status { get; set; }

        public Guid OrderResponsiblePerson { get; set; }

        public Guid? ArrivalResponsiblePerson { get; set; }

        public Guid? ReplenishID { get; set; }

        public string Reason { get; set; }
    }
}
