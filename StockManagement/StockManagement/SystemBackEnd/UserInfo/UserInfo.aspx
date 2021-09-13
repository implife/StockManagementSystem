<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.UserInfo" %>


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
            <img src="https://scontent.ftpe2-2.fna.fbcdn.net/v/t1.18169-9/18670971_1309799915765127_8169405159489275055_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=174925&_nc_ohc=zqPdeJi_H8IAX894n50&_nc_ht=scontent.ftpe2-2.fna&oh=ba29cf0710fd05000236bcdc74a6f3b4&oe=615AC7A6" />
        </div>
        <h2>薛丁格庫存管理 <%=name%></h2>
        <p>狀態：<%=status %></p>
        <p>職稱：<%=title %></p>
        <p>電子信箱：<%=email %></p>
        <p>密碼：<%=pwd %></p>
        <span class="left bottom">tel:<%=tel%></span>
        <span class="right bottom">adress: <%=address %></span>


    </div>
</asp:Content>
