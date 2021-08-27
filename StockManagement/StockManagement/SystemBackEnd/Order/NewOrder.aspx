<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="NewOrder.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.NewOrder" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>

    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script>
        // 在後台執行時取得所有CD的資料
        const txtObj = '<%= this.stringObj %>';
        const cdObj = JSON.parse(txtObj);

        // 設定fuse的options
        const options = {
            includeScore: true,
            keys: [
                { name: "Name", weight: 0.4 },
                { name: "Artist", weight: 0.4 },
                { name: "Region", weight: 0.1 },
                { name: "Brand", weight: 0.1 }
            ]
        }
        const fuse = new Fuse(cdObj, options);

        // 利用pattern執行Fuzzy Search，並將結果寫入搜尋的Dropdown List中
        function fuzzySearch(pattern) {
            let result = fuse.search(pattern);

            $("#dropdownSearch").html("");

            var count = 0;
            for (re of result) {
                if (count++ >= 10)
                    break;
                $("#dropdownSearch").append('<li><a class="dropdown-item" href="javascript:void(0)" onclick="dropitemClick(this)" data-refIndex="' + re.refIndex + '">' + re.item.Name + '</a></li>');
            }
            return result;
        }

        // 搜尋的Dropdown List項目被點選時
        function dropitemClick(ele) {
            // 取得被點選的List的內容(專輯名稱)並寫入搜尋textbox(自動完成)，並執行一次FuzzySearch改寫下拉選單內容
            $(".txtSearchClass").val($(ele).html());
            fuzzySearch($(".txtSearchClass").val());

            // 將結果列表清空，填上標頭
            $("#search_List_Group").html('<a class="list-group-item disabled" href="#">\
                <div class="row" >\
                    <div class="col-6"> <small>專輯名稱</small> </div>\
                    <div class="col-3"> <small>歌手</small> </div>\
                    <div class="col-3"> <small>可用庫存</small> </div>\
                </div></a>');

            // 取得被點選的項目的id(搜尋cdObj時的refIndex)，將資料寫入結果列表(只會有一筆)
            var index = Number($(ele).attr("data-refIndex"));
            var cd = cdObj[index];
            $("#search_List_Group").append('<a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#ID' + cd.SerialCode + '">\
                <div class="row">\
                    <div class="col-6"> <h6>' + cd.Name + '</h6> </div>\
                    <div class="col-3"> <small>' + cd.Artist + '</small> </div >\
                    <div class="col-3"> <small>50</small> </div>\
                </div > </a> ');

            // 處理發行日期的格式
            var pDate = new Date(cd.PublicationDate);
            var month = pDate.getMonth() < 9 ? "0" + (pDate.getMonth() + 1) : pDate.getMonth() + 1;
            var date = pDate.getDate() < 10 ? "0" + pDate.getDate() : pDate.getDate();

            // 顯示細目的tab content
            $("#search_list_tab_content").html('<div class="tab-pane fade" id="ID' + cd.SerialCode + '">\
                <h6>專輯名稱: ' + cd.Name + '</h6>\
                <small>歌手: ' + cd.Artist + '</small><br />\
                <small>發行公司: ' + cd.Brand + '</small><br />\
                <small>發行日期: ' + `${pDate.getFullYear()}-${month}-${date}` + '</small><br />\
                <small>地區: ' + (cd.Region == null ? "--" : cd.Region) + '</small><br />\
                <small>可用庫存: 50</small><br />\
                <small>在途庫存: 10</small><br />\
                <small>待審核庫存: 2</small><br />\
             </div>');

            // 將pagination改成只有一頁
            $("ul.pagination").html('\
                <li class="page-item">\
	                <a id="ContentPlaceHolder1_searchListPager_HLPre" class="page-link" href="#" tabindex="-1"><span>&laquo;</span></a>\
                </li>\
                <li class="page-item active"><a class="page-link" href="#">1</a></li>\
                <li class="page-item">\
	                <a id="ContentPlaceHolder1_searchListPager_HLNext" class="page-link" href="#" tabindex="-1"><span>&raquo;</span></a>\
                </li>');
            
        }

        // 搜尋鈕被按下時，將搜尋結果改成JSON格式放入Hidden Field回傳至後台
        function btnSearchClick() {
            var result = fuzzySearch($(".txtSearchClass").val());
            var txt = JSON.stringify(result);
            $("#ContentPlaceHolder1_HFSearchResult").val(JSON.stringify(result));
        }

        $(function () {
            fuzzySearch($(".txtSearchClass").val());

            // 搜尋textbox註冊keyup事件
            $(".txtSearchClass").on({
                keyup: function () {
                    fuzzySearch($(".txtSearchClass").val());
                    
                }
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <a class="btn btn-info" href="NewOrder.aspx" role="button">顯示所有資料</a>
        <div class="dropdown">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="dropdown-toggle txtSearchClass"></asp:TextBox>
            <ul class="dropdown-menu" id="dropdownSearch">
                <%-- 搜尋欄的下拉選單 --%>
            </ul>
            <asp:Button ID="btnSearch" runat="server" Text="搜尋" CssClass="btn btn-outline-primary" />
            
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
        <uc1:ucPager runat="server" id="searchListPager" Url="NewOrder.aspx" />
    </div>

</asp:Content>
