<%@ Page Title="薛丁格-員工資訊" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="StaffInfo.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.StuffInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #DDF5EC;
        }

        td {
            padding: unset;
            margin-bottom: 0.1rem;
        }

        p {
            margin-bottom: 0.1rem;
        }

        .badge {
            color: #b7881d;
        }

        .tHeadTr {
            text-align: left;
        }

        .btnNewStaff {
            color: #636363;
            background-color: #edbe87;
            border-color: #fde1c0;
        }

            .btnNewStaff:hover {

                background-color: #78C979;
                border-color: #78C979;
                color: #ffff;
            }

        .containerDiv2 {
            width: 90%;
            margin-left: auto;
            margin-right: auto;
        }

        tbody tr:nth-child(even) {
            background-color: #FFF2EB
        }

        tbody tr:nth-child(odd) {
            background-color: #F6FFFC
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containerDiv2">
        <table class="table table-hover">
            <thead>
                <tr class="tHeadTr">
                    <td>
                        <p>姓名</p>
                    </td>
                    <td>
                        <p>血型</p>
                    </td>
                    <td>
                        <p>電話</p>
                    </td>
                    <td>
                        <p>等級</p>
                    </td>
                    <td>
                        <p>職稱</p>
                    </td>
                    <td>
                        <p>狀態</p>
                    </td>
                    <td>
                        <p>電子信箱</p>
                    </td>
                    <td>
                        <p>到職日期</p>
                    </td>
                    <td></td>
                </tr>
            </thead>
            <tbody>
                <asp:Literal ID="ltlUserList" runat="server" EnableViewState="false"></asp:Literal>
            </tbody>
        </table>
        <asp:Button ID="btnNewStaff" CssClass="btn btn-outline-success btnNewStaff" runat="server" Text="新增員工" OnClick="btnNewStaff_Click" />
        <asp:Literal ID="ltlNewStaff" runat="server"></asp:Literal>
    </div>
</asp:Content>
