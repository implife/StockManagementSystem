<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="NewOrder.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.NewOrder" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        div h6
        {
            font-weight:900;
        }
		</style>

    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>

    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    
    <%-- 自定義的css和js --%>
    <link href="../../StyleSheet/NewOrder.css" rel="stylesheet" />
    
    <script>
        // 在後台執行時取得所有CD的資料
        const txtObj = '<%= this.stringObj %>';
        const cdObj = JSON.parse(txtObj);
        var hStatus = 0;
        var originalSearchVal = "";
        var submitStatus = true;

    </script>
    <script src="../../Scripts/customize/NewOrder.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="dropdown">
            <a class="btn btn-info" href="NewOrder.aspx" role="button">顯示所有資料</a>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="dropdown-toggle txtSearchClass"></asp:TextBox>
            <ul class="dropdown-menu" id="dropdownSearch">
                <%-- 搜尋欄的下拉選單 --%>
            </ul>
            <asp:Button ID="btnSearch" runat="server" Text="搜尋" CssClass="btn btn-outline-primary" OnClientClick="btnSearchClick()" />

            <%-- FuzzySearch的結果的HiddenField --%>
            <asp:HiddenField ID="HFSearchResult" runat="server" />

        </div>
    </div>
    <div class="row">
        <div class="col-7">
            <div class="list-group" id="search_List_Group">
                <a class="list-group-item disabled" href="#">
                    <div class="row">
                        <div class="col-6">
                            <small>專輯名稱</small>
                        </div>
                        <div class="col-3">
                            <small>歌手</small>
                        </div>
                        <div class="col-3">
                            <small>可用庫存</small>
                        </div>
                    </div>
                </a>

                <%-- 結果列表 --%>
                <asp:Literal ID="ltlCDList" runat="server" EnableViewState="false"></asp:Literal>

            </div>
        </div>

        <div class="col-5">
            <div class="tab-content" id="search_list_tab_content">

                <%-- 結果列表細目的tab content --%>
                <asp:Literal ID="ltlCDListTabContent" runat="server" EnableViewState="false"></asp:Literal>

            </div>
        </div>
    </div>
    <div id="UserPagination">
        <uc1:ucPager runat="server" ID="searchListPager" Url="NewOrder.aspx" ItemSizeInPage="8" />
    </div>


    <div class="row">
        <div class="col-9 popup-container">
            <ul class="list-group col-7" id="TempListContainer">
                <%-- 暫存列表(由Javascript產生) --%>

                <%-- 暫存列表的HiddenField --%>
                <asp:HiddenField ID="HFTempList" runat="server" />
            </ul>
        </div>
        <div class="col-3">
            <div class="col-sm-12 col-md-6 form-item form-floating">
                <asp:TextBox ID="Seller" runat="server" CssClass="form-control txtSellerClass"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="賣家" AssociatedControlID="Seller"></asp:Label>
                <div class="invalid-feedback">
                    請輸入賣家
                </div>
                <div class="valid-feedback">
                    Good!
                </div>
            </div>
            <a href="NewProduct.aspx" class="btn btn-outline-primary" tabindex="-1" role="button">新建商品</a><br />
            <asp:Button ID="btnSave" runat="server" Text="建立訂單" OnClick="btnSave_Click" CssClass="btn btn-outline-success" /><br />

            <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#CancelModal">
                取消
            </button>
            
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="CancelModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger" role="alert">
                        確定取消建立嗎?<br />
                        資料將不會儲存!
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                    <asp:Button ID="btnCancel" runat="server" Text="確定" OnClick="btnCancel_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>

    <!-- 新建訂單失敗Modal -->
    <div class="modal fade" id="CreateOrderFailedModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="alert alert-danger" role="alert">
                        新增失敗!
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="CRFailedModal.hide()">關閉</button>
                </div>
            </div>
        </div>
    </div>

    <%--<script>
        $(function () {
            var CRFailedModal = new bootstrap.Modal(document.getElementById('CreateOrderFailedModal'), { keyboard: false });
            
            
        });
    </script>--%>

    <%-- 如果新建訂單失敗會呼叫失敗的Modal --%>
    <asp:Literal ID="ltlFailedModal" runat="server"></asp:Literal>
</asp:Content>
