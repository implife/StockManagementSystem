using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace StockManagement.ORM.DBModels
{
    public partial class ContextModel : DbContext
    {
        public ContextModel()
            : base("name=DefaultConnectionString")
        {
        }

        public virtual DbSet<CompactDisc> CompactDiscs { get; set; }
        public virtual DbSet<OrderError> OrderErrors { get; set; }
        public virtual DbSet<OrderSalesDetail> OrderSalesDetails { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<UserInfo> UserInfoes { get; set; }
        public virtual DbSet<Order> Orders { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CompactDisc>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<CompactDisc>()
                .Property(e => e.Brand)
                .IsUnicode(false);

            modelBuilder.Entity<CompactDisc>()
                .Property(e => e.Artist)
                .IsUnicode(false);

            modelBuilder.Entity<CompactDisc>()
                .Property(e => e.Region)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.Account)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.PWD)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.Tel)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.BloodType)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.Seller)
                .IsUnicode(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.Reason)
                .IsUnicode(false);
        }
    }
}
