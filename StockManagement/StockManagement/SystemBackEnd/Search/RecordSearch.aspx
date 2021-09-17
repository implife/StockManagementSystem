<%@ Page Title="薛丁格-單據查詢" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="RecordSearch.aspx.cs" Inherits="StockManagement.SystemBackEnd.Search.RecordSearch" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>


    <style>
        body {
            background-color: #ddf5ec;
        }

        #OrderListAndTabPane{
            overflow-x: hidden;
            overflow-y: auto;
            height: 80vh;
        }

        #OrderContainer {
            margin-left: 2%;
        }
        .NoData{
            color: #ff8282;
        }

        input[id$=txtOrderIdSearch] {
            width: 215px;
            display: inline-block;
            margin-right: 5px;
        }

        #OrderListGroup {
            height: 85vh;
        }

        #OrderListGroup>h5 {
            text-align: center;
        }

        #OrderListTabPane {
            height: 85vh;
            padding: 5px 4px 4px;
            overflow-x: hidden;
            overflow-y: auto;
        }

        .arrival-status-span {
            margin-left: 15px;
        }

        .arrival-cross-badge {
            margin: 0 5px;
        }

        .tabpane-tilte-badge {
            margin-right: 80px;
        }

        button.collapsed:disabled {
            color: #ced4da;
        }

        .active.myActive {
            background-color: powderblue;
        }

        .myCheck {
            display: inline-block;
            transform: rotate(45deg);
            height: 16px;
            width: 8px;
            border-bottom: 3px solid #78b13f;
            border-right: 3px solid #78b13f;
            margin: 0 8px;
        }

        .pagination{
            margin-left: 2%;
        }

        /* #region Search Dropdown */
        .dropdownSearch {
            list-style: none;
            position: absolute;
            width: 215px;
            padding: 0;
            z-index: 5;
            visibility: hidden;

        }

        .dropdownSearch.dropdowmShow {
            visibility: visible;
            -webkit-animation: DDfadeIn .4s;
            animation: DDfadeIn .4s;
        }

        .dropdownSearch .list-group-item {
            border: none;
            z-index: 999;
        }

        .dropdownSearch li:first-child .list-group-item {
            margin-top: 2px;
            border-top-right-radius: 3px;
            border-top-left-radius: 3px;
            border: 1px solid rgba(0, 0, 0, .125);
            border-bottom: none;
        }

        .dropdownSearch li:last-child .list-group-item {
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
            border: 1px solid rgba(0, 0, 0, .125);
            border-top: none;
        }

        @-webkit-keyframes DDfadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes DDfadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }
        /* #endregion Search Dropdown */

        /* #region CdDetail & Remark Popup */

        .CdDetailPopup {
            visibility: hidden;
            width: 76%;
            background-color: rgba(255, 240, 245, 0.9);
            color: #9932CC;
            text-align: left;
            border-radius: 6px;
            padding: 12px 10px;
            position: absolute;
            z-index: 1000;
            left: 12%;
            bottom: calc(100% + 10px);
        }

        .CdDetailPopup::after {
            content: "";
            position: absolute;
            top: 100%;
            left: 45%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: rgba(255, 240, 245, 0.9) transparent transparent transparent;
        }

        .CdDetailPopup.myShow {
            visibility: visible;
            -webkit-animation: fadeIn .8s;
            animation: fadeIn .8s;
        }

        .RemarkPopup {
            visibility: hidden;
            width: 76%;
            background-color: rgba(255, 240, 245, 0.9);
            color: #9932CC;
            text-align: left;
            border-radius: 6px;
            padding: 12px 10px;
            position: absolute;
            z-index: 1000;
            left: 12%;
            bottom: calc(100% + 10px);
        }

        .RemarkPopup>p {
            margin-bottom: 0;
            font-size: 14px;
        }

        .RemarkPopup::after {
            content: "";
            position: absolute;
            top: 100%;
            left: 45%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: rgba(255, 240, 245, 0.9) transparent transparent transparent;
        }

        .RemarkPopup.myShow {
            visibility: visible;
            -webkit-animation: fadeIn .8s;
            animation: fadeIn .8s;
        }

        /* Add animation (fade in the popup) */
        @-webkit-keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        /* #endregion CdDetail & Remark Popup */

        /* #region Animated Arrow */
        .center-con {
            position: absolute;
            height: 45px;
            width: 45px;
            align-items: center;
            justify-content: center;
            top: 19px;
            left: 30px;
            z-index: 3;
            padding: 0;
        }

        .round {
            position: absolute;
            /*border: 2px solid rgb(252, 161, 161);*/
            transform: rotateZ(90deg);
            width: 40px;
            height: 40px;
            border-radius: 100%;
        }

        #cta {
            width: 100%;
            cursor: pointer;
            position: absolute;
        }

        #cta .arrow {
            left: 30%;
        }

        .arrow {
            position: absolute;
            bottom: 0;
            margin-left: 0px;
            width: 12px;
            height: 12px;
            background-size: contain;
            top: 15px;
        }

        .segunda {
            margin-left: 8px;
        }

        .next {
            background-image: url(data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHN0eWxlPi5zdDB7ZmlsbDojZmNhMWExfTwvc3R5bGU+PHBhdGggY2xhc3M9InN0MCIgZD0iTTMxOS4xIDIxN2MyMC4yIDIwLjIgMTkuOSA1My4yLS42IDczLjdzLTUzLjUgMjAuOC03My43LjZsLTE5MC0xOTBjLTIwLjEtMjAuMi0xOS44LTUzLjIuNy03My43UzEwOSA2LjggMTI5LjEgMjdsMTkwIDE5MHoiLz48cGF0aCBjbGFzcz0ic3QwIiBkPSJNMzE5LjEgMjkwLjVjMjAuMi0yMC4yIDE5LjktNTMuMi0uNi03My43cy01My41LTIwLjgtNzMuNy0uNmwtMTkwIDE5MGMtMjAuMiAyMC4yLTE5LjkgNTMuMi42IDczLjdzNTMuNSAyMC44IDczLjcuNmwxOTAtMTkweiIvPjwvc3ZnPg==);
        }

        @keyframes bounceAlpha {
            0% {
                opacity: 1;
                transform: translateX(0px) scale(1);
            }

            25% {
                opacity: 0;
                transform: translateX(10px) scale(0.9);
            }

            26% {
                opacity: 0;
                transform: translateX(-10px) scale(0.9);
            }

            55% {
                opacity: 1;
                transform: translateX(0px) scale(1);
            }
        }

        .bounceAlpha {
            animation-name: bounceAlpha;
            animation-duration: 1.4s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        .arrow.primera.bounceAlpha {
            animation-name: bounceAlpha;
            animation-duration: 1.4s;
            animation-delay: 0.2s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        .round:hover .arrow {
            animation-name: bounceAlpha;
            animation-duration: 1.4s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        .round:hover .arrow.primera {
            animation-name: bounceAlpha;
            animation-duration: 1.4s;
            animation-delay: 0.2s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        /* #endregion Animated Arrow */

        /* #region Nav RadioBtn */

        .radio {
            background: #ddf5ec;
            padding: 6px;
            border-radius: 3px;
            /* box-shadow: inset 0 0 0 1px #87cefa; */
            position: relative;
            width: 225px;
            display: inline-block;
            margin-left: 10px;
        }

        .radio input {
            width: auto;
            height: 100%;
            appearance: none;
            outline: none;
            cursor: pointer;
            border-radius: 2px;
            padding: 4px 8px;
            background: #e9fce9;
            color: #bdbdbdbd;
            font-size: 14px;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
                "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji",
                "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
            transition: all 100ms linear;
            box-shadow: 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
        }

        .radio input:hover {
            background-color: #bcf8bc;
            color: #a5a5a5;
            box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.2), 0 4px 5px 0 rgba(0, 0, 0, 0.14), 0 1px 10px 0 rgba(0, 0, 0, 0.12);
        }

        .radio input:active {
            background-color: #a9eea9;
            color: #969696;
            box-shadow: 0 5px 5px -3px rgba(0, 0, 0, 0.2), 0 8px 10px 1px rgba(0, 0, 0, 0.14), 0 3px 14px 2px rgba(0, 0, 0, 0.12);
        }

        .radio input:checked {
            background-image: linear-gradient(180deg, #deffc5, #a0dab7);
            color: #c233ff;
            box-shadow: 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
            text-shadow: 0 1px 0px #79485f7a;

        }

        .radio input:checked:hover {
            background-image: linear-gradient(180deg, #ceffa8, #6cdb98);
            color: #b300ff;
            box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.2), 0 4px 5px 0 rgba(0, 0, 0, 0.14), 0 1px 10px 0 rgba(0, 0, 0, 0.12);
        }

        .radio input:checked:active {
            background-image: linear-gradient(180deg, #c0ee9d, #61c78a);
            color: #9400d3;
            box-shadow: 0 5px 5px -3px rgba(0, 0, 0, 0.2), 0 8px 10px 1px rgba(0, 0, 0, 0.14), 0 3px 14px 2px rgba(0, 0, 0, 0.12);
        }

        .radio input:before {
            content: attr(MyLabel);
            display: inline-block;
            text-align: center;
            width: 100%;
        }

        .Accordion_button{
            background-color:#FBD9C5;
        }

        .accordion-body{
                background-color: #ddf5ec;
        }
        /* #endregion Nav RadioBtn */

    </style>

    <script>
        const orderJSON = '<%= this.OrderJSON %>';
        const orderAry = JSON.parse(orderJSON);

        const options = {
            includeScore: true,
            keys: [
                { name: "OrderID", weight: 1 }
            ]
        }
        const fuse = new Fuse(orderAry, options);

        // 傳入搜尋字串進行Fuzzy Search
        function fuseSearch(pattern) {
            let result = fuse.search(pattern);
            $('#dropdownSearch').html("");

            var count = 0;
            for (var data of result) {
                $('#dropdownSearch').append('<li><a class="dropItem list-group-item list-group-item-action" href="javascript:void(0)"\
                                data-refindex="0" >' + data.item.OrderID.split('-')[0] + '</a ></li >');
                count++;
                if (count == 10)
                    break;
            }

            return result;
        }

        


        var tabpaneStatus = 0;
        $(function () {
            // Animated arrow
            $('.round').click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('.arrow').toggleClass('bounceAlpha');
            });

            // 訂單裡的商品列表的Popup
            $('.cdListItem').bind({
                mouseenter: function () {
                    $(this).children('.CdDetailPopup').addClass('myShow');
                    $('.accordion-button').css('z-index', 1);
                },
                mouseleave: function () {
                    $(this).children('.CdDetailPopup').removeClass('myShow');
                }
            });

            // 到貨狀況的Popup
            $('.deliverCheckListItem').bind({
                mouseenter: function () {
                    $(this).children('.RemarkPopup').addClass('myShow');
                },
                mouseleave: function () {
                    $(this).children('.RemarkPopup').removeClass('myShow');
                }
            });

            // 搜尋欄的下拉選單
            $('.dropdownSearchInput').bind({
                focusin: function () {
                    $('.dropdownSearch').addClass('dropdowmShow');
                }
            });

            // 搜尋欄的消失條件
            $('html, body').on('click', function (e) {

                if (!$(e.target).is('.dropdownSearchInput') &&
                    !$(e.target).is('.dropdownSearch')) {
                    $('.dropdownSearch').removeClass('dropdowmShow');
                }
            });

            // 搜尋欄事件
            $('input[id$=txtOrderIdSearch]').keyup(function () {
                fuseSearch($(this).val())
            })

            // 搜尋紐事件
            $('input[id$=btnSearch]').click(function () {
                let result = fuseSearch($('input[id$=txtOrderIdSearch]').val());

                $('input[id$=HFSearchResult]').val(JSON.stringify(result));
            })

            // 搜尋下拉選單li Click事件
            $('#dropdownSearch').on('click', 'li',function () {
                $('input[id$=txtOrderIdSearch]').val($(this).children('a').text());
                fuseSearch($('input[id$=txtOrderIdSearch]').val());
            })

            // 顯示範圍的Radio Button
            $('input[type=radio][name$=DisplayRange]').change(function () {
                $('input[type=hidden][id$=HFRangeRdioBtn]').val($(this).val());
                $('form').submit();
            });
        })
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-12 col-md-11" id="OrderContainer">

        <%--<ul class="nav nav-tabs">
            <li class="nav-item">
                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#OrderTab"
                    type="button">
                    訂單查詢</button>
            </li>
            <li class="nav-item">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#SalesTab" type="button">銷貨單查詢</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#ReimbueseTab"
                    type="button">
                    報銷單查詢</button>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="OrderTab">--%>
        <div class="row">
            <div class="mb-3 col-11 mt-1">

                <asp:TextBox ID="txtOrderIdSearch" runat="server" CssClass="form-control dropdownSearchInput"></asp:TextBox>
                        
                <ul class="dropdownSearch" id="dropdownSearch">

                </ul>

                <%-- 將搜尋結果傳回伺服器的Hidden Field --%>
                <asp:HiddenField ID="HFSearchResult" runat="server" />

                <asp:Button ID="btnSearch" runat="server" Text="查詢" CssClass="btn btn-outline-success" />
                <div class="radio">
                    <asp:RadioButton ID="All" runat="server" GroupName="DisplayRange"/>
                    <asp:RadioButton ID="Week" runat="server" GroupName="DisplayRange" />
                    <asp:RadioButton ID="Month" runat="server" GroupName="DisplayRange"  />

                    <%-- Radio button按下時將Radio資訊放進HF --%>
                    <asp:HiddenField ID="HFRangeRdioBtn" runat="server" />
                </div>
            </div>
               <%-- </div>
            </div>
            <div class="tab-pane fade" id="SalesTab">
                <h4>銷貨單查詢</h4>
            </div>
            <div class="tab-pane fade" id="ReimbueseTab">
                <h4>報銷單查詢</h4>
            </div>--%>
        </div>

        <div class="row" id="OrderListAndTabPane">
            <div class="col-7">
                <div class="list-group" id="OrderListGroup">
                    <a class="list-group-item disabled" href="#">
                        <div class="row">
                            <div class="col-3">
                                <small>訂單編號</small>
                            </div>
                            <div class="col-2">
                                <small>訂貨日期</small>
                            </div>
                            <div class="col-2">
                                <small>到貨日期</small>
                            </div>
                            <div class="col-2">
                                <small>總金額</small>
                            </div>
                            <div class="col-3">
                                <small>負責主管</small>
                            </div>
                        </div>
                    </a>

                    <%-- 左邊的Result List --%>
                    <asp:Literal ID="ltlResultList" runat="server" EnableViewState="false"></asp:Literal>

                   
                </div>
            </div>
            <div class="col-5">
                <div class="tab-content" id="OrderListTabPane">

                    <%-- 細目的Tab Pane --%>
                    <asp:Literal ID="ltlSearchTabPane" runat="server" EnableViewState="false"></asp:Literal>

                </div>
            </div>
        </div>
    </div>
    <div>
        <uc1:ucpager runat="server" id="ucPager" Url="RecordSearch.aspx" />
    </div>
</asp:Content>
