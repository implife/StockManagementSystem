<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="RecordSearch.aspx.cs" Inherits="StockManagement.SystemBackEnd.Search.RecordSearch" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>


    <style>
        body {
            background-color: #ddf5ec;
        }


        #OrderContainer {
            height: 85vh;
            margin-left: 2%;
        }

        #txtOrderIdSearch {
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
            z-index: 100;
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
            content: attr(label);
            display: inline-block;
            text-align: center;
            width: 100%;
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

        $(function () {
            $('#txtOrderIdSearch').keyup(function () {
                let result = fuse.search($(this).val());
                $('#dropdownSearch').html("");

                var count = 0;
                for (var data of result) {
                    $('#dropdownSearch').append('<li><a class="dropItem list-group-item list-group-item-action" href="javascript:void(0)"\
                                data-refindex="0" >' + data.item.OrderID.split('-')[0] + '</a ></li >');
                    count++;
                    if (count == 10)
                        break;
                }
            })
        })





        var tabpaneStatus = 0;
        $(function () {
            // Animated arrow
            $('.round').click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('.arrow').toggleClass('bounceAlpha');
            });

            $('.cdListItem').bind({
                mouseenter: function () {
                    $(this).children('.CdDetailPopup').addClass('myShow');
                    $('.accordion-button').css('z-index', 1);
                },
                mouseleave: function () {
                    $(this).children('.CdDetailPopup').removeClass('myShow');
                }
            });

            $('.deliverCheckListItem').bind({
                mouseenter: function () {
                    $(this).children('.RemarkPopup').addClass('myShow');
                },
                mouseleave: function () {
                    $(this).children('.RemarkPopup').removeClass('myShow');
                }
            });

            // 搜尋欄
            $('.dropdownSearchInput').bind({
                focusin: function () {
                    $('.dropdownSearch').addClass('dropdowmShow');
                }
            });

            $('html, body').on('click', function (e) {

                if (!$(e.target).is('.dropdownSearchInput') &&
                    !$(e.target).is('.dropdownSearch')) {
                    $('.dropdownSearch').removeClass('dropdowmShow');
                }

            });
        })
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-12 col-md-11" id="OrderContainer">

        <ul class="nav nav-tabs">
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
            <div class="tab-pane fade show active" id="OrderTab">
                <div class="row">
                    <div class="mb-3 col-11 mt-1">
                        <input type="text" class="form-control dropdownSearchInput" id="txtOrderIdSearch"
                            placeholder="輸入單號查詢">
                        <ul class="dropdownSearch" id="dropdownSearch">
                            <li><a class="dropItem list-group-item list-group-item-action" href="javascript:void(0)"
                                data-refindex="0">Hello</a></li>
                            <li><a class="dropItem list-group-item list-group-item-action" href="javascript:void(0)"
                                data-refindex="0">World</a></li>
                        </ul>

                        <button type="button" class="btn btn-outline-success">查詢</button>
                        <div class="radio">
                            <input label="顯示全部" type="radio" id="male" name="gender" value="male" checked>
                            <input label="一周內" type="radio" id="female" name="gender" value="female">
                            <input label="一個月內" type="radio" id="other" name="gender" value="other">
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="SalesTab">
                <h4>銷貨單查詢</h4>
            </div>
            <div class="tab-pane fade" id="ReimbueseTab">
                <h4>報銷單查詢</h4>
            </div>
        </div>

        <div class="row">
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

                    <%--<a class="list-group-item list-group-item-action myActive" data-bs-toggle="list" href="#ID303">
                        <div class="row">
                            <div class="col-3">303ee776</div>
                            <div class="col-2"> <small>2021-08-08</small> </div>
                            <div class="col-2"><small>2021-08-10</small></div>
                            <div class="col-2"><small>2500</small></div>
                            <div class="col-3"><small>Admin</small></div>
                        </div>
                    </a>
                    <a class="list-group-item list-group-item-action myActive" data-bs-toggle="list" href="#ID0D9A714B">
                        <div class="row">
                            <div class="col-3">0D9A714B</div>
                            <div class="col-2"> <small>2021-08-09</small> </div>
                            <div class="col-2"><small>2021-08-12</small></div>
                            <div class="col-2"><small>3500</small></div>
                            <div class="col-3"><small>Admin</small></div>
                        </div>
                    </a>
                    <a class="list-group-item list-group-item-action myActive" data-bs-toggle="list" href="#ID5767BAA9">
                        <div class="row">
                            <div class="col-3">5767BAA9</div>
                            <div class="col-2"> <small>2021-08-06</small> </div>
                            <div class="col-2"><small>2021-08-09</small></div>
                            <div class="col-2"><small>4500 </small></div>
                            <div class="col-3"><small>Admin</small></div>
                        </div>
                    </a>

                    <!--         關連訂單           -->
                    <a class="list-group-item list-group-item-action myActive" data-bs-toggle="list" href="#ID3e71e815">
                        <div class="row">
                            <div class="center-con">
                                <div class="round">
                                    <div id="cta">
                                        <span class="arrow primera next "></span>
                                        <span class="arrow segunda next "></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-3" style="color:#dd7b5c">3e71e815</div>
                            <div class="col-2"> <small>2021-08-01</small> </div>
                            <div class="col-2"><small>2021-08-04</small></div>
                            <div class="col-2"><small>7500 </small></div>
                            <div class="col-3"><small>Admin</small></div>
                        </div>
                    </a>
                    <a class="list-group-item list-group-item-action myActive" data-bs-toggle="list" href="#ID10e3d2ba">
                        <div class="row">
                            <div class="center-con">
                                <div class="round">
                                    <div id="cta">
                                        <span class="arrow primera next "></span>
                                        <span class="arrow segunda next "></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-3" style="color:#dd7b5c">10e3d2ba</div>
                            <div class="col-2"> <small>2021-08-05</small> </div>
                            <div class="col-2"><small>2021-08-08</small></div>
                            <div class="col-2"><small>2000 </small></div>
                            <div class="col-3"><small>Admin</small></div>
                        </div>
                    </a>
                    <a class="list-group-item list-group-item-action myActive" data-bs-toggle="list" href="#ID2ef12f10">
                        <div class="row">
                            <div class="col-3" style="color:#dd7b5c">2ef12f10</div>
                            <div class="col-2"> <small>2021-08-09</small> </div>
                            <div class="col-2"><small>2021-08-12</small></div>
                            <div class="col-2"><small>1000 </small></div>
                            <div class="col-3"><small>--</small></div>
                        </div>
                    </a>--%>
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
