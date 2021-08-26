<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.OrderList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Button ID="btnNewOrder" runat="server" Text="建立新訂單" OnClick="btnNewOrder_Click" />
</asp:Content>
