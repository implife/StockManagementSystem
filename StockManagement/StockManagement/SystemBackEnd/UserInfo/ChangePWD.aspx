<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="ChangePWD.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.ChangePWD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="user__title">修改個人資料</h1>

    <div class="containerDiv2 col-sm-12 col-md-12">
        <div class="row" id="DIO">

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputOldPWD" CssClass="form-control form-control1 form__input myValidation validateNullWhiteSpace" runat="server"></asp:TextBox>
                <asp:Label ID="Label1" AssociatedControlID="txtInputName" runat="server">請輸入舊密碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputNewPWD" CssClass="form-control form-control1 form__input myValidation validateNullWhiteSpace" runat="server"></asp:TextBox>
                <asp:Label ID="lblName" AssociatedControlID="txtInputName" runat="server">請輸入密碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtCheckPWD" runat="server" CssClass="form-control form__input myValidation"></asp:TextBox>
                <asp:Label ID="lblAccount" AssociatedControlID="txtInputAccount" runat="server">請再次輸入密碼</asp:Label>
                <div class="invalid-feedback feedback"></div>
                <div class="valid-feedback feedback"></div>
            </div>
        </div>
    </div>

    <div class="col-12" style="text-align: center; margin-top: 1rem;">

        <asp:Button ID="btnSubmit" runat="server" Text="確認" class="btn btn-outline-success " Style="width: 6rem; height: 2.5rem; margin-top: 1.5rem;" OnClick="btnSubmit_Click" />

        <a class="btn btn-outline-secondary btn_Cancel" href="/SystemBackEnd/UserInfo/UserInfo.aspx" role="button" style="width: 6rem; height: 2.5rem; margin-top: 1.5rem; line-height: 1.7;">取消</a>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>

</asp:Content>
