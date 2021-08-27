<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.UserInfo" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/bootstrap.js"></script>
<link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Literal ID="ltlUesrInfo" runat="server"></asp:Literal>
</asp:Content>
