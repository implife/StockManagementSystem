namespace StockManagement.ORM.DBModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OrderError")]
    public partial class OrderError
    {
        public int ID { get; set; }

        public Guid OrderID { get; set; }

        public int ErrorCode { get; set; }

        public Guid SerialCode { get; set; }

        public int Quantity { get; set; }

        public string Remark { get; set; }
    }
}
