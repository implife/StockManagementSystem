<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="NewOrder.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.NewOrder" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>

    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script>
        const txtObj = '<%= this.stringObj %>';
        const cdObj = JSON.parse(txtObj);

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

        function dropitemClick(ele) {
            $(".txtSearchClass").val($(ele).html());
            var result = fuzzySearch($(".txtSearchClass").val());
            $("#search_List_Group").html('<a class="list-group-item disabled" href="#">\
                <div class="row" >\
                    <div class="col-6"> <small>專輯名稱</small> </div>\
                    <div class="col-3"> <small>歌手</small> </div>\
                    <div class="col-3"> <small>可用庫存</small> </div>\
                </div></a>');

            var index = Number($(ele).attr("data-refIndex"));
            var cd = cdObj[index];
            $("#search_List_Group").append('<a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#ID' + cd.SerialCode + '">\
                <div class="row">\
                    <div class="col-6"> <h6>' + cd.Name + '</h6> </div>\
                    <div class="col-3"> <small>' + cd.Artist + '</small> </div >\
                    <div class="col-3"> <small>50</small> </div>\
                </div > </a> ');

            var pDate = new Date(cd.PublicationDate);
            var month = pDate.getMonth() < 9 ? "0" + (pDate.getMonth() + 1) : pDate.getMonth() + 1;
            var date = pDate.getDate() < 10 ? "0" + pDate.getDate() : pDate.getDate();
            console.log(cd.Region == null)

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

            $("ul.pagination").css("display", "none");
            
        }

        function btnSearchClick() {

        }

        $(function () {
            fuzzySearch("");

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
        
        <div class="dropdown">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="dropdown-toggle txtSearchClass"></asp:TextBox>
            <%--<input type="text" id="txtSearch" class="dropdown-toggle" data-bs-toggle="dropdown"/>--%>
            <ul class="dropdown-menu" id="dropdownSearch">
                <%--<li><a class="dropdown-item" href="javascript:void(0)" onclick="dropitemClick(this)">Action</a></li>--%>
            </ul>
            <button type="button" class="btn btn-outline-primary" onclick="btnSearchClick()">搜尋</button>
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

                <asp:Literal ID="ltlCDList" runat="server" EnableViewState="false"></asp:Literal>

            </div>
        </div>


        <div class="col-5">
            <div class="tab-content" id="search_list_tab_content">

                <asp:Literal ID="ltlCDListTabContent" runat="server" EnableViewState="false"></asp:Literal>

            </div>
        </div>
    </div>
    <div id="UserPagination">
        <uc1:ucPager runat="server" id="searchListPager" Url="NewOrder.aspx" />
    </div>






</asp:Content>
