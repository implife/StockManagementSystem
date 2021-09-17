<%@ Page Title="薛丁格-使用者資訊" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.UserInfo" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
    <link href="../../StyleSheet/UserInfoStyle.css" rel="stylesheet" />

	<script src="../../Scripts/bootstrap.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="gradient"></div>
    <div class="Block"></div>
    <div class="btnDiv">

        <asp:Button ID="Button1" CssClass ="btn btn-outline-primary btn-Create" runat="server" Text="編輯" OnClick="Button1_Click"/>
        
    </div>
    <div id="card">
        <div class="imgDiv">
            <img src="<%=userImg%>" />
        </div>
        <h2>薛丁格庫存管理 <%=name%></h2>
        <p>狀態：<%=status %></p>
        <p>職稱：<%=title %></p>
        <p>電子信箱：<%=email %></p>
        <span class="left bottom">tel:<%=tel%></span>
        <span class="right bottom">Account: <%=address %></span>


    </div>
</asp:Content>
