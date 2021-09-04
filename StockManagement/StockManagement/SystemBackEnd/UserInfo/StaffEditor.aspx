<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="StaffEditor.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.StaffEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>
    <script src="../../Scripts/customize/popper.min.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
            $('.Choice li').click(function () {
                $(this).parent().siblings("button").text($(this).text());
            })

            $('input[ID$="btnUpdate"]').click(function () {
                var Level = $('#btnLevel').text()
                var Status = $('#btnStatus').text()
                var level;
                var status;

                if (Level == "主管") {
                    level = 0;
                } else if (Level == "全職") {
                    level = 1;
                } else {
                    level = 2;
                }

                if (Status == "在職") {
                    status = 0;
                } else if (Status == "全職") {
                    status = 1;
                } else {
                    status = 2;
                }
                var result = level+","+status;
                $('input[ID$="HDField"]').val(result)
            })
        })


    </script>
    <style>
        td {
            padding: unset;
            margin-bottom: 0.1rem;
        }

        p {
            margin-bottom: 0.1rem;
        }

        .btn {
            background-color: #ECA37A;
            border-color: #ECA37A;
        }

            .btn:hover {
                background-color: #E19468;
                border-color: #E19468;
            }

        .btn-danger:focus {
            background-color: #DD7B5C;
            border-color: #DD7B5C;
            box-shadow: 0 0 0 0.18rem rgb(225 83 97 / 50%);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
            </tr>
        </thead>
        <tbody>
            <asp:Literal ID="ltlStaffEditor" runat="server" EnableViewState="false"></asp:Literal>
        </tbody>
    </table>
    <asp:HiddenField ID="HDField" runat="server" />
    <asp:Button ID="btnUpdate" runat="server" Text="更改" OnClick="Button1_Click"/>
</asp:Content>
