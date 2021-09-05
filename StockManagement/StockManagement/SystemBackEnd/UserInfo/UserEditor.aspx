<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="UserEditor.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script src="../../Scripts/customize/popper.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
    <link href="../../StyleSheet/UserEditorStyle.css" rel="stylesheet" />
    <script>

        $(function () {
            $("form").addClass("needs-validation");
            $("#DIO input").prop("required", true);



            (function () {
                'use strict'
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            let Blood = $("#btnBlood").text();
                            console.log(dateStr)
                            $("input[id$=HD_Blood]").val(lv + "," + Blood);
                            form.classList.add('was-validated')
                        }, false)
                    }
                    )
            })()

            $('li').click(function () {
                console.log("WWWWWWWWWWWWWWWWWWWWW")
                $(this).parent().siblings("button").text($(this).text());
            })
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="user__title">修改個人資料</h1>

    <div class="containerDiv2 col-sm-12 col-md-12">
        <div class="row" id="DIO">
            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputName" CssClass="form-control form-control1 form__input" runat="server"></asp:TextBox>
                <asp:Label ID="lblName" AssociatedControlID="txtInputName" runat="server">請輸入姓名</asp:Label>
                <div class="invalid-feedback">請輸入姓名</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputAccount" runat="server" class="form-control form__input"></asp:TextBox>
                <asp:Label ID="lblAccount" AssociatedControlID="txtInputAccount" runat="server">請輸入帳號</asp:Label>
                <div class="invalid-feedback">請輸入帳號</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputMail" CssClass="form-control form__input" runat="server"></asp:TextBox>
                <asp:Label ID="lblMail" AssociatedControlID="txtInputMail" runat="server" Text="Label">請輸入電子郵件</asp:Label>
                <div class="invalid-feedback">請輸入電子郵件</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputTel" CssClass="form-control form__input" runat="server"></asp:TextBox>
                <asp:Label ID="lblTel" AssociatedControlID="txtInputTel" runat="server" Text="Label">請輸入電話號碼</asp:Label>
                <div class="invalid-feedback">請輸入電話號碼</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputPassword" CssClass="form-control form__input" runat="server"></asp:TextBox>
                <asp:Label ID="lblPassword" AssociatedControlID="txtInputPassword" runat="server" Text="Label">請輸入密碼</asp:Label>
                <div class="invalid-feedback">請輸入密碼</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating">
                <asp:TextBox ID="txtInputCheckPWD" CssClass="form-control form__input" runat="server"></asp:TextBox>
                <asp:Label ID="lblInputCheckPWD" AssociatedControlID="txtInputCheckPWD" runat="server" Text="Label">請再次輸入密碼</asp:Label>
                <div class="invalid-feedback">請再次輸入密碼</div>
            </div>

            <div class="col-sm-12 col-md-12 form__group form-floating" style="align-items: center;">
                <button id="btnBlood" type="button" class="btn btn-success dropdown-toggle btn-Blood" data-bs-toggle="dropdown">血型</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">A</a></li>
                    <li><a class="dropdown-item" href="#">B</a></li>
                    <li><a class="dropdown-item" href="#">AB</a></li>
                    <li><a class="dropdown-item" href="#">O</a></li>
                </ul>
            </div>

            <asp:HiddenField ID="Blood" runat="server" />

            <div class="col-12" style="text-align: center">

                <asp:Button ID="btnNewStaff" runat="server" Text="確認" class="btn btn-outline-primary" Style="width: 6rem; height: 2.5rem; margin-top: 1rem;" OnClick="btnNewStaff_Click" />

                <a class="btn btn-outline-secondary " href="/SystemBackEnd/UserInfo/StaffInfo.aspx" role="button" style="width: 6rem; height: 2.5rem; margin-top: 1rem">取消</a>
                <br />
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
