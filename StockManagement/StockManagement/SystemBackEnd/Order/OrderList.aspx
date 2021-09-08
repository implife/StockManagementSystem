<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <%-- 自定義的css和js --%>
    <link href="../../StyleSheet/OrderList.css" rel="stylesheet" />

    <script src="../../Scripts/customize/OrderList.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-12 col-md-11" id="OrderContainer">
        <div class="row">
            <div class="col-7">
                <div class="list-group" id="OrderListGroup">
                    <h5>追蹤中訂單</h5>
                    <a class="list-group-item disabled" href="#">
                        <div class="row">
                            <div class="col-3">
                                <small>訂單編號</small>
                            </div>
                            <div class="col-3">
                                <small>訂貨日期</small>
                            </div>
                            <div class="col-2">
                                <small>總金額</small>
                            </div>
                            <div class="col-2">
                                <small>狀態</small>
                            </div>
                            <div class="col-2">
                                <small>負責主管</small>
                            </div>
                        </div>
                    </a>

                    <%-- 訂單列表 --%>
                    <asp:Literal ID="ltlOrderListItem" runat="server" EnableViewState="False"></asp:Literal>
                    
                </div>
            </div>
            <div class="col-5">
                <div class="tab-content" id="OrderListTabPane">

                    <%-- 訂單列表的細目 --%>
                    <asp:Literal ID="ltlOrderListTabPane" runat="server" EnableViewState="false"></asp:Literal>
                    
                </div>
            </div>
        </div>
    </div>
    <div class="mt-1">
        <asp:Button ID="btnNewOrder" runat="server" Text="新增訂單" CssClass="btn btn-outline-primary" OnClick="btnNewOrder_Click" />
        <asp:Button ID="btnPastOrder" runat="server" Text="歷史訂單" CssClass="btn btn-outline-secondary" />
    </div>

</asp:Content>
