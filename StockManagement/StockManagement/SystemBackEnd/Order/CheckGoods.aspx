<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="CheckGoods.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.CheckGoods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
        integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js"
        integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

    <style>
        .active.myActive {
            background-color: #e9ecef;
            color: #000;
            cursor: pointer;
            border-color: #e9ecef;
        }

        .ChekGoodsList {
            height: 390px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .ChekGoodsListGroup .row {
            --bs-gutter-x: 0;
            --bs-gutter-y: 0;
            display: flex;
            flex-wrap: wrap;
            margin-top: calc(var(--bs-gutter-y) * -1);
            margin-right: calc(var(--bs-gutter-x) * -.5);
            margin-left: calc(var(--bs-gutter-x) * -.5);
        }

        .ChekGoodsListGroup h4 {
            text-align: center;
        }

        .form-check-label {
            font-size: 18px;
            font-weight: bold;
        }

        input.form-check-input {
            font-size: 18px;
            cursor: pointer;
        }

            input.form-check-input:checked {
                background-color: #a4e3c5;
            }

        .form-check-input:focus {
            border-color: #a4e3c5;
            box-shadow: 0 0 0 0.25rem #e1faf0;
        }

        input.form-check-input:checked + label {
            color: #ec5f5f;
        }

        .GoodsOkCheckContainer > .GoodsOkCheckbox {
            margin-top: 1.4%;
            padding-left: .8rem;
        }

        .list-group-item-success.list-group-item-action.active {
            color: #fff;
            background-color: #62ab89;
            border-color: #62ab89;
        }

        .list-group-item-danger.list-group-item-action.active {
            color: #fff;
            background-color: #ea969d;
            border-color: #ea969d;
        }

        .mytab-pane {
            visibility: hidden;
            display: none;
        }

        .mytab-content p {
            margin-bottom: .4rem;
        }

        .myTabPaneShow {
            visibility: visible;
            display: block;
            -webkit-animation: fadeIn .6s;
            animation: fadeIn .6s;
        }

        .form-switch {
            padding-left: 3em;
        }

        .ErrorRadioContainer {
            margin-top: 20px;
            margin-left: 8px;
        }

        .ErrorSwitchField {
            overflow: hidden;
            visibility: hidden;
            padding: 5px;
        }

            .ErrorSwitchField.myErrShow {
                visibility: visible;
                -webkit-animation: fadeIn .6s;
                animation: fadeIn .6s;
            }

        .ErrorTempList .list-group {
            height: 310px;
            overflow-y: auto;
            overflow-x: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
            transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
        }

            .ErrorTempList .list-group:hover {
                box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
            }

        .createCancelBtn > input,
        .createCancelBtn > a {
            margin: 5px 3px;
        }

        .saveAlert {
            overflow: hidden;
            visibility: hidden;
            width: 50%;
            height: 40px;
            margin-left: 5px;
            margin-bottom: .5rem;
            margin-top: 40%;
        }

            .saveAlert.alertShow {
                visibility: visible;
                -webkit-animation: fadeIn .5s;
                animation: fadeIn .5s;
            }

        #confirmModalItemCheck span {
            font-size: 18px;
            color: #00ab2e;
            font-style: italic;
        }

        #confirmModalOrderCheck span {
            font-size: 18px;
            color: #f08080;
            font-style: italic;
        }


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

        /* #region ItemList Checkbox*/

        @import url('https://fonts.googleapis.com/css?family=Nunito');

        :root {
            --checkbox-size: 20px;
            --checkbox-color: #84DCC6;
            --hover-color: #f7bbbb;
            --tick-color: #198754;
        }


        label.GoodsOkCheckLabel {
            display: inline-block;
            margin: 0 calc(var(--checkbox-size) * 0.25);
            width: var(--checkbox-size);
            height: var(--checkbox-size);
            border: calc(var(--checkbox-size) * 0.125) solid var(--checkbox-color);
            border-radius: 12.5%;
            -webkit-transition: 400ms 100ms ease-out;
            -o-transition: 400ms 100ms ease-out;
            transition: 400ms 100ms ease-out;
        }

            label.GoodsOkCheckLabel:hover {
                border-color: var(--hover-color);
            }

        .GoodsOkCheckInput:disabled + .GoodsOkCheckLabel {
            border-color: #ced4da;
        }

        input.GoodsOkCheckInput[type="checkbox"] {
            position: absolute;
            left: -1000px;
        }

        .GoodsOkCheckLabel > .tick {
            position: relative;
            right: calc(var(--checkbox-size) * -0.5);
            top: calc(var(--checkbox-size) * -0.25);
            width: calc(var(--checkbox-size) * 0.4);
            height: calc(var(--checkbox-size) * 0.75);
            border-right: calc(var(--checkbox-size) * 0.15) solid var(--tick-color);
            border-bottom: calc(var(--checkbox-size) * 0.15) solid var(--tick-color);
            -webkit-transform: rotate(45deg) scale(0);
            -ms-transform: rotate(45deg) scale(0);
            transform: rotate(45deg) scale(0);
            opacity: 0;
            -webkit-transition: all 600ms cubic-bezier(0.175, 0.885, 0.32, 1.5);
            -o-transition: all 600ms cubic-bezier(0.175, 0.885, 0.32, 1.5);
            transition: all 600ms cubic-bezier(0.175, 0.885, 0.32, 1.5);
        }

        
        input.GoodsOkCheckInput[type="checkbox"]:checked + label .tick {
            opacity: 1;
            -webkit-transform: rotate(45deg) scale(1);
            -ms-transform: rotate(45deg) scale(1);
            transform: rotate(45deg) scale(1);
        }

        input.GoodsOkCheckInput[type="checkbox"]:focus + label {
            -webkit-animation-name: cb-pop;
            animation-name: cb-pop;
            -webkit-animation-duration: 400ms;
            animation-duration: 400ms;
            -webkit-animation-iteration-count: 1;
            animation-iteration-count: 1;
            -webkit-animation-timing-function: linear;
            animation-timing-function: linear;
        }

        @-webkit-keyframes cb-pop {
            0% {
                -webkit-transform: scale(1);
                transform: scale(1);
            }

            33% {
                -webkit-transform: scale(0.9);
                transform: scale(0.9);
            }

            66% {
                -webkit-transform: scale(1.1);
                transform: scale(1.1);
            }

            100% {
                tranform: scale(1);
            }
        }

        @keyframes cb-pop {
            0% {
                -webkit-transform: scale(1);
                transform: scale(1);
            }

            33% {
                -webkit-transform: scale(0.9);
                transform: scale(0.9);
            }

            66% {
                -webkit-transform: scale(1.1);
                transform: scale(1.1);
            }

            100% {
                tranform: scale(1);
            }
        }

        /* #endregion ItemList Checkbox*/


        /* #region Radio Button*/

        .ErrorRadioContainer {
            --background: #ffe7d9;
            --text: #414856;
            --radio: #7c96b2;
            --radio-checked: #4f29f0;
            --radio-size: 20px;
            --width: 130px;
            --height: 100px;
            --border-radius: 10px;
            background: var(--background);
            width: var(--width);
            /* height: var(--height); */
            border-radius: var(--border-radius);
            color: var(--text);
            position: relative;
            box-shadow: 0 10px 30px rgba(65, 72, 86, 0.05);
            padding: 10px 20px;
            display: grid;
            grid-template-columns: auto var(--radio-size);
            align-items: center;
        }


            .ErrorRadioContainer label {
                cursor: pointer;
            }

            .ErrorRadioContainer input[type=radio] {
                -webkit-appearance: none;
                -moz-appearance: none;
                position: relative;
                height: var(--radio-size);
                width: var(--radio-size);
                outline: none;
                margin: 0;
                cursor: pointer;
                border: 2px solid var(--radio);
                background: transparent;
                border-radius: 50%;
                display: grid;
                justify-self: end;
                justify-items: center;
                align-items: center;
                overflow: hidden;
                transition: border 0.5s ease;
            }

                .ErrorRadioContainer input[type=radio]::before,
                .ErrorRadioContainer input[type=radio]::after {
                    content: "";
                    display: flex;
                    justify-self: center;
                    border-radius: 50%;
                }

                .ErrorRadioContainer input[type=radio]::before {
                    position: absolute;
                    width: 100%;
                    height: 100%;
                    background: var(--background);
                    z-index: 1;
                    opacity: var(--opacity, 1);
                }

                .ErrorRadioContainer input[type=radio]::after {
                    position: relative;
                    width: calc(100% / 2);
                    height: calc(100% / 2);
                    background: var(--radio-checked);
                    top: var(--y, 100%);
                    transition: top 0.5s cubic-bezier(0.48, 1.97, 0.5, 0.63);
                }

                .ErrorRadioContainer input[type=radio]:checked {
                    --radio: var(--radio-checked);
                }

                    .ErrorRadioContainer input[type=radio]:checked::after {
                        --y: 0%;
                        -webkit-animation: stretch-animate 0.3s ease-out 0.17s;
                        animation: stretch-animate 0.3s ease-out 0.17s;
                    }

                    .ErrorRadioContainer input[type=radio]:checked::before {
                        --opacity: 0;
                    }

                    .ErrorRadioContainer input[type=radio]:checked ~ input[type=radio]::after {
                        --y: -100%;
                    }

                .ErrorRadioContainer input[type=radio]:not(:checked)::before {
                    --opacity: 1;
                    transition: opacity 0s linear 0.5s;
                }

        @-webkit-keyframes stretch-animate {
            0% {
                transform: scale(1, 1);
            }

            28% {
                transform: scale(1.15, 0.85);
            }

            50% {
                transform: scale(0.9, 1.1);
            }

            100% {
                transform: scale(1, 1);
            }
        }

        @keyframes stretch-animate {
            0% {
                transform: scale(1, 1);
            }

            28% {
                transform: scale(1.15, 0.85);
            }

            50% {
                transform: scale(0.9, 1.1);
            }

            100% {
                transform: scale(1, 1);
            }
        }

        /* #endregion Radio Button*/

    </style>


    <script>
        const ErrorTempList = new Array();
        const CorrectList = new Array();


        // 更新暫存列表
        function RefreshTempList() {
            $('.ErrorTempList > .list-group').html('');
            $('.ErrorTempList > .list-group').html('<a class="list-group-item disabled" href="#">\
                <div class="row">\
                    <div class="col-5"><small>專輯名稱</small></div>\
                    <div class="col-2"><small>異常</small></div>\
                    <div class="col-2"><small>數量</small></div>\
                    <div class="col-3"><small>備註</small></div>\
                </div></a>');
            for (var item of ErrorTempList) {
                let err;
                if (item.ErrorCode == 1)
                    err = "少送"
                else if (item.ErrorCode == 2)
                    err = "損毀"
                else
                    err = "";
                $('.ErrorTempList > .list-group').append('<a href="#" class="list-group-item list-group-item-action">\
                    <div class="row">\
                        <div class="col-5">' + item.Name + '</div>\
                        <div class="col-2"><small>' + err + '</small></div>\
                        <div class="col-2"><small>' + item.Quantity + '</small></div>\
                        <div class="col-3"><small>' + item.Remark + '</small></div>\
                    </div></a>');
            }


        }


        $(function () {
            const confirmModal = new bootstrap.Modal(document.getElementById('ConfirmModal'), {
                keyboard: false
            });



            // 異常Switch事件
            $('.mytab-pane input[type=checkbox]').change(function () {
                if (this.checked) {
                    $(this).parent().siblings('.ErrorSwitchField').addClass('myErrShow')
                        .find('input[id^=ErrRadioMinus]').prop('checked', true)
                        .parent().parent().find('input[id^=ErrQuantity]').val(1)
                        .siblings('input[id^=ErrRemark]').val('');

                    $('#ItemCB' + $(this).attr('id').slice(7)).prop('checked', false)
                        .trigger('change').prop('disabled', true);

                    $('.ChekGoodsListGroup').find('a[href$=' + $(this).attr('id').slice(7) + ']').addClass('list-group-item-danger');

                } else {
                    $(this).parent().siblings('.ErrorSwitchField').removeClass('myErrShow');
                    let itemID = $(this).attr('id').slice(7);

                    $('#ItemCB' + itemID).prop('disabled', false);
                    $('.ChekGoodsListGroup').find('a[href$=' + itemID + ']').removeClass('list-group-item-danger');

                    let quanDiv = $('.ChekGoodsListGroup').find('a[href$=ID' + itemID + ']')
                        .children('.row').children('div')[3];
                    $(quanDiv).text('--');

                    // 將項目從暫存列表刪除(包括從ErrTempList)

                    for (let i = 0; i < ErrorTempList.length; i++) {
                        if (ErrorTempList[i].ItemID == itemID) {
                            ErrorTempList.splice(i, 1);
                            break;
                        }
                    }
                    RefreshTempList();
                }
            });

            // 左邊ListItem事件
            $('.GoodsOkCheckContainer a').click(function () {
                if ($(this).hasClass('active')) {
                    $(this).removeClass('active');
                    $('.mytab-pane[id=' + $(this).attr('href').slice(1) + ']').removeClass('myTabPaneShow')
                } else {
                    $(this).addClass('active').parent().parent().siblings('div.GoodsOkCheckContainer').find('a').removeClass('active');
                    $('.mytab-pane[id=' + $(this).attr('href').slice(1) + ']').addClass('myTabPaneShow')
                        .siblings('.mytab-pane').removeClass('myTabPaneShow')
                }
            })

            // OK Checkbox事件
            $('.GoodsOkCheckbox input[type=checkbox]').change(function () {
                if (this.checked) {
                    $(this).parent().siblings('div').find('a').addClass('list-group-item-success');

                    let itemID = $(this).attr('id').slice(6);

                    // 如果異常switch開著就把他關掉
                    let sw = $('#GSwitch' + itemID);
                    let switchIsChecked = sw.prop('checked');
                    if (switchIsChecked) {
                        sw.prop('checked', false).trigger('change');
                    }

                    let itemDetailDivs = $(this).parent().parent().find('a').children('div.row').children();
                    let itemName = $(itemDetailDivs[0]).text();
                    let totalQ = $(itemDetailDivs[1]).text();

                    // 處理CorrectList
                    let correctIsExist = false;
                    for (var item of CorrectList) {
                        if (item.ItemID == itemID) {
                            item.ActualQuantity = item.TotalQuantity;
                            correctIsExist = true;
                            break;
                        }
                    }

                    if (!correctIsExist) {
                        CorrectList.push({
                            ItemID: itemID,
                            Name: itemName,
                            TotalQuantity: Number(totalQ),
                            ActualQuantity: Number(totalQ)
                        });
                    }

                    // 修改實際到貨
                    $(itemDetailDivs[3]).text($(itemDetailDivs[1]).text());
                } else {
                    $(this).parent().siblings('div').find('a').removeClass('list-group-item-success');

                    let itemDetailDivs = $(this).parent().parent().find('a').children('div.row').children();
                    $(itemDetailDivs[3]).text('--');
                }
            })

            // 異常數量更改
            $("input[id^=ErrQuantity]").change(function () {
                let num = Number($(this).val());
                let quanDiv = $('.ChekGoodsListGroup').find('a[href$=ID' + $(this).attr('id').slice(11) + ']')
                    .children('.row').children('div')[1];
                let maxNum = Number($(quanDiv).text());
                if (num <= 0)
                    $(this).val("1")
                else if (num > maxNum)
                    $(this).val(maxNum)
                else if (!Number.isInteger(num))
                    $(this).val(Math.floor(num))
            });

            // 異常的確定按鈕事件
            $('.ErrorSwitchField button').click(function () {
                let itemName = $(this).parent().parent().children('h5').text();
                let radioVal = $(this).parent().find('input[type=radio][name^=err]:checked').val();
                let errQuantity = $(this).parent().find('input[type=number][name^=ErrQua]').val();
                let errRemark = $(this).parent().find('input[type=text][name=ErrRemark]').val();

                let itemID = $(this).parent().parent().attr('id').slice(2);

                // 處理ErrorTempList
                let isExist = false;
                for (var item of ErrorTempList) {
                    if (item.ItemID == itemID) {
                        item.ErrorCode = Number(radioVal);
                        item.Quantity = Number(errQuantity);
                        item.Remark = errRemark;

                        RefreshTempList();

                        isExist = true;
                        break;
                    }
                }

                if (!isExist) {
                    ErrorTempList.push({
                        ItemID: itemID,
                        Name: itemName,
                        ErrorCode: Number(radioVal),
                        Quantity: Number(errQuantity),
                        Remark: errRemark
                    });
                    RefreshTempList();
                }

                // 處理CorrectList
                let correctIsExist = false;
                for (var item of CorrectList) {
                    if (item.ItemID == itemID) {
                        item.ActualQuantity = item.TotalQuantity - Number(errQuantity);
                        correctIsExist = true;
                        break;
                    }
                }

                let quanDivs = $('.ChekGoodsListGroup').find('a[href$=ID' + itemID + ']')
                    .children('.row').children('div');
                let totalQ = Number($(quanDivs[1]).text());

                if (!correctIsExist) {
                    CorrectList.push({
                        ItemID: itemID,
                        Name: itemName,
                        TotalQuantity: Number(totalQ),
                        ActualQuantity: Number(totalQ) - Number(errQuantity)
                    });
                }

                // 修改ItemList的實際到貨
                $(quanDivs[3]).text(totalQ - errQuantity);
            });

            // 當confirmModal按鈕按下時
            $('#confirmModalBtn').click(function () {

                let totalCount = $('.ChekGoodsListGroup').find('a[href^="#ID"]').length;
                let successCount = $('.ChekGoodsListGroup').find('.GoodsOkCheckInput:checked').length;
                let errCount = ErrorTempList.length;

                if (successCount + errCount != totalCount) {
                    $('.saveAlert').addClass('alertShow');
                } else {
                    $('.saveAlert').removeClass('alertShow');

                    // Modal中的入庫確認
                    $('#confirmModalItemCheck').html('');
                    for (var item of CorrectList) {
                        $('#confirmModalItemCheck').append('<p><b>' + item.Name + ':</b> <span>' + item.ActualQuantity + '</span></p>')
                    }

                    // Modal中的補貨訂單確認
                    if (ErrorTempList.length != 0) {
                        $('#confirmModalOrderSpan').replaceWith('\
                        <div class="modal-header"><h5 class="modal-title">以下將建立補貨訂單</h5></div>\
                            <div class="modal-body" id="confirmModalOrderCheck"></div>');

                        $('#confirmModalOrderCheck').html('');
                        for (var item of ErrorTempList) {
                            $('#confirmModalOrderCheck').append('<p><b>' + item.Name + ':</b> <span>' + item.Quantity + '</span></p>')
                        }

                    }

                    confirmModal.show();
                }
            });

            // Submit時
            $('form').submit(function (event) {
                let CheckedGoodsJSON = JSON.stringify(CorrectList);
                let ErrorGoodsJSON = JSON.stringify(ErrorTempList);

                $('input[id$=HFCheckedGoods]').val(CheckedGoodsJSON);
                $('input[id$=HFErrorGoods]').val(ErrorGoodsJSON);
            });

        })
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:HiddenField ID="HFCheckedGoods" runat="server" />
    <asp:HiddenField ID="HFErrorGoods" runat="server" />

    <div class="row" style="height: auto;">
        <div class="ChekGoodsList col-7">
            <div class="list-group ChekGoodsListGroup">

                <%-- 標頭單號 --%>
                <asp:Literal ID="ltlTitleID" runat="server"></asp:Literal>

                <div class="offset-md-1">
                    <a class="list-group-item disabled" href="#">
                        <div class="row">
                            <div class="col-6">
                                <small>專輯名稱</small>
                            </div>
                            <div class="col-2">
                                <small>數量</small>
                            </div>
                            <div class="col-2">
                                <small>單價</small>
                            </div>
                            <div class="col-2">
                                <small>實際到貨</small>
                            </div>
                        </div>
                    </a>
                </div>

                <%-- 左邊的ItemList --%>
                <asp:Literal ID="ltlItemList" runat="server" EnableViewState="false"></asp:Literal>

            </div>
        </div>

        <div class="mytab-content col-5" id="CheckGoodsTabPane">

            <%-- 右邊隱藏的細項Tab Pane --%>
            <asp:Literal ID="ltlTabPane" runat="server"></asp:Literal>

        </div>
    </div>
    <div class="row">
        <div class="col-7 ErrorTempList">
            <div class="list-group offset-md-1">
                <a class="list-group-item disabled" href="#">
                    <div class="row">
                        <div class="col-5">
                            <small>專輯名稱</small>
                        </div>
                        <div class="col-2">
                            <small>異常</small>
                        </div>
                        <div class="col-2">
                            <small>數量</small>
                        </div>
                        <div class="col-3">
                            <small>備註</small>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
            <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                <path
                    d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
            </symbol>
        </svg>

        <div class="col-4 createCancelBtn">
            <div class="alert alert-danger d-flex align-items-center saveAlert" role="alert">
                <svg class="bi flex-shrink-0 me-2" width="20" height="20" role="img" aria-label="Danger:">
                    <use xlink:href="#exclamation-triangle-fill" />
                </svg>
                <div>仍有貨未點!</div>
            </div>
            <input type="button" class="btn btn-outline-success" value="商品入庫" id="confirmModalBtn"><br>
            <a type="button" class="btn btn-outline-secondary" href="OrderList.aspx" role="button">取消</a>
        </div>

        <div class="modal fade" id="ConfirmModal" tabindex="-1" aria-labelledby="confirmModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">以下商品將入庫</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="confirmModalItemCheck">
                    </div>

                    <span id="confirmModalOrderSpan"></span>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <asp:Button ID="btnConfirm" runat="server" Text="確定" CssClass="btn btn-primary" OnClick="btnConfirm_Click" />
                        <%--<button type="button" class="btn btn-primary">確定</button>--%>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
