<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="UserEditor.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script src="../../Scripts/customize/popper.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="../../StyleSheet/UserEditorStyle.css" rel="stylesheet" />
    <script src="../../Scripts/customize/Validation.js"></script>
    <script>
        $(function () {
            $('li').click(function () {
                $(this).parent().siblings("button").text($(this).text());
                $('input[ID$="HD_Blood"]').val($(this).text())
            })

            $('form').submit(function () {

                $('input[id$=txtInputAccount]').on('keyup', function () {

                    $(this).val($(this).val().trim());

                    let result = validateTxtWidth($(this).val(), 5, 12);

                    if (!result.isValid) {

                        $(this).siblings('.invalid-feedback').html(result.msg);

                        ChangeInvalid($(this));

                    } else {

                        ChangeValid($(this));

                    }

                    let result2 = validateTxtContext($(this).val());
                    if (result.isValid) {
                        if (!result2.isValid) {

                            $(this).siblings('.invalid-feedback').html(result2.msg);

                            ChangeInvalid($(this));

                        } else {

                            ChangeValid($(this));

                        }
                    }
                }).trigger('keyup');
                $('input[id$=txtInputTel]').on('keyup', function () {

                    $(this).val($(this).val().trim());

                    let result = validateTxtWidth($(this).val(), 10, 10);

                    if (!result.isValid) {

                        $(this).siblings('.invalid-feedback').html(result.msg);

                        ChangeInvalid($(this));

                    } else {

                        ChangeValid($(this));

                    }

                    let result2 = validateTxtContext($(this).val(), alphabet = false);
                    if (result.isValid) {
                        if (!result2.isValid) {

                            $(this).siblings('.invalid-feedback').html(result2.msg);

                            ChangeInvalid($(this));

                        } else {

                            ChangeValid($(this));

                        }
                    }
                }).trigger('keyup');
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">修改失敗,請重新填寫</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>

    <asp:Literal ID="ltlModal" runat="server">

    </asp:Literal>

    <h1 class="user__title">修改個人資料</h1>

    <div class="containerDiv2 col-sm-12 col-md-12">
        <div class="row" id="DIO">

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputName" CssClass="form-control form-control1 form__input myValidation validateNullWhiteSpace" runat="server"></asp:TextBox>
                <asp:Label ID="lblName" AssociatedControlID="txtInputName" runat="server">請輸入姓名</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputAccount" runat="server" CssClass="form-control form__input myValidation"></asp:TextBox>
                <asp:Label ID="lblAccount" AssociatedControlID="txtInputAccount" runat="server">請輸入帳號</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputMail" CssClass="form-control form__input myValidation validateEmail" runat="server"></asp:TextBox>
                <asp:Label ID="lblMail" AssociatedControlID="txtInputMail" runat="server">請輸入電子郵件</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputTel" CssClass="form-control form__input myValidation" runat="server"></asp:TextBox>
                <asp:Label ID="lblTel" AssociatedControlID="txtInputTel" runat="server">請輸入電話號碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <%--<div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputPWD" CssClass="form-control form__input myValidation" runat="server"></asp:TextBox>
                <asp:Label ID="Label1" AssociatedControlID="txtInputPWD" runat="server">請輸入密碼</asp:Label>
                <div class="invalid-feedback feedback">請輸入密碼</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputCheckPWD" CssClass="form-control form__input myValidation" runat="server"></asp:TextBox>
                <asp:Label ID="lblInputCheckPWD" AssociatedControlID="txtInputCheckPWD" runat="server">請再次輸入密碼</asp:Label>
                <div class="invalid-feedback feedback">請再次輸入密碼</div>
            </div>--%>

            <div class="col-sm-12 col-md-12 form__group form-floating" style="align-items: center;">
                <div class="row">
                    <div class="col-2 offset-md-1 divChoose"><span>請選擇血型</span></div>
                    <div class="col-9 divbotton">
                        <asp:Literal ID="ltlBlood" runat="server"></asp:Literal>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">A</a></li>
                            <li><a class="dropdown-item" href="#">B</a></li>
                            <li><a class="dropdown-item" href="#">AB</a></li>
                            <li><a class="dropdown-item" href="#">O</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="HD_Blood" runat="server" />

            <div class="col-12" style="text-align: center; margin-top: 1rem;">

                <asp:Button ID="btnSubmit" runat="server" Text="確認" class="btn btn-outline-success " Style="width: 6rem; height: 2.5rem; margin-top: 1.5rem;" OnClick="btnSubmit_Click" />

                <a class="btn btn-outline-secondary btn_Cancel" href="/SystemBackEnd/UserInfo/UserInfo.aspx" role="button" style="width: 6rem; height: 2.5rem; margin-top: 1.5rem; line-height: 1.7;">取消</a>

                <a class="btn btn-outline-secondary btn_ChangePWD" href="/SystemBackEnd/UserInfo/ChangePWD.aspx" role="button" style="width: 6rem; height: 2.5rem; margin-top: 1.5rem; line-height: 1.7;">更改密碼</a>
                <br />
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
