<%@ Page Title="薛丁格-新增員工" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="NewStaff.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.NewStaff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script src="../../Scripts/customize/popper.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="../../StyleSheet/NewStaffStyle.css" rel="stylesheet" />

    <style>
        #btnLevel ~ .invalid-feedback, #btnBlood ~ .invalid-feedback {
            margin-top: -1.5rem;
            position: absolute;
            z-index: 50;
        }
    </style>


    <script src="../../Scripts/customize/Validation.js"></script>
    <script>

        $(function () {
            $('form').submit(function (event) {

                $('#btnLevel').siblings('ul').click(function () {
                    if ($('#btnLevel').text() == '職位') {
                        $('#btnLevel').siblings('.valid-feedback').css('display', 'none')
                            .siblings('.invalid-feedback').css('display', 'block');
                        event.preventDefault()
                        event.stopPropagation()
                    } else {
                        $('#btnLevel').siblings('.valid-feedback').css('display', 'block')
                            .siblings('.invalid-feedback').css('display', 'none');
                    }
                }).trigger('click');

                $('#btnBlood + ul').click(function () {
                    if ($('#btnBlood').text() == '血型') {
                        $('#btnBlood').siblings('.valid-feedback').css('display', 'none')
                            .siblings('.invalid-feedback').css('display', 'block');
                        event.preventDefault()
                        event.stopPropagation()
                    } else {
                        $('#btnBlood').siblings('.valid-feedback').css('display', 'block')
                            .siblings('.invalid-feedback').css('display', 'none');
                    }
                }).trigger('click');

                // Check所有.myValidation是否通過
                if (!$('input.myValidation').toArray().every(CheckHasValid)) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                let dateStr = $("#startDate").val();
                let LV = $("#btnLevel").text();
                let Blood = $("#btnBlood").text();

                var lv = "";
                if (LV == "主管") {
                    lv = 0;
                } else if (LV == "兼職員工") {
                    lv = 1;
                } else {
                    lv = 2;
                }



                $("input[id$=HD_StartDate]").val(dateStr);

                $("input[id$=HD_LVAndBlood]").val(lv + "," + Blood);
            })

            //let dateStr = $("#startDate").val();
            //let startDate = new Date(dateStr);
            //let now = new Date(Date.now());
            //let strict = new Date("1960-01-01");
            //let LV = $("#btnLevel").text();
            //let Blood = $("#btnBlood").text();


            //if (startDate > now) {
            //    $("#ltlMsg").html("入職日期不可大於今天");
            //    event.preventDefault();
            //    event.stopPropagation();
            //}
            //if (startDate < strict) {
            //    $("#spanMsg").html("日期不可小於1960-01-01");
            //    event.preventDefault();
            //    event.stopPropagation();
            //}
            //if (!form.checkValidity()) {
            //    event.preventDefault()
            //    event.stopPropagation()
            //}
            //var lv = "";
            //if (LV == "主管") {
            //    lv = 0;
            //} else if (LV == "兼職員工") {
            //    lv = 1;
            //} else {
            //    lv = 2;
            //}



            //$("input[id$=HD_StartDate]").val(dateStr);

            //$("input[id$=HD_LVAndBlood]").val(lv + "," + Blood);




            $('li').click(function () {
                $(this).parent().siblings("button").text($(this).text());
            })
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="user__title">請輸入員工資本資料並設定帳號密碼</h1>

    <div class="containerDiv2 col-sm-12 col-md-12">
        <div class="row" id="DIO">

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputName" CssClass="form-control form-control1 form__input myValidation validateTextLength" runat="server" min="1" max="50"></asp:TextBox>
                <asp:Label ID="lblName" AssociatedControlID="txtInputName" runat="server">請輸入姓名</asp:Label>
                <div class="invalid-feedback"></div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputAccount" runat="server" CssClass="form-control form__input myValidation validateTextLength" min="5" max="12"></asp:TextBox>
                <asp:Label ID="lblAccount" AssociatedControlID="txtInputAccount" runat="server">請輸入帳號</asp:Label>
                <div class="invalid-feedback"></div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputPassword" CssClass="form-control form__input myValidation validateTextLength validateAlphNumOnly" min="5" max="16" runat="server"></asp:TextBox>
                <asp:Label ID="lblPassword" AssociatedControlID="txtInputPassword" runat="server" Text="Label">請輸入密碼</asp:Label>
                <div class="invalid-feedback"></div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputMail" CssClass="form-control form__input myValidation validateEmail" runat="server"></asp:TextBox>
                <asp:Label ID="lblMail" AssociatedControlID="txtInputMail" runat="server" Text="Label">請輸入電子郵件</asp:Label>
                <div class="invalid-feedback"></div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputTel" CssClass="form-control form__input myValidation validateTextLength validateNumOnly" min="10" max="10" runat="server"></asp:TextBox>
                <asp:Label ID="lblTel" AssociatedControlID="txtInputTel" runat="server" Text="Label">請輸入電話號碼</asp:Label>
                <div class="invalid-feedback"></div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating" style="align-items: center;">
                <button id="btnLevel" type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown">職位</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">主管</a></li>
                    <li><a class="dropdown-item" href="#">全職</a></li>
                    <li><a class="dropdown-item" href="#">兼職</a></li>
                </ul>
                <div class="invalid-feedback">請選擇職位</div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating" style="align-items: center;">
                <button id="btnBlood" type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown">血型</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">A</a></li>
                    <li><a class="dropdown-item" href="#">B</a></li>
                    <li><a class="dropdown-item" href="#">AB</a></li>
                    <li><a class="dropdown-item" href="#">O</a></li>
                </ul>
                <div class="invalid-feedback">請選擇血型</div>
                <div class="valid-feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form-item ">
                <input type="date" class="form-control form-control2 form__input myValidation validateDate" id="startDate" placeholder="到職日期">
                <div class="invalid-feedback"></div>
                <div class="valid-feedback"></div>
            </div>


            <asp:HiddenField ID="HD_StartDate" runat="server" />
            <asp:HiddenField ID="HD_LVAndBlood" runat="server" />

            <div class="col-12" style="text-align: center">

                <asp:Button ID="btnNewStaff" runat="server" Text="建立" class="btn btn-outline-primary" Style="width: 6rem; height: 2.5rem;" OnClick="btnNewStaff_Click" />

                <a class="btn btn-outline-secondary " href="/SystemBackEnd/UserInfo/StaffInfo.aspx" role="button" style="width: 6rem; height: 2.5rem;">取消</a>
                <br />
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>

        </div>
    </div>



</asp:Content>
