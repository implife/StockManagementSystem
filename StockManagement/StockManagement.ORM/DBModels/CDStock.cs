namespace StockManagement.ORM.DBModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CDStock")]
    public partial class CDStock
    {
        public int ID { get; set; }

        public Guid SerialCode { get; set; }

        public int TotalStock { get; set; }

        public int InTransitStock { get; set; }

        public int UnreviewedStock { get; set; }
    }
}
