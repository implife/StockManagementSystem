namespace StockManagement.ORM.DBModels
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OrderSalesDetail")]
    public partial class OrderSalesDetail
    {
        public int ID { get; set; }

        public Guid? OrderID { get; set; }

        public Guid? SalesID { get; set; }

        public Guid SerialCode { get; set; }

        public int UnitPrice { get; set; }

        public int Quantity { get; set; }

        public int Type { get; set; }
    }
}
