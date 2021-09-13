<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="ApproveList.aspx.cs" Inherits="StockManagement.SystemBackEnd.Approve.ApproveList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>ApproveList</title>
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="../../StyleSheet/ApproveListStyle.css" rel="stylesheet" />
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script>/*Animated Arrow Stlye*/
        $(function () {
            $('.round').click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('.arrow').toggleClass('bounceAlpha');
            });

            $('input[class$=btn_Review]').click(function () {
                var StrID = $(this).parent().parent().attr('id').slice(11)
                var Submit = StrID + ",Review";
                $('input[id$=HD_Btn]').val(Submit);
            });

            $('input[class$=btn_Approve]').click(function () {
                var StrID = $(this).parent().parent().attr('id').slice(11)
                var Submit = StrID + ",Approve";
                $('input[id$=HD_Btn]').val(Submit);
            });

            $('input[class$=btn_Modify]').click(function () {
                var StrID = $(this).parent().parent().attr('id').slice(11)
                var Submit = StrID + ",Modify";
                $('input[id$=HD_Btn]').val(Submit);
            });
        })
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="HD_Btn" runat="server" />
    <div class="Switch">
        <div class="tabber">
            <label for="t1">單據審核</label>
            <input id="t1" name="food" type="radio" checked>
            <label for="t2">報廢核銷</label>
            <input id="t2" name="food" type="radio">
            <div class="blob"></div>
        </div>
    </div>
    <div style="width: 53rem;">
        <div class="accordion" id="accordionExample">
            <asp:Literal ID="ltlOrderList" runat="server" EnableViewState="false"></asp:Literal>
        </div>
    </div>
</asp:Content>
