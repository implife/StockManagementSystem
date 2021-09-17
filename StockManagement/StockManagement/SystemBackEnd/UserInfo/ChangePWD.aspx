<%@ Page Title="薛丁格-更改密碼" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="ChangePWD.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.ChangePWD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../StyleSheet/UserEditorStyle.css" rel="stylesheet" />
    <script src="../../Scripts/customize/Validation.js"></script>
    <script>
        $('form').submit(function () {

            $('input[id$=txtInputOldPWD] input[id$=txtInputNewPWD]').on('keyup', function () {

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


            $('input[id$=txtCheckPWD]').on('keyup', function () {
                var NP = $('input[id$=txtInputNewPWD]').val();
                var CP = $('input[id$=txtCheckPWD]').val();

                if (NP != CP) {

                    $(this).siblings('.invalid-feedback').html("請輸入相同密碼");

                    ChangeInvalid($(this));

                } else {

                    ChangeValid($(this));

                }
            }).trigger('keyup');


            if (!$('input.myValidation').toArray().every(CheckHasValid)) {
                event.preventDefault()
                event.stopPropagation()
            }

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="user__title">修改個人資料</h1>

    <div class="containerDiv3 col-sm-12 col-md-12">
        <div class="row" id="DIO">

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputOldPWD" CssClass="form-control form-control1 form__input myValidation validateNullWhiteSpace" runat="server" TextMode="Password"></asp:TextBox>
                <asp:Label ID="lblOldPWD" AssociatedControlID="txtInputOldPWD" runat="server">請輸入舊密碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputNewPWD" CssClass="form-control form-control1 form__input myValidation validateNullWhiteSpace" runat="server" TextMode="Password"></asp:TextBox>
                <asp:Label ID="lblNewWD" AssociatedControlID="txtInputNewPWD" runat="server">請輸入密碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtCheckPWD" runat="server" CssClass="form-control form__input myValidation" TextMode="Password"></asp:TextBox>
                <asp:Label ID="lblCheckPWD" AssociatedControlID="txtCheckPWD" runat="server">請再次輸入密碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>
        </div>
    </div>

    <div class="col-12" style="text-align: center; margin-top: 1rem;">

        <asp:Button ID="btnSubmit" runat="server" Text="確認" class="btn btn-outline-success " Style="width: 6rem; height: 2.5rem; margin-top: 1.5rem;" OnClick="btnSubmit_Click" />

        <a class="btn btn-outline-secondary btn_Cancel" href="/SystemBackEnd/UserInfo/UserInfo.aspx" role="button" style="width: 6rem; height: 2.5rem; margin-top: 1.5rem; line-height: 1.7;">取消</a>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <asp:Literal ID="ltlModal" runat="server"></asp:Literal>
    </div>
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

        
    <div class="modal fade" id="resultModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">舊密碼錯誤</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>



    <asp:Literal ID="Literal1" runat="server">

    </asp:Literal>
</asp:Content>
